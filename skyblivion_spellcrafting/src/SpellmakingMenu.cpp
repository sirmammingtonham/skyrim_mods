#include "PCH.h"

#include "Spellmaking.h"
#include "SpellmakingMenu.h"

#include <map>

#include "CLIK/Array.h"

namespace Scaleform
{
	namespace
	{
		Slider::Slider() :
			header(),
			slider(),
			text(),
			_isDragging(false)
		{}


		void Slider::UpdateText()
		{
			auto num = static_cast<std::ptrdiff_t>(slider.Value());
			auto val = std::to_string(num);
			text.HTMLText(val);
		}


		void Slider::SetDragging(bool a_isDragging)
		{
			_isDragging = a_isDragging;
		}


		bool Slider::IsDragging() const
		{
			return _isDragging;
		}
	}


	SpellmakingMenu::SpellmakingMenu() :
		_available(),
		_range(),
		_type(),
		_magnitude(),
		_duration(),
		_area(),
		_effectMap(),
		_name(),
		_price(),
		_gold(),
		_selectedName(""),
		_includeKeyword(RE::TESForm::LookupByEditorID<RE::BGSKeyword>("_SpellcraftingAvailable"))
	{
		using Context = RE::UserEvents::INPUT_CONTEXT_ID;
		using Flag = RE::IMenu::Flag;

		menuFlags.set(Flag::kUpdateUsesCursor);
		auto loader = RE::BSScaleformManager::GetSingleton();
		auto success = loader->LoadMovieEx(this, SWF_NAME, [this](RE::GFxMovieDef* a_def) {
			using StateType = RE::GFxState::StateType;

			fxDelegate.reset(new RE::FxDelegate());
			fxDelegate->RegisterHandler(this);
			a_def->SetState(StateType::kExternalInterface, fxDelegate.get());
			fxDelegate->Release();

			//auto logger = new Logger<SpellmakingMenu>();
			//a_def->SetState(StateType::kLog, logger);
			//logger->Release();

			a_def->SetState(
				RE::GFxState::StateType::kLog,
				RE::make_gptr<Logger<SpellmakingMenu>>().get());
		});

		if (!success) {
			assert(false);
			logger::critical("SpellmakingMenu did not have a view due to missing dependencies! Aborting process!\n");
			std::abort();
		}

		depthPriority = 5;	// JournalMenu == 5
		menuFlags.set(Flag::kDisablePauseMenu, Flag::kUsesCursor, Flag::kTopmostRenderedMenu, Flag::kPausesGame);
		inputContext = Context::kFavor;

		InitExtensions();
		uiMovie->SetVisible(false);
	}


	void SpellmakingMenu::Accept(RE::FxDelegateHandler::CallbackProcessor* a_processor)
	{
		a_processor->Process("Log", Log);
		a_processor->Process("OnRangePress", OnRangePress);
		a_processor->Process("OnTypePress", OnTypePress);
		a_processor->Process("OnTextFocus", OnTextFocus);
		a_processor->Process("OnTextUnfocus", OnTextUnfocus);
		a_processor->Process("OnAvailablePress", OnAvailablePress);
		a_processor->Process("OnMagnitudeDragBegin", OnMagnitudeDragBegin);
		a_processor->Process("OnMagnitudeDragEnd", OnMagnitudeDragEnd);
		a_processor->Process("OnMagnitudeChange", OnMagnitudeChange);
		a_processor->Process("OnDurationDragBegin", OnDurationDragBegin);
		a_processor->Process("OnDurationDragEnd", OnDurationDragEnd);
		a_processor->Process("OnDurationChange", OnDurationChange);
		a_processor->Process("OnAreaDragBegin", OnAreaDragBegin);
		a_processor->Process("OnAreaDragEnd", OnAreaDragEnd);
		a_processor->Process("OnFilterPress", OnFilterPress);
		a_processor->Process("OnAreaChange", OnAreaChange);
		a_processor->Process("CraftSpell", CraftSpell);
		a_processor->Process("OnCancelPress", OnCancelPress);
		a_processor->Process("CloseMenu", CloseMenu);
	}


