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
	struct AvailableEffect
	{
		RE::EffectSetting* effect;
		RE::SpellItem* spell;
		uint32_t magnitude;
		uint32_t duration;
		uint32_t area;

		bool selected;
		bool display;
	};

	namespace
	{

		struct Range
		{
			int selectedIdx;

			CLIK::MovieClip selfButton;
			CLIK::TextField selfHeader;

			CLIK::MovieClip touchButton;
			CLIK::TextField touchHeader;

			CLIK::MovieClip areaButton;
			CLIK::TextField areaHeader;
		};

		struct Type
		{
			int selectedIdx;

			CLIK::MovieClip ffButton;
			CLIK::TextField ffHeader;

			CLIK::MovieClip concentrationButton;
			CLIK::TextField concentrationHeader;
		};


		struct Slider
		{
		public:
			Slider();
			~Slider() = default;

			void UpdateText();
			void SetDragging(bool a_isDragging);
			bool IsDragging() const;

			CLIK::TextField header;
			CLIK::GFx::Controls::Slider slider;
			CLIK::TextField text;

		private:
			bool _isDragging;
		};

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


	class SpellmakingMenu : public RE::IMenu
	{
	public:
		using Base = RE::IMenu;
		using Result = RE::UI_MESSAGE_RESULTS;


		SpellmakingMenu();
		virtual ~SpellmakingMenu() = default;

		class CraftConfirmCallback : public RE::IMessageBoxCallback
		{
		public:
			SpellmakingMenu* _menu;

			CraftConfirmCallback() = delete;
			CraftConfirmCallback(SpellmakingMenu* menu);
			virtual ~CraftConfirmCallback() = default;
			// add
			void Run(Message a_msg);
		};
		friend class CraftConfirmCallback;

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

		//static constexpr std::size_t MAX_EFFECTS = 16;

	private:
		enum : std::size_t
		{
			kInvalid = static_cast<std::size_t>(-1)
		};

		static void Log(const RE::FxDelegateArgs& a_params);
		static void OnTextFocus(const RE::FxDelegateArgs& a_params);
		static void OnTextUnfocus(const RE::FxDelegateArgs& a_params);
		static void OnAvailablePress(const RE::FxDelegateArgs& a_params);
		static void OnMagnitudeDragBegin(const RE::FxDelegateArgs& a_params);
		static void OnMagnitudeDragEnd(const RE::FxDelegateArgs& a_params);
		static void OnMagnitudeChange(const RE::FxDelegateArgs& a_params);
		static void OnDurationDragBegin(const RE::FxDelegateArgs& a_params);
		static void OnDurationDragEnd(const RE::FxDelegateArgs& a_params);
		static void OnDurationChange(const RE::FxDelegateArgs& a_params);
		static void OnAreaDragBegin(const RE::FxDelegateArgs& a_params);
		static void OnAreaDragEnd(const RE::FxDelegateArgs& a_params);
		static void OnAreaChange(const RE::FxDelegateArgs& a_params);
		static void CraftSpell(const RE::FxDelegateArgs& a_params);
		static void OnCancelPress(const RE::FxDelegateArgs& a_params);
		static void OnFilterPress(const RE::FxDelegateArgs& a_params);
		static void OnRangePress(const RE::FxDelegateArgs& a_params);
		static void OnTypePress(const RE::FxDelegateArgs& a_params);
		static void CloseMenu(const RE::FxDelegateArgs& a_params);

		void OnMenuOpen();
		void OnMenuClose();

		// papyrus register helpers
		static void OpenMenuPapyrus(RE::StaticFunctionTag*);
		static void CloseMenuPapyrus(RE::StaticFunctionTag*);

		void InitExtensions();
		void InitEffectInfo();
		void InitAvailable();
		void SetAvailable(size_t filter);
		void SetEffectInfo();
		void CommitSelection();
		void UpdateInfo();

		void DisplayConfirmation(RE::SpellItem* spell);
		void CraftSpell();

		void OnRangeChange(int idx);
		void OnTypeChange(int idx);

		void OnTextUnfocus();
		bool OnAvailablePress(std::string_view a_selectedName, bool a_rightClick);
		bool OnMagnitudeDragChange(bool a_isDragging);
		bool OnMagnitudeChange();
		bool OnDurationDragChange(bool a_isDragging);
		bool OnDurationChange();
		bool OnAreaDragChange(bool a_isDragging);
		bool OnAreaChange();

		void SanitizeString(std::string& a_str);
		std::string CommatizeNumber(int32_t num);


		static constexpr char SWF_NAME[] = "SpellmakingMenu";

		CLIK::GFx::Controls::ScrollingList _available;
		//SelectedEffectsList _selected;
		Range _range;
		Type _type;
		Slider _magnitude;
		Slider _duration;
		Slider _area;
		CLIK::TextField _gold;
		CLIK::TextField _price;
		CLIK::TextField _level;
		CLIK::TextField _magicka;
		CLIK::TextField _school;
		CLIK::TextField _selectedEffectHeader;
		CLIK::TextField _nameHeader;
		CLIK::MovieClip _schoolIcon;
		CLIK::GFx::Controls::TextInput _name;
		CLIK::GFx::Controls::Button _craft;
		std::map<std::string_view, AvailableEffect> _effectMap;
		std::string_view _selectedName;
		RE::BGSKeyword* _includeKeyword;
	};


	constexpr std::string_view SpellmakingMenu::Name()
	{
		return "SpellmakingMenu";
	}
}
