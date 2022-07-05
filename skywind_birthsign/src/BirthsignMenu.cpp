#include "PCH.h"
#include "BirthsignMenu.h"

#include <map>

#include "CLIK/Array.h"

namespace Scaleform
{
	BirthsignMenu::BirthsignMenu() :
	_description(),
	_proceed(),
	_bigImage(),
	_currentSelection()
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

			//auto logger = new Logger<BirthsignMenu>();
			//a_def->SetState(StateType::kLog, logger);
			//logger->Release();

			a_def->SetState(
				RE::GFxState::StateType::kLog,
				RE::make_gptr<Logger<BirthsignMenu>>().get());
		});

		if (!success) {
			assert(false);
			logger::critical("BirthsignMenu did not have a view due to missing dependencies! Aborting process!\n");
			std::abort();
		}

		depthPriority = 5;	// JournalMenu == 5
		menuFlags.set(Flag::kDisablePauseMenu, Flag::kUsesCursor, Flag::kTopmostRenderedMenu, Flag::kPausesGame);
		inputContext = Context::kFavor;

		InitExtensions();
		uiMovie->SetVisible(false);
	}


	void BirthsignMenu::Accept(RE::FxDelegateHandler::CallbackProcessor* a_processor)
	{
		a_processor->Process("Log", Log);
		a_processor->Process("OnBirthsignPress", OnBirthsignPress);
		a_processor->Process("ConfirmSelection", ConfirmSelection);
		a_processor->Process("CloseMenu", CloseMenu);
	}


	auto BirthsignMenu::ProcessMessage(RE::UIMessage& a_message)
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


	void BirthsignMenu::AdvanceMovie(float a_interval, uint32_t a_currentTime)
	{
		Base::AdvanceMovie(a_interval, a_currentTime);
	}


	void BirthsignMenu::Open()
	{
		auto uiQueue = RE::UIMessageQueue::GetSingleton();
		uiQueue->AddMessage(Name(), RE::UI_MESSAGE_TYPE::kShow, 0);
	}


	void BirthsignMenu::Close()
	{
		auto uiQueue = RE::UIMessageQueue::GetSingleton();
		uiQueue->AddMessage(Name(), RE::UI_MESSAGE_TYPE::kHide, 0);
	}


	void BirthsignMenu::Register()
	{
		auto ui = RE::UI::GetSingleton();
		ui->Register(Name(), Create);

		logger::info("Registered {} (pls work)", Name().data());
	}


	RE::IMenu* BirthsignMenu::Create()
	{
		return new BirthsignMenu();
	}


	void BirthsignMenu::Log(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 1);
		if (a_params[0].IsUndefined()) {
			logger::info("{} swf: undefined log", Name().data());
			return;
		}
		assert(a_params[0].IsString());

		logger::info("{} swf: {}", Name().data(), a_params[0].GetString());
	}

	void BirthsignMenu::OnBirthsignPress([[maybe_unused]] const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 1);
		auto signIdx = a_params[0].GetUInt();

		auto menu = static_cast<BirthsignMenu*>(a_params.GetHandler());
		menu->OnBirthsignPress(static_cast<BirthsignMenu::Birthsign>(signIdx));
	}

	void BirthsignMenu::ConfirmSelection([[maybe_unused]] const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<BirthsignMenu*>(a_params.GetHandler());
		menu->ConfirmSelection();
	}

	void BirthsignMenu::CloseMenu(const RE::FxDelegateArgs& a_params)
	{
		assert(a_params.GetArgCount() == 0);

		auto menu = static_cast<BirthsignMenu*>(a_params.GetHandler());
		menu->Close();
	}


	void BirthsignMenu::OnMenuOpen()
	{
		auto bm = RE::UIBlurManager::GetSingleton();

		// set blur
		bm->IncrementBlurCount();

		bool success;
		uiMovie->SetVisible(true);
		std::vector<std::pair<CLIK::Object*, std::string>> toGet;
		// CLIK::GFx::Controls::Button apprentice = CLIK::GFx::Controls::Button();
		// toGet.push_back(std::make_pair(&apprentice, "apprentice"));

		toGet.push_back(std::make_pair(&_bigImage, "big_image"));
		toGet.push_back(std::make_pair(&_proceed, "proceed_button"));
		toGet.push_back(std::make_pair(&_description.tile1, "buff_desc1"));
		toGet.push_back(std::make_pair(&_description.tile1, "buff_desc2"));
		toGet.push_back(std::make_pair(&_description.tile1, "buff_desc3"));

		RE::GFxValue var;
		for (auto& elem : toGet) {
			std::string root("BirthsignMenu_mc.");
			auto element = root + elem.second;
			success = uiMovie->GetVariable(&var, element.c_str());
			if (!success) {
				logger::info("couldn't get {}", element);
				assert(success);
			}
			*elem.first = var;
		}

		// _proceed.Selected(true);
		// apprentice.Selected(true);
		// apprentice.GetInstance().GotoAndPlay("down");
		_currentSelection = Birthsign::kNone;
		UpdateInfo();
	}


	void BirthsignMenu::OnMenuClose()
	{
		auto bm = RE::UIBlurManager::GetSingleton();
		bm->DecrementBlurCount();
	}

	void BirthsignMenu::OnBirthsignPress(BirthsignMenu::Birthsign sign) {
		_currentSelection = sign;
		UpdateInfo();
	}

	void BirthsignMenu::UpdateInfo()
	{
		switch (_currentSelection) {
			case kApprentice:
				_bigImage.GetInstance().GotoAndStop("apprentice");
				break;
			case kAtronach:
				_bigImage.GetInstance().GotoAndStop("atronach");
				break;
			case kRitual:
				_bigImage.GetInstance().GotoAndStop("ritual");
				break;
			case kMage:
				_bigImage.GetInstance().GotoAndStop("mage");
				break;
			case kLady:
				_bigImage.GetInstance().GotoAndStop("lady");
				break;
			case kLord:
				_bigImage.GetInstance().GotoAndStop("lord");
				break;
			case kSteed:
				_bigImage.GetInstance().GotoAndStop("steed");
				break;
			case kWarrior:
				_bigImage.GetInstance().GotoAndStop("warrior");
				break;
			case kSerpent:
				_bigImage.GetInstance().GotoAndStop("serpent");
				break;
			case kLover:
				_bigImage.GetInstance().GotoAndStop("lover");
				break;
			case kShadow:
				_bigImage.GetInstance().GotoAndStop("shadow");
				break;
			case kTower:
				_bigImage.GetInstance().GotoAndStop("tower");
				break;
			case kThief:
				_bigImage.GetInstance().GotoAndStop("thief");
				break;
			default:
				break;
		}
	}

	void BirthsignMenu::ConfirmSelection()
	{

	}


	void BirthsignMenu::InitExtensions()
	{
		RE::GFxValue boolean(true);
		bool success;

		success = uiMovie->SetVariable("_global.gfxExtensions", boolean);
		assert(success);
		success = uiMovie->SetVariable("_global.noInvisibleAdvance", boolean);
		assert(success);
	}


	void BirthsignMenu::SanitizeString(std::string& a_str)
	{
		while (!a_str.empty() && std::isspace(a_str.back())) {
			a_str.pop_back();
		}
		while (!a_str.empty() && std::isspace(a_str.front())) {
			a_str.assign(a_str, 1);
		}
	}

	void BirthsignMenu::OpenMenuPapyrus(RE::StaticFunctionTag*)
	{
		auto task = SKSE::GetTaskInterface();
		logger::info("opening menu");
		task->AddUITask(Open);
	}
	void BirthsignMenu::CloseMenuPapyrus(RE::StaticFunctionTag*)
	{
		auto task = SKSE::GetTaskInterface();
		task->AddUITask(Close);
	}

	bool BirthsignMenu::RegisterFuncs(RE::BSScript::IVirtualMachine* a_vm)
	{
		// a_vm->RegisterFunction("OpenBirthsign", "Birthsign", Scaleform::BirthsignMenu::OpenMenuPapyrus);
		// a_vm->RegisterFunction("CloseBirthsign", "Birthsign", Scaleform::BirthsignMenu::CloseMenuPapyrus);
		a_vm->RegisterFunction("OpenSpellmaking", "SpellMaking", Scaleform::BirthsignMenu::OpenMenuPapyrus);
		a_vm->RegisterFunction("CloseSpellmaking", "SpellMaking", Scaleform::BirthsignMenu::CloseMenuPapyrus);
		return true;
	}
}
