#pragma once

#include <optional>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "RE/Skyrim.h"
#include "SKSE/API.h"
#include "SKSE/Logger.h"

#include "CLIK/Button.h"
#include "CLIK/DropdownMenu.h"
#include "CLIK/ScrollingList.h"
#include "CLIK/Slider.h"
#include "CLIK/TextField.h"
#include "CLIK/TextInput.h"

namespace Scaleform
{
	namespace
	{
		// struct DescriptionTile
		// {
		// 	CLIK::MovieClip icon;
		// 	CLIK::TextField text;
		// };

		struct Description
		{
			CLIK::TextField description;

			CLIK::MovieClip tile1;
			CLIK::MovieClip tile2;
			CLIK::MovieClip tile3;
		};

		// struct BirthsignData
		// {
		// 	std::string name;
		// 	std::string desc;
		// }
	}

	template <class T>
	class Logger :
		public RE::GFxLog
	{
	public:
		inline void LogMessageVarg(LogMessageType, const char* a_fmt, std::va_list a_argList) override
		{
			std::string fmt(a_fmt ? a_fmt : "");
			while (!fmt.empty() && fmt.back() == '\n') {
				fmt.pop_back();
			}

			std::va_list args;
			va_copy(args, a_argList);
			std::vector<char> buf(static_cast<std::size_t>(std::vsnprintf(0, 0, fmt.c_str(), a_argList) + 1));
			std::vsnprintf(buf.data(), buf.size(), fmt.c_str(), args);
			va_end(args);

			// Not using the logger abraction here because There is no need to add location data (file name, lines number, etc to scaleform logs.
			spdlog::log(spdlog::level::level_enum::trace, "{}: {}", T::Name().data(), buf.data());
		}
	};

	class BirthsignMenu : public RE::IMenu
	{
	public:
		using Base = RE::IMenu;
		using Result = RE::UI_MESSAGE_RESULTS;

		BirthsignMenu();
		virtual ~BirthsignMenu() = default;

		// IMenu
		virtual void Accept(RE::FxDelegateHandler::CallbackProcessor* a_processor) override;
		virtual Result ProcessMessage(RE::UIMessage& a_message) override;
		virtual void AdvanceMovie(float a_interval, uint32_t a_currentTime) override;

		static void Open();
		static void Close();

		static constexpr std::string_view Name();

		static void Register();
		static RE::IMenu* Create();
		static bool RegisterFuncs(RE::BSScript::IVirtualMachine* a_vm);

	private:
		enum Birthsign
		{
			kNone = 0,
			kApprentice,
			kAtronach,
			kRitual,
			kMage,
			kLady,
			kLord,
			kSteed,
			kWarrior,
			kSerpent,
			kLover,
			kShadow,
			kTower,
			kThief,
		};

		static void Log(const RE::FxDelegateArgs& a_params);
		static void OnBirthsignPress(const RE::FxDelegateArgs& a_params);
		static void ConfirmSelection(const RE::FxDelegateArgs& a_params);
		static void CloseMenu(const RE::FxDelegateArgs& a_params);

		void OnMenuOpen();
		void OnMenuClose();
		void ConfirmSelection();
		void OnBirthsignPress(BirthsignMenu::Birthsign sign);
		void UpdateInfo();

		// papyrus register helpers
		static void OpenMenuPapyrus(RE::StaticFunctionTag*);
		static void CloseMenuPapyrus(RE::StaticFunctionTag*);

		void InitExtensions();
		void SanitizeString(std::string& a_str);

		static constexpr char SWF_NAME[] = "birthsignmenu";

		BirthsignMenu::Birthsign _currentSelection;
		Description _description;
		// CLIK::GFx::Controls::Button _apprentice;
		// CLIK::GFx::Controls::Button _atronach;
		// CLIK::GFx::Controls::Button _ritual;
		// CLIK::GFx::Controls::Button _mage;
		// CLIK::GFx::Controls::Button _lady;
		// CLIK::GFx::Controls::Button _lord;
		// CLIK::GFx::Controls::Button _steed;
		// CLIK::GFx::Controls::Button _warrior;
		// CLIK::GFx::Controls::Button _serpent;
		// CLIK::GFx::Controls::Button _lover;
		// CLIK::GFx::Controls::Button _shadow;
		// CLIK::GFx::Controls::Button _tower;
		// CLIK::GFx::Controls::Button _thief;
		CLIK::GFx::Controls::Button _proceed;
		CLIK::MovieClip _bigImage;
	};

	constexpr std::string_view BirthsignMenu::Name()
	{
		return "BirthsignMenu";
	}
}
