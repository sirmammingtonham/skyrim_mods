#include "PCH.h"

#include "ClassCreationMenu.h"

#include <map>

#include "CLIK/Array.h"

namespace Scaleform
{
	ClassCreationMenu::MenuMode ClassCreationMenu::_mode = MenuMode::kCustom;

	ClassCreationMenu::ClassCreationMenu()
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

			a_def->SetState(
				RE::GFxState::StateType::kLog,
				RE::make_gptr<Logger<ClassCreationMenu>>().get());
		});

		if (!success) {
			assert(false);
			logger::critical("ClassCreationMenu did not have a view due to missing dependencies! Aborting process!\n");
			std::abort();
		}

		depthPriority = 5;  // JournalMenu == 5
		menuFlags.set(Flag::kDisablePauseMenu, Flag::kUsesCursor, Flag::kTopmostRenderedMenu, Flag::kPausesGame);
		inputContext = Context::kFavor;

		InitExtensions();
		uiMovie->SetVisible(false);
	}

	void ClassCreationMenu::Accept(RE::FxDelegateHandler::CallbackProcessor* a_processor)
	{
		a_processor->Process("Log", Log);
		a_processor->Process("OnProceed", OnProceed);
		a_processor->Process("OnBack", OnBack);
	}

	auto ClassCreationMenu::ProcessMessage(RE::UIMessage& a_message)
		-> Result
	{
		using Message = RE::UI_MESSAGE_TYPE;

		switch (*a_message.type) {
		case Message::kShow:
			OnMenuOpenMessage();
			return Result::kHandled;
		case Message::kHide:
			OnMenuCloseMessage();
			return Result::kHandled;
		default:
			return Base::ProcessMessage(a_message);
		}
	}

	void ClassCreationMenu::OnMenuOpenMessage()
	{
		// set blur
		auto bm = RE::UIBlurManager::GetSingleton();
		bm->IncrementBlurCount();

		uiMovie->SetVisible(true);

		SetMode();
		SetInfo();
	}

	void ClassCreationMenu::OnMenuCloseMessage()
	{
		auto bm = RE::UIBlurManager::GetSingleton();
		bm->DecrementBlurCount();

		RE::ControlMap* map = RE::ControlMap::GetSingleton();
		map->AllowTextInput(false);
	}

	void ClassCreationMenu::AdvanceMovie(float a_interval, uint32_t a_currentTime)
	{
		Base::AdvanceMovie(a_interval, a_currentTime);
	}

	void ClassCreationMenu::Open()
	{
		auto uiQueue = RE::UIMessageQueue::GetSingleton();
		uiQueue->AddMessage(Name(), RE::UI_MESSAGE_TYPE::kShow, 0);
	}

	void ClassCreationMenu::Close()
	{
		auto uiQueue = RE::UIMessageQueue::GetSingleton();
		uiQueue->AddMessage(Name(), RE::UI_MESSAGE_TYPE::kHide, 0);
	}

	bool ClassCreationMenu::Exec([[maybe_unused]] const RE::SCRIPT_PARAMETER* a_paramInfo, [[maybe_unused]] RE::SCRIPT_FUNCTION::ScriptData* a_scriptData, [[maybe_unused]] RE::TESObjectREFR* a_thisObj, [[maybe_unused]] RE::TESObjectREFR* a_containingObj, [[maybe_unused]] RE::Script* a_scriptObj, [[maybe_unused]] RE::ScriptLocals* a_locals, [[maybe_unused]] double& a_result, [[maybe_unused]] uint32_t& a_opcodeOffsetPtr)
	{
		std::string str("yeehaw");
		auto task = SKSE::GetTaskInterface();
		task->AddTask([str]() {
			auto console = RE::ConsoleLog::GetSingleton();
			if (console) {
				console->Print(str.c_str());
			}
		});

		Open();

		// auto selectedRefHandle = RE::Console::GetSelectedRef();
		// RE::TESObjectREFRPtr selectedRef;
		// RE::TESObjectREFR::LookupByHandle(selectedRefHandle, selectedRef);
		// if (!selectedRef) {
		// 	CPrint("> [%s] ERROR: No selected reference", LONG_NAME);
		// 	return true;
		// }

		// auto strChunk = a_scriptData->GetStringChunk();
		// auto comment = strChunk->GetString();
		// _ref = selectedRef.get();
		// LogComment(comment);
		// _ref = 0;

		return true;
	}

	void ClassCreationMenu::Register()
	{
		auto ui = RE::UI::GetSingleton();
		ui->Register(Name(), Create);

		logger::info("Registered {} (pls work)", Name().data());
		auto info = RE::SCRIPT_FUNCTION::LocateConsoleCommand("BetaComment");  // Unused
		if (info) {
			// static RE::SCRIPT_PARAMETER params[] = {
			// 	// { "String", RE::SCRIPT_PARAMETER::Type::kString, 0 }
			// };

			info->functionName = "OpenClassMenu";
			info->shortName = "OCM";
			info->helpString = "heehhehhehhe";
			info->referenceFunction = false;
			// info->SetParameters(params);
			info->executeFunction = &Exec;
			info->params = 0;
			info->numParams = 0;
			info->conditionFunction = 0;
			info->editorFilter = 0;

			logger::info("success");
		} else {
			logger::info("failure");
		}
	}

	RE::IMenu* ClassCreationMenu::Create()
	{
		return new ClassCreationMenu();
	}

	void ClassCreationMenu::Log(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 1);
		if (a_params[0].IsUndefined()) {
			logger::info("{} swf: undefined log", Name().data());
			return;
		}
		assert(a_params[0].IsString());

		logger::info("{} swf: {}", Name().data(), a_params[0].GetString());
	}

	void ClassCreationMenu::OnProceed([[maybe_unused]] const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);
		auto menu = static_cast<ClassCreationMenu*>(a_params.GetHandler());
		menu->OnProceed();
	}

	void ClassCreationMenu::OnBack([[maybe_unused]] const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);
		auto menu = static_cast<ClassCreationMenu*>(a_params.GetHandler());
		menu->OnBack();
	}

	// void ClassCreationMenu::OnCancel([[maybe_unused]] const RE::FxDelegateArgs& a_params)
	// {
	// 	assert(a_params.GetArgCount() == 0);

	// 	Close();
	// }

	// void ClassCreationMenu::OnTextFocus([[maybe_unused]] const RE::FxDelegateArgs& a_params)
	// {
	// 	assert(a_params.GetArgCount() == 0);

	// 	RE::ControlMap* map = RE::ControlMap::GetSingleton();
	// 	map->AllowTextInput(true);
	// }

	// void ClassCreationMenu::OnTextUnfocus([[maybe_unused]] const RE::FxDelegateArgs& a_params)
	// {
	// 	assert(a_params.GetArgCount() == 0);

	// 	RE::ControlMap* map = RE::ControlMap::GetSingleton();
	// 	auto menu = static_cast<ClassCreationMenu*>(a_params.GetHandler());
	// 	map->AllowTextInput(false);

	// 	menu->OnTextUnfocus();
	// }

	// void ClassCreationMenu::CloseMenu(const RE::FxDelegateArgs& a_params)
	// {
	// 	assert(a_params.GetArgCount() == 0);

	// 	auto menu = static_cast<ClassCreationMenu*>(a_params.GetHandler());
	// 	menu->Close();
	// }

	void ClassCreationMenu::InitExtensions()
	{
		RE::GFxValue boolean(true);
		bool success;

		success = uiMovie->SetVariable("_global.gfxExtensions", boolean);
		assert(success);
		success = uiMovie->SetVariable("_global.noInvisibleAdvance", boolean);
		assert(success);
	}

	void ClassCreationMenu::OnProceed()
	{
		// auto player = RE::PlayerCharacter::GetSingleton();
		// player->GetObjectReference()->As<RE::TESFullName>()->fullName = RE::BSFixedString(_nameField.Text());
		// player->AddChange(static_cast<uint32_t>(1<<6)); // found this in race menu function, doesnt seem to be needed
		// auto player = RE::PlayerCharacter::GetSingleton();
		// player->charGenRace->GetFullName();
		Close();
	}

	void ClassCreationMenu::OnBack()
	{
		Close();
	}

	void ClassCreationMenu::SetMode()
	{
		if (_mode == MenuMode::kCustom) {
			RE::ControlMap* map = RE::ControlMap::GetSingleton();
			map->AllowTextInput(true);
		}
		
		RE::FxResponseArgs<1> response;
		RE::GFxValue mode;
		mode.SetNumber(static_cast<double>(_mode));
		response.Add(mode);
		RE::FxDelegate::Invoke(uiMovie.get(), "SetMode", response);

		logger::info("opening class menu in mode {}", _mode);
	}

	void ClassCreationMenu::SetInfo()
	{
		auto player = RE::PlayerCharacter::GetSingleton();

		RE::FxResponseArgs<3> response;
		RE::GFxValue playerStats;
		RE::GFxValue attributes;
		RE::GFxValue skills;

		uiMovie->CreateObject(&playerStats);
		uiMovie->CreateObject(&attributes);
		uiMovie->CreateObject(&skills);

		playerStats.SetMember("health", player->GetPermanentActorValue(RE::ActorValue::kHealth));
		playerStats.SetMember("magicka", player->GetPermanentActorValue(RE::ActorValue::kMagicka));
		playerStats.SetMember("stamina", player->GetPermanentActorValue(RE::ActorValue::kStamina));
		playerStats.SetMember("health_regen", player->GetPermanentActorValue(RE::ActorValue::kHealRate));
		playerStats.SetMember("magicka_regen", player->GetPermanentActorValue(RE::ActorValue::kMagickaRate));
		playerStats.SetMember("stamina_regen", player->GetPermanentActorValue(RE::ActorValue::KStaminaRate));
		playerStats.SetMember("carry_weight", player->GetPermanentActorValue(RE::ActorValue::kCarryWeight));

		attributes.SetMember("strength", player->GetPermanentActorValue(static_cast<RE::ActorValue>(SkywindAVs::kStrength)));
		attributes.SetMember("intelligence", player->GetPermanentActorValue(static_cast<RE::ActorValue>(SkywindAVs::kIntelligence)));
		attributes.SetMember("willpower", player->GetPermanentActorValue(static_cast<RE::ActorValue>(SkywindAVs::kWillpower)));
		attributes.SetMember("endurance", player->GetPermanentActorValue(static_cast<RE::ActorValue>(SkywindAVs::kEndurance)));
		attributes.SetMember("agility", player->GetPermanentActorValue(static_cast<RE::ActorValue>(SkywindAVs::kAgility)));
		attributes.SetMember("speed", player->GetPermanentActorValue(static_cast<RE::ActorValue>(SkywindAVs::kSpeed)));
		attributes.SetMember("personality", player->GetPermanentActorValue(static_cast<RE::ActorValue>(SkywindAVs::kPersonality)));
		attributes.SetMember("luck", player->GetPermanentActorValue(static_cast<RE::ActorValue>(SkywindAVs::kLuck)));

		skills.SetMember("athletics", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kAxe)));
		skills.SetMember("axe", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kBlock)));
		skills.SetMember("block", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kBlunt)));
		skills.SetMember("blunt_weapon", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kHeavyArmor)));
		skills.SetMember("heavy_armor", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kLongBlade)));
		skills.SetMember("long_blade", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kMediumArmor)));
		skills.SetMember("medium_armor", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kPolearm)));
		skills.SetMember("polearms", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kSmithing)));
		skills.SetMember("smithing", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kAthletics)));
		skills.SetMember("alchemy", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kAlchemy)));
		skills.SetMember("alteration", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kAlteration)));
		skills.SetMember("conjuration", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kConjuration)));
		skills.SetMember("destruction", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kDestruction)));
		skills.SetMember("enchant", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kEnchanting)));
		skills.SetMember("illusion", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kIllusion)));
		skills.SetMember("mysticism", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kMysticism)));
		skills.SetMember("restoration", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kRestoration)));
		skills.SetMember("unarmored", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kUnarmorerd)));
		skills.SetMember("acrobatics", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kHandToHand)));
		skills.SetMember("hand_to_hand", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kLightArmor)));
		skills.SetMember("light_armor", player->GetPermanentActorValue(static_cast<RE::ActorValue>(KMarksman)));
		skills.SetMember("marksman", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kSecurity)));
		skills.SetMember("mercantile", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kShortBlade)));
		skills.SetMember("security", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kSneak)));
		skills.SetMember("short_blade", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kMercantile)));
		skills.SetMember("sneak", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kAcrobatics)));
		skills.SetMember("speechcraft", player->GetPermanentActorValue(static_cast<RE::ActorValue>(kSpeechcraft)));

		response.Add(playerStats);
		response.Add(attributes);
		response.Add(skills);

		RE::FxDelegate::Invoke(uiMovie.get(), "SetInfo", response);
	}

	void ClassCreationMenu::SanitizeString(std::string& a_str)
	{
		while (!a_str.empty() && std::isspace(a_str.back())) {
			a_str.pop_back();
		}
		while (!a_str.empty() && std::isspace(a_str.front())) {
			a_str.assign(a_str, 1);
		}
	}

	void ClassCreationMenu::OpenMenuPapyrus(RE::StaticFunctionTag*, int32_t mode)
	{
		assert(mode >= 0 && mode <= 2);
		_mode = static_cast<MenuMode>(mode);
		auto task = SKSE::GetTaskInterface();
		task->AddUITask(Open);
	}

	bool ClassCreationMenu::RegisterFuncs(RE::BSScript::IVirtualMachine* a_vm)
	{
		a_vm->RegisterFunction("OpenClassMenu", "Skywind", OpenMenuPapyrus);
		return true;
	}
}
