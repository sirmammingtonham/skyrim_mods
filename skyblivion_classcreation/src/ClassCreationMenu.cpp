#include "PCH.h"

#include "ClassCreationMenu.h"

#include <map>

#include "CLIK/Array.h"

namespace Scaleform
{
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

	bool ClassCreationMenu::ExecConsoleCommand([[maybe_unused]] const RE::SCRIPT_PARAMETER* a_paramInfo,
		[[maybe_unused]] RE::SCRIPT_FUNCTION::ScriptData* a_scriptData,
		[[maybe_unused]] RE::TESObjectREFR* a_thisObj,
		[[maybe_unused]] RE::TESObjectREFR* a_containingObj,
		[[maybe_unused]] RE::Script* a_scriptObj,
		[[maybe_unused]] RE::ScriptLocals* a_locals,
		[[maybe_unused]] double& a_result,
		[[maybe_unused]] uint32_t& a_opcodeOffsetPtr)
	{
		logger::info("did a thing");
		auto task = SKSE::GetTaskInterface();
		task->AddUITask(Open);
		return true;
	}

	void ClassCreationMenu::Accept(RE::FxDelegateHandler::CallbackProcessor* a_processor)
	{
		a_processor->Process("Log", Log);
		a_processor->Process("OnProceedList", OnProceedList);
		a_processor->Process("OnProceedCustom", OnProceedCustom);
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

	void ClassCreationMenu::Register()
	{
		auto ui = RE::UI::GetSingleton();
		ui->Register(Name(), Create);
		logger::info("Registered {} (pls work)", Name().data());

		auto info = RE::SCRIPT_FUNCTION::LocateConsoleCommand("DumpNiUpdates");  // unused
		if (info) {
			info->functionName = COMMAND_NAME;
			info->params = 0;
			info->numParams = 0;
			info->executeFunction = &ExecConsoleCommand;

			logger::info("Registered console command: {}", COMMAND_NAME);
		} else {
			logger::error("Failed to register console command: {}!", COMMAND_NAME);
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

	void ClassCreationMenu::OnProceedList([[maybe_unused]] const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 1);
		auto menu = static_cast<ClassCreationMenu*>(a_params.GetHandler());
		menu->OnProceedList(static_cast<Skyblivion::Class>(a_params[0].GetNumber()));
	}

	void ClassCreationMenu::OnProceedCustom([[maybe_unused]] const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 14);
		auto menu = static_cast<ClassCreationMenu*>(a_params.GetHandler());
		menu->OnProceedCustom(
			Skyblivion::CustomClassData{
				std::make_pair(
					static_cast<Skyblivion::Attribute>(a_params[0].GetNumber()),
					static_cast<Skyblivion::Attribute>(a_params[1].GetNumber())),
				static_cast<Skyblivion::Specialization>(a_params[2].GetNumber()),
				{
					static_cast<Skyblivion::Skill>(a_params[3].GetNumber()),
					static_cast<Skyblivion::Skill>(a_params[4].GetNumber()),
					static_cast<Skyblivion::Skill>(a_params[5].GetNumber()),
					static_cast<Skyblivion::Skill>(a_params[6].GetNumber()),
					static_cast<Skyblivion::Skill>(a_params[7].GetNumber()),
					static_cast<Skyblivion::Skill>(a_params[8].GetNumber()),
					static_cast<Skyblivion::Skill>(a_params[9].GetNumber()),
					static_cast<Skyblivion::Skill>(a_params[10].GetNumber()),
					static_cast<Skyblivion::Skill>(a_params[11].GetNumber()),
				},
				std::string_view(a_params[12].GetString()),
				std::string_view(a_params[13].GetString()) });
	}

	void ClassCreationMenu::InitExtensions()
	{
		RE::GFxValue boolean(true);
		bool success;

		success = uiMovie->SetVariable("_global.gfxExtensions", boolean);
		assert(success);
		success = uiMovie->SetVariable("_global.noInvisibleAdvance", boolean);
		assert(success);
	}

	void ClassCreationMenu::OnProceedList(Skyblivion::Class a_class)
	{
		auto vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
		auto args = RE::MakeFunctionArguments(static_cast<int32_t>(a_class));
		auto form = RE::TESForm::LookupByEditorID("fbmwChargen");

		auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(RE::FormType::Quest, form);

		RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
		vm->DispatchMethodCall(handle, "fbmw_chargenclasspicklistscript", "ConfirmClass", args, callback);

		Close();
	}

	void ClassCreationMenu::OnProceedCustom(Skyblivion::CustomClassData a_data)
	{
		auto vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
		auto args = RE::MakeFunctionArguments(
			RE::BSFixedString(a_data.name),
			RE::BSFixedString(a_data.description),
			static_cast<int32_t>(a_data.attributes.first),
			static_cast<int32_t>(a_data.attributes.second),
			static_cast<int32_t>(a_data.specialization),
			static_cast<int32_t>(a_data.skills.at(0)),
			static_cast<int32_t>(a_data.skills.at(1)),
			static_cast<int32_t>(a_data.skills.at(2)),
			static_cast<int32_t>(a_data.skills.at(3)),
			static_cast<int32_t>(a_data.skills.at(4)),
			static_cast<int32_t>(a_data.skills.at(5)),
			static_cast<int32_t>(a_data.skills.at(6)),
			static_cast<int32_t>(a_data.skills.at(7)),
			static_cast<int32_t>(a_data.skills.at(8)));

		auto form = RE::TESForm::LookupByEditorID("fbmwChargen");
		auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(RE::FormType::Quest, form);

		RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
		vm->DispatchMethodCall(handle, "fbmw_chargenclasscustomscript", "ConfirmClass", args, callback);

		Close();
	}

	void ClassCreationMenu::SetInfo()
	{
		using AV = RE::ActorValue;
		using SkyAV = Skyblivion::ActorValue;

		auto player = RE::PlayerCharacter::GetSingleton();

		RE::FxResponseArgs<3> response;
		RE::GFxValue playerStats;
		RE::GFxValue attributes;
		RE::GFxValue skills;

		uiMovie->CreateObject(&playerStats);
		uiMovie->CreateObject(&attributes);
		uiMovie->CreateObject(&skills);

		playerStats.SetMember("health", player->GetPermanentActorValue(AV::kHealth));
		playerStats.SetMember("magicka", player->GetPermanentActorValue(AV::kMagicka));
		playerStats.SetMember("stamina", player->GetPermanentActorValue(AV::kStamina));
		playerStats.SetMember("health_regen", player->GetPermanentActorValue(AV::kHealRate));
		playerStats.SetMember("magicka_regen", player->GetPermanentActorValue(AV::kMagickaRate));
		playerStats.SetMember("stamina_regen", player->GetPermanentActorValue(AV::KStaminaRate));
		playerStats.SetMember("carry_weight", player->GetPermanentActorValue(AV::kCarryWeight));

		attributes.SetMember("strength", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kStrength)));
		attributes.SetMember("intelligence", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kIntelligence)));
		attributes.SetMember("willpower", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kWillpower)));
		attributes.SetMember("endurance", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kEndurance)));
		attributes.SetMember("agility", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kAgility)));
		attributes.SetMember("speed", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kSpeed)));
		attributes.SetMember("personality", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kPersonality)));
		attributes.SetMember("luck", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kLuck)));

		skills.SetMember("acrobatics", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kAcrobatics)));
		skills.SetMember("athletics", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kAthletics)));
		skills.SetMember("block", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kBlock)));
		skills.SetMember("blunt", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kBlunt)));
		skills.SetMember("heavy_armor", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kHeavyArmor)));
		skills.SetMember("smithing", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kSmithing)));
		skills.SetMember("alchemy", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kAlchemy)));
		skills.SetMember("alteration", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kAlteration)));
		skills.SetMember("conjuration", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kConjuration)));
		skills.SetMember("destruction", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kDestruction)));
		skills.SetMember("illusion", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kIllusion)));
		skills.SetMember("mysticism", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kMysticism)));
		skills.SetMember("restoration", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kRestoration)));
		skills.SetMember("acrobatics", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kAcrobatics)));
		skills.SetMember("hand_to_hand", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kHandToHand)));
		skills.SetMember("light_armor", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kLightArmor)));
		skills.SetMember("marksman", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kMarksman)));
		skills.SetMember("mercantile", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kMercantile)));
		skills.SetMember("security", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kSecurity)));
		skills.SetMember("sneak", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kSneak)));
		skills.SetMember("speechcraft", player->GetPermanentActorValue(static_cast<AV>(SkyAV::kSpeechcraft)));

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

	void ClassCreationMenu::OpenMenuPapyrus(RE::StaticFunctionTag*)
	{
		auto task = SKSE::GetTaskInterface();
		task->AddUITask(Open);
	}

	bool ClassCreationMenu::RegisterFuncs(RE::BSScript::IVirtualMachine* a_vm)
	{
		a_vm->RegisterFunction("OpenClassMenu", "Skyblivion", OpenMenuPapyrus);
		return true;
	}
}
