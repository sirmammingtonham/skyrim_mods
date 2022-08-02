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

			//auto logger = new Logger<ClassCreationMenu>();
			//a_def->SetState(StateType::kLog, logger);
			//logger->Release();

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
		// a_processor->Process("OnTextFocus", OnTextFocus);
		// a_processor->Process("OnTextUnfocus", OnTextUnfocus);
		a_processor->Process("OnAccept", OnAccept);
		// a_processor->Process("OnCancel", OnCancel);
		// a_processor->Process("CloseMenu", CloseMenu);
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

		bool success;
		uiMovie->SetVisible(true);
		std::vector<std::pair<CLIK::Object*, std::string>> toGet;

		// toGet.push_back(std::make_pair(&_nameField, "TextInputInstance"));

		RE::GFxValue var;
		for (auto& elem : toGet) {
			std::string root("ClassCreationMenu_mc.");
			auto element = root + elem.second;
			success = uiMovie->GetVariable(&var, element.c_str());
			if (!success) {
				logger::info("couldn't get {}", element);
				assert(success);
			}
			*elem.first = var;
		}

		// RE::ControlMap* map = RE::ControlMap::GetSingleton();
		// map->AllowTextInput(true);

		// RefreshPlatform();
	}

	void ClassCreationMenu::OnMenuCloseMessage()
	{
		auto bm = RE::UIBlurManager::GetSingleton();
		bm->DecrementBlurCount();

		// RE::ControlMap* map = RE::ControlMap::GetSingleton();
		// map->AllowTextInput(false);
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

	void ClassCreationMenu::OnAccept([[maybe_unused]] const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);
		auto menu = static_cast<ClassCreationMenu*>(a_params.GetHandler());
		menu->OnAccept();
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

	void ClassCreationMenu::OnAccept()
	{
		// auto player = RE::PlayerCharacter::GetSingleton();
		// player->GetObjectReference()->As<RE::TESFullName>()->fullName = RE::BSFixedString(_nameField.Text());
		// player->AddChange(static_cast<uint32_t>(1<<6)); // found this in race menu function, doesnt seem to be needed
		Close();
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
	// void ClassCreationMenu::CloseMenuPapyrus(RE::StaticFunctionTag*)
	// {
	// 	auto task = SKSE::GetTaskInterface();
	// 	task->AddUITask(Close);
	// }

	bool ClassCreationMenu::RegisterFuncs(RE::BSScript::IVirtualMachine* a_vm)
	{
		a_vm->RegisterFunction("OpenClassMenu", "Skywind", Scaleform::ClassCreationMenu::OpenMenuPapyrus);
		// a_vm->RegisterFunction("CloseNamePrompt", "Skywind", Scaleform::ClassCreationMenu::CloseMenuPapyrus);
		return true;
	}
}