	auto SpellmakingMenu::ProcessMessage(RE::UIMessage& a_message)
		-> Result
	{
		using Message = RE::UI_MESSAGE_TYPE;

		switch (*a_message.type) {
		case Message::kShow:
			OnMenuOpen();
			return Result::kHandled;
		case Message::kHide:
			OnMenuClose();
			return Result::kHandled;
		default:
			return Base::ProcessMessage(a_message);
		}
	}


	void SpellmakingMenu::AdvanceMovie(float a_interval, uint32_t a_currentTime)
	{
		if (_magnitude.IsDragging()) {
			_magnitude.UpdateText();
		}

		if (_duration.IsDragging()) {
			_duration.UpdateText();
		}

		if (_area.IsDragging()) {
			_area.UpdateText();
		}

		Base::AdvanceMovie(a_interval, a_currentTime);
	}

	SpellmakingMenu::CraftConfirmCallback::CraftConfirmCallback(
		SpellmakingMenu* menu) :
		_menu(menu)
	{
	}

	void SpellmakingMenu::CraftConfirmCallback::Run(Message message)
	{
		// 4 = OK, however commonlibSSE does not have this message type defined, so just casting it as an int for now
		if (static_cast<uint32_t>(message) != 4) {
			return;
		}

		auto player = RE::PlayerCharacter::GetSingleton();
		auto spell = Spellmaking::GetCraftedSpell();
		auto gold = static_cast<RE::TESBoundObject*>(RE::TESForm::LookupByID(0x0000000F));

		player->RemoveItem(gold, spell->GetGoldValue(), RE::ITEM_REMOVE_REASON::kSelling, &player->extraList, nullptr);
		player->AddSpell(spell);
		RE::PlaySound("UISpellLearned");
		Spellmaking::QueueSpellSave(spell);
	}


	void SpellmakingMenu::Open()
	{
		auto uiQueue = RE::UIMessageQueue::GetSingleton();
		uiQueue->AddMessage(Name(), RE::UI_MESSAGE_TYPE::kShow, 0);
	}


	void SpellmakingMenu::Close()
	{
		auto uiQueue = RE::UIMessageQueue::GetSingleton();
		uiQueue->AddMessage(Name(), RE::UI_MESSAGE_TYPE::kHide, 0);
	}


	void SpellmakingMenu::Register()
	{
		auto ui = RE::UI::GetSingleton();
		ui->Register(Name(), Create);

		logger::info("Registered {} (pls work)", Name().data());
	}


	RE::IMenu* SpellmakingMenu::Create()
	{
		return new SpellmakingMenu();
	}


	void SpellmakingMenu::Log(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 1);
		if (a_params[0].IsUndefined()) {
			logger::info("{} swf: undefined log", Name().data());
			return;
		}
		assert(a_params[0].IsString());

		logger::info("{} swf: {}", Name().data(), a_params[0].GetString());
	}

	void SpellmakingMenu::OnCancelPress([[maybe_unused]] const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		Close();
	}

	void SpellmakingMenu::OnRangePress(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 1);
		assert(a_params[0].IsNumber());

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->OnRangeChange(static_cast<int>(a_params[0].GetNumber()));
	}

	void SpellmakingMenu::OnTypePress(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 1);
		assert(a_params[0].IsNumber());

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->OnTypeChange(static_cast<int>(a_params[0].GetNumber()));
	}

	void SpellmakingMenu::OnTextFocus([[maybe_unused]] const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		RE::ControlMap* map = RE::ControlMap::GetSingleton();
		map->AllowTextInput(true);
	}

	void SpellmakingMenu::OnTextUnfocus(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		RE::ControlMap* map = RE::ControlMap::GetSingleton();
		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		map->AllowTextInput(false);
		menu->OnTextUnfocus();
	}

	void SpellmakingMenu::OnAvailablePress(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 2);
		assert(a_params[0].IsString());
		assert(a_params[1].IsBool());

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->OnAvailablePress(a_params[0].GetString(), a_params[1].GetBool());
	}


	void SpellmakingMenu::OnMagnitudeDragBegin(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->OnMagnitudeDragChange(true);
	}


	void SpellmakingMenu::OnMagnitudeDragEnd(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->OnMagnitudeDragChange(false);
	}


	void SpellmakingMenu::OnMagnitudeChange(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->OnMagnitudeChange();
	}


	void SpellmakingMenu::OnDurationDragBegin(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->OnDurationDragChange(true);
	}


	void SpellmakingMenu::OnDurationDragEnd(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->OnDurationDragChange(false);
	}


	void SpellmakingMenu::OnDurationChange(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->OnDurationChange();
	}


	void SpellmakingMenu::OnAreaDragBegin(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->OnAreaDragChange(true);
	}


	void SpellmakingMenu::OnAreaDragEnd(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->OnAreaDragChange(false);
	}


	void SpellmakingMenu::OnAreaChange(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->OnAreaChange();
	}


	void SpellmakingMenu::CraftSpell(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->CraftSpell();
	}

	void SpellmakingMenu::OnFilterPress(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 1);
		auto filterIdx = a_params[0].GetUInt();

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->SetAvailable(filterIdx);
	}

	void SpellmakingMenu::CloseMenu(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<SpellmakingMenu*>(a_params.GetHandler());
		menu->Close();
	}


	void SpellmakingMenu::OnMenuOpen()
	{
		auto bm = RE::UIBlurManager::GetSingleton();

		// set blur
		bm->IncrementBlurCount();

		bool success;
		uiMovie->SetVisible(true);
		std::vector<std::pair<CLIK::Object*, std::string>> toGet;
		toGet.push_back(std::make_pair(&_available, "available_effects"));

		toGet.push_back(std::make_pair(&_range.selfButton, "range_self.check"));
		toGet.push_back(std::make_pair(&_range.selfHeader, "range_self.header"));
		toGet.push_back(std::make_pair(&_range.touchButton, "range_touch.check"));
		toGet.push_back(std::make_pair(&_range.touchHeader, "range_touch.header"));
		toGet.push_back(std::make_pair(&_range.areaButton, "range_area.check"));
		toGet.push_back(std::make_pair(&_range.areaHeader, "range_area.header"));

		toGet.push_back(std::make_pair(&_type.ffButton, "type_fireforget.check"));
		toGet.push_back(std::make_pair(&_type.ffHeader, "type_fireforget.header"));
		toGet.push_back(std::make_pair(&_type.concentrationButton, "type_concentration.check"));
		toGet.push_back(std::make_pair(&_type.concentrationHeader, "type_concentration.header"));


		toGet.push_back(std::make_pair(&_magnitude.header, "magnitude_header"));
		toGet.push_back(std::make_pair(&_magnitude.slider, "magnitude_slider"));
		toGet.push_back(std::make_pair(&_magnitude.text, "magnitude_text"));
		toGet.push_back(std::make_pair(&_duration.header, "duration_header"));
		toGet.push_back(std::make_pair(&_duration.slider, "duration_slider"));
		toGet.push_back(std::make_pair(&_duration.text, "duration_text"));
		toGet.push_back(std::make_pair(&_area.header, "area_header"));
		toGet.push_back(std::make_pair(&_area.slider, "area_slider"));
		toGet.push_back(std::make_pair(&_area.text, "area_text"));

		toGet.push_back(std::make_pair(&_selectedEffectHeader, "selected_name"));
		toGet.push_back(std::make_pair(&_nameHeader, "name_header"));
		toGet.push_back(std::make_pair(&_name, "name"));

		toGet.push_back(std::make_pair(&_school, "school_text"));
		toGet.push_back(std::make_pair(&_level, "level_text"));
		toGet.push_back(std::make_pair(&_magicka, "magicka_text"));
		toGet.push_back(std::make_pair(&_schoolIcon, "school_icon"));

		toGet.push_back(std::make_pair(&_price, "price_text"));
		toGet.push_back(std::make_pair(&_gold, "gold_text"));

		toGet.push_back(std::make_pair(&_craft, "craft"));
		RE::GFxValue var;
		for (auto& elem : toGet) {
			std::string root("SpellmakingMenu_mc.");
			auto element = root + elem.second;
			success = uiMovie->GetVariable(&var, element.c_str());
			if (!success) {
				logger::info("couldn't get {}", element);
				assert(success);
			}
			*elem.first = var;
		}

		CLIK::Object obj("ScrollBar");
		_available.ScrollBar(obj);

		_craft.Label("Craft");
		_craft.Disabled(true);

		auto player = RE::PlayerCharacter::GetSingleton();
		_gold.HTMLText(CommatizeNumber(player->GetGoldAmount()));

		InitEffectInfo();
		InitAvailable();
		SetEffectInfo();
	}


	void SpellmakingMenu::OnMenuClose()
	{
		auto bm = RE::UIBlurManager::GetSingleton();
		bm->DecrementBlurCount();
	}


	void SpellmakingMenu::InitExtensions()
	{
		RE::GFxValue boolean(true);
		bool success;

		success = uiMovie->SetVariable("_global.gfxExtensions", boolean);
		assert(success);
		success = uiMovie->SetVariable("_global.noInvisibleAdvance", boolean);
		assert(success);
	}


	void SpellmakingMenu::InitEffectInfo()
	{
		_range.selfHeader.HTMLText("On Self");
		_range.selfButton.Enabled(false);
		_range.touchHeader.HTMLText("On Touch");
		_range.touchButton.Enabled(false);
		_range.areaHeader.HTMLText("Area of Effect");
		_range.areaButton.Enabled(false);

		_type.ffHeader.HTMLText("Fire and Forget");
		_type.ffButton.Enabled(false);
		_type.concentrationHeader.HTMLText("Concentration");
		_type.concentrationButton.Enabled(false);

		_magnitude.header.HTMLText("Magnitude");
		_duration.header.HTMLText("Duration");
		_area.header.HTMLText("Area");

		_school.HTMLText("-");
		_schoolIcon.GetInstance().GotoAndStop("All");
		_level.HTMLText("-");
		_magicka.HTMLText("-");
		_price.HTMLText("-");

		_selectedEffectHeader.HTMLText("(none selected)");

		_nameHeader.GetInstance().GotoAndStop("static");
	}

	void SpellmakingMenu::InitAvailable()
	{
		_available.SelectedIndex(-1.0);

		auto player = RE::PlayerCharacter::GetSingleton();
		for (auto& spell : player->addedSpells) {
			for (auto& effect : spell->effects) {
				auto mgef = effect->baseEffect;
				_effectMap.insert(std::pair<std::string_view, AvailableEffect>(std::string_view(mgef->GetFullName()),
					{ .effect = mgef, .spell = spell, .magnitude = 1, .duration = 0, .area = 1, .selected = false, .display = true }));
			}
		}

		auto base = player->GetActorBase();
		if (base->actorEffects) {
			auto effects = base->actorEffects;
			for (uint32_t i = 0; i < effects->numSpells; ++i) {
				auto spell = effects->spells[i];
				for (auto& effect : spell->effects) {
					auto mgef = effect->baseEffect;
					_effectMap.insert(std::pair<std::string_view, AvailableEffect>(std::string_view(mgef->GetFullName()),
						{ .effect = mgef, .spell = spell, .magnitude = 1, .duration = 0, .area = 1, .selected = false, .display = true }));
				}
			}
		}

		SetAvailable(0);
	}


	void SpellmakingMenu::SetAvailable(size_t filter)
	{
		_available.SelectedIndex(-1.0);

		auto spellAvailable = [this](const AvailableEffect& available, size_t filter) {
			using av = RE::ActorValue;
			auto effect = available.effect;
			if (!effect->HasKeyword(_includeKeyword)) {
				return false;
			}
			switch (filter) {
			case 0:
				if (effect->GetMagickSkill() != RE::ActorValue::kNone) {
					return true;
				}
				return false;
			case 1:
				return effect->GetMagickSkill() == av::kAlteration;
			case 2:
				return effect->GetMagickSkill() == av::kIllusion;
			case 3:
				return effect->GetMagickSkill() == av::kDestruction;
			case 4:
				return effect->GetMagickSkill() == av::kConjuration;
			case 5:
				return effect->GetMagickSkill() == av::kRestoration;
			case 6:
				return available.selected;
			default:
				logger::error("???");
				return false;
			}
		};


		CLIK::Array arr(uiMovie);
		CLIK::Object elem;

		RE::GFxValue school;
		RE::GFxValue effectName;
		RE::GFxValue selected;
		RE::GFxValue obj;

		// iterate through effects, check against filter, display those that pass, hide those that don't
		for (auto& entry : _effectMap) {
			auto available = entry.second;
			if (spellAvailable(available, filter)) {
				uiMovie->CreateObject(&obj);
				school.SetNumber(static_cast<double>(available.effect->GetMagickSkill()));

				std::string name(available.effect->GetFullName());
				SanitizeString(name);
				effectName.SetString(name);

				selected.SetBoolean(available.selected);

				obj.SetMember("school", school);
				obj.SetMember("effectName", effectName);
				obj.SetMember("selected", selected);
				elem = obj;
				arr.Push(elem);
				available.display = true;
			} else {
				available.display = false;
			}
		}

		_available.DataProvider(arr);
	}


	void SpellmakingMenu::SetEffectInfo()
	{
		if (_effectMap.contains(_selectedName)) {
			auto& selectedEffect = _effectMap[_selectedName];

			using EffectFlag = RE::EffectSetting::EffectSettingData::Flag;

			if ((selectedEffect.effect->data.flags & EffectFlag::kNoMagnitude) == EffectFlag::kNone) {
				_magnitude.slider.Disabled(false);
				_magnitude.slider.Value(selectedEffect.magnitude);
				_magnitude.text.HTMLText(std::to_string(selectedEffect.magnitude));
			} else {
				_magnitude.slider.Disabled(true);
				_magnitude.slider.Value(0);
				_magnitude.text.HTMLText("-");
			}
			if ((selectedEffect.effect->data.flags & EffectFlag::kNoDuration) == EffectFlag::kNone) {
				_duration.slider.Disabled(false);
				_duration.slider.Value(selectedEffect.duration);
				_duration.text.HTMLText(std::to_string(selectedEffect.duration));
			} else {
				_duration.slider.Disabled(true);
				_duration.slider.Value(0);
				_duration.text.HTMLText("-");
			}
			if ((selectedEffect.effect->data.flags & EffectFlag::kNoArea) == EffectFlag::kNone) {
				_area.slider.Disabled(false);
				_area.slider.Value(selectedEffect.area);
				_area.text.HTMLText(std::to_string(selectedEffect.area));
			} else {
				_area.slider.Disabled(true);
				_area.slider.Value(0);
				_area.text.HTMLText("-");
			}

			UpdateInfo();
		} else {
			_magnitude.slider.Disabled(true);
			_magnitude.text.HTMLText("-");

			_duration.slider.Disabled(true);
			_duration.text.HTMLText("-");

			_area.slider.Disabled(true);
			_area.text.HTMLText("-");

			_selectedEffectHeader.HTMLText("(none selected)");
		}

		if (_effectMap.empty()) { //todo: fix
			_school.HTMLText("-");
			_schoolIcon.GetInstance().GotoAndStop("All");
			_level.HTMLText("-");
			_magicka.HTMLText("-");
			_price.HTMLText("-");
		}
	}


	void SpellmakingMenu::CommitSelection()
	{
		if (_effectMap.contains(_selectedName)) {
			auto& selectedEffect = _effectMap[_selectedName];
			selectedEffect.magnitude = static_cast<uint32_t>(_magnitude.slider.Value());
			selectedEffect.duration = static_cast<uint32_t>(_duration.slider.Value());
			selectedEffect.area = static_cast<uint32_t>(_area.slider.Value());
		}
	}

	void SpellmakingMenu::UpdateInfo()
	{
		CommitSelection();
		std::vector<AvailableEffect> _selectedList;
		for (std::map<std::string_view, AvailableEffect>::iterator it = _effectMap.begin(); it != _effectMap.end(); ++it) {
			if (it->second.selected) {
				_selectedList.push_back(it->second);
			}
		}

		auto rangeType = static_cast<RE::MagicSystem::Delivery>(
			static_cast<std::ptrdiff_t>(
				_range.selectedIdx));
		float price = Spellmaking::CalculateCost(
			_selectedList, rangeType);
		_price.HTMLText(
			CommatizeNumber(static_cast<int32_t>(std::ceil(3 * price))));
		_magicka.HTMLText(
			CommatizeNumber(static_cast<int32_t>(std::ceil(price))) + " magicka" + (_type.selectedIdx ? "/s" : ""));

		auto school = Spellmaking::CalculateSpellSchool(_selectedList);
		_school.HTMLText(school);
		if (school == "-") {
			_schoolIcon.GetInstance().GotoAndStop("All");
		} else {
			_schoolIcon.GetInstance().GotoAndStop(school.substr(0, 3).c_str());	 // get first 3 chars of school because thats the frame label
		}


		auto level = Spellmaking::CalculateSpellLevel(_selectedList, rangeType);
		_level.HTMLText(level);

		// check if player has enough gold
		bool _hasGold;
		auto player = RE::PlayerCharacter::GetSingleton();
		if (player->GetGoldAmount() < static_cast<int32_t>(std::ceil(price))) {
			//_craft.Label("Not Enough Gold!");
			_hasGold = false;
		} else {
			//_craft.Label("Craft Spell");
			_hasGold = true;
		}

		_craft.Disabled(
			_selectedList.empty() ||
			_name.Text().length() == 0 ||
			!_hasGold);

		if (!_selectedList.empty() && _hasGold && _name.Text().length() == 0) {
			_nameHeader.GetInstance().GotoAndPlay("animate");
		} else {
			_nameHeader.GetInstance().GotoAndStop("static");
		}
	}

	void SpellmakingMenu::DisplayConfirmation(RE::SpellItem* spell)
	{
		const auto factoryManager = RE::MessageDataFactoryManager::GetSingleton();
		const auto uiStrHolder = RE::InterfaceStrings::GetSingleton();
		const auto factory = factoryManager->GetCreator<RE::MessageBoxData>(uiStrHolder->messageBoxData);
		const auto messageBox = factory->Create();
		messageBox->unk4C = 4;
		messageBox->unk38 = 25;
		const auto gameSettings = RE::GameSettingCollection::GetSingleton();
		const auto sOk = gameSettings->GetSetting("sOk");
		const auto sCancel = gameSettings->GetSetting("sCancel");
		messageBox->bodyText = fmt::format("Craft {} for {} gold?", spell->GetFullName(), spell->GetGoldValue());
		messageBox->buttonText.push_back(sOk->GetString());
		messageBox->buttonText.push_back(sCancel->GetString());
		messageBox->callback = RE::BSTSmartPointer<CraftConfirmCallback>(new SpellmakingMenu::CraftConfirmCallback(this));

		REL::Relocation<void(RE::MessageBoxData*)> QueueMessage{ REL::ID(51422) };
		QueueMessage(messageBox);
	}

	void SpellmakingMenu::CraftSpell()
	{
		RE::MagicSystem::Delivery range;
		switch (static_cast<std::ptrdiff_t>(_range.selectedIdx)) {
		case 0:
			range = RE::MagicSystem::Delivery::kSelf;
			break;
		case 1:
			range = RE::MagicSystem::Delivery::kTargetActor;
			break;
		case 2:
			range = RE::MagicSystem::Delivery::kAimed;
			break;
		default:
			logger::error("howd you manage to break this? impressive...");
			range = RE::MagicSystem::Delivery::kSelf;
			break;
		}

		std::vector<AvailableEffect> _selectedList;
		for (std::map<std::string_view, AvailableEffect>::iterator it = _effectMap.begin(); it != _effectMap.end(); ++it) {
			if (it->second.selected) {
				_selectedList.push_back(it->second);
			}
		}

		auto spell = Spellmaking::CraftSpell(
			_name.Text(),
			range,
			static_cast<RE::MagicSystem::CastingType>(
				static_cast<std::ptrdiff_t>(
					_type.selectedIdx) +
				1),
			_selectedList);

		SpellmakingMenu::Close();

		DisplayConfirmation(spell);
	}

	void SpellmakingMenu::OnRangeChange(int idx)
	{
		_range.selectedIdx = idx;
		UpdateInfo();
	}

	void SpellmakingMenu::OnTypeChange(int idx)
	{
		_type.selectedIdx = idx;
		UpdateInfo();
	}

	void SpellmakingMenu::OnTextUnfocus()
	{
		UpdateInfo();
	}

	bool SpellmakingMenu::OnAvailablePress(std::string_view a_selectedName, bool a_rightClick)
	{

		if (!_effectMap.contains(a_selectedName)) {
			return false;
		}

		auto& availableEffect = _effectMap[a_selectedName];

		CommitSelection();

		if (a_rightClick) {
			availableEffect.selected = false;
			_selectedName = ""; //todo: change to nullable?
			_selectedEffectHeader.HTMLText("(none selected)");
		} else {
			availableEffect.selected = true;
			_selectedName = a_selectedName;
			std::string name(availableEffect.effect->GetFullName());
			SanitizeString(name);
			_selectedEffectHeader.HTMLText(name);
		}
		SetEffectInfo();

		return true;
	}


	bool SpellmakingMenu::OnMagnitudeDragChange(bool a_isDragging)
	{
		_magnitude.SetDragging(a_isDragging);
		return true;
	}


	bool SpellmakingMenu::OnMagnitudeChange()
	{
		_magnitude.UpdateText();
		UpdateInfo();
		return true;
	}


	bool SpellmakingMenu::OnDurationDragChange(bool a_isDragging)
	{
		_duration.SetDragging(a_isDragging);
		return true;
	}


	bool SpellmakingMenu::OnDurationChange()
	{
		_duration.UpdateText();
		UpdateInfo();
		return true;
	}


	bool SpellmakingMenu::OnAreaDragChange(bool a_isDragging)
	{
		_area.SetDragging(a_isDragging);
		return true;
	}


	bool SpellmakingMenu::OnAreaChange()
	{
		_area.UpdateText();
		UpdateInfo();
		return true;
	}


	void SpellmakingMenu::SanitizeString(std::string& a_str)
	{
		while (!a_str.empty() && std::isspace(a_str.back())) {
			a_str.pop_back();
		}
		while (!a_str.empty() && std::isspace(a_str.front())) {
			a_str.assign(a_str, 1);
		}
	}

	std::string SpellmakingMenu::CommatizeNumber(int32_t num) {
		auto s = std::to_string(num);
		auto n = static_cast<int32_t>(s.length()) - 3;
		while (n > 0) {
			s.insert(n, ",");
			n -= 3;
		}
		return s;
	}

	void SpellmakingMenu::OpenMenuPapyrus(RE::StaticFunctionTag*)
	{
		auto task = SKSE::GetTaskInterface();
		logger::info("opening menu");
		task->AddUITask(Open);
	}
	void SpellmakingMenu::CloseMenuPapyrus(RE::StaticFunctionTag*)
	{
		auto task = SKSE::GetTaskInterface();
		task->AddUITask(Close);
	}

	bool SpellmakingMenu::RegisterFuncs(RE::BSScript::IVirtualMachine* a_vm)
	{
		a_vm->RegisterFunction("OpenSpellmaking", "SpellMaking", Scaleform::SpellmakingMenu::OpenMenuPapyrus);
		a_vm->RegisterFunction("CloseSpellmaking", "SpellMaking", Scaleform::SpellmakingMenu::CloseMenuPapyrus);
		return true;
	}
}