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
#include "CLIK/TextField.h"
#include "CLIK/TextInput.h"

namespace Scaleform
{
	namespace Skyblivion
	{
		using PlayerSkill = RE::PlayerCharacter::PlayerSkills::Data::Skill;

		enum class Class
		{
			kAcrobat = 0,
			kAgent,
			kArcher,
			kAssassin,
			kBarbarian,
			kBard,
			kBattlemage,
			kCrusader,
			kHealer,
			kKnight,
			kMage,
			kMonk,
			kNightblade,
			kPilgrim,
			kRogue,
			kScout,
			kSorcerer,
			kSpellsword,
			kThief,
			kWarrior,
			kWitchhunter,
		};

		enum class Attribute
		{
			kAgility = 0,
			kEndurance,
			kIntelligence,
			kLuck,
			kPersonality,
			kSpeed,
			kStrength,
			kWillpower,
		};

		enum class Specialization
		{
			// combat skills
			kCombat = 0,
			kMagic,
			kStealth
		};

		enum class Skill
		{
			kArmorer = 0,
			kAthletics,
			kBlade,
			kBlock,
			kBlunt,
			kHandToHand,
			kHeavyArmor,
			kAlchemy,
			kAlteration,
			kConjuration,
			kDestruction,
			kIllusion,
			kMysticism,
			kRestoration,
			kAcrobatics,
			kLightArmor,
			kMarksman,
			kMercantile,
			kSecurity,
			kSneak,
			kSpeechcraft,
		};

		struct CustomClassData
		{
			std::pair<Attribute, Attribute> attributes;
			Specialization specialization;
			std::array<Skill, 7> skills;

			std::string_view name;
			std::string_view description;
		};

		enum ActorValue
		{
			kBlade = RE::ActorValue::kOneHanded,
			kBlock = RE::ActorValue::kBlock,
			kBlunt = RE::ActorValue::kTwoHanded,
			kArmorer = RE::ActorValue::kSmithing,
			kAthletics = RE::ActorValue::kTwoHandedModifier,
			kAlchemy = RE::ActorValue::kAlchemy,
			kAlteration = RE::ActorValue::kAlteration,
			kConjuration = RE::ActorValue::kConjuration,
			kDestruction = RE::ActorValue::kDestruction,
			kIllusion = RE::ActorValue::kIllusion,
			kMysticism = RE::ActorValue::kEnchanting,
			kRestoration = RE::ActorValue::kRestoration,
			kHeavyArmor = RE::ActorValue::kHeavyArmor,
			kHandToHand = RE::ActorValue::kLightArmorModifier,
			kLightArmor = RE::ActorValue::kLightArmor,
			kMarksman = RE::ActorValue::kArchery,
			kSecurity = RE::ActorValue::kLockpicking,
			kSneak = RE::ActorValue::kSneak,
			kMercantile = RE::ActorValue::kSpeech,
			kAcrobatics = RE::ActorValue::kPickpocket,
			kSpeechcraft = RE::ActorValue::kIllusionModifier,
			kStrength = RE::ActorValue::kFavorActive,
			kIntelligence = RE::ActorValue::kFavorsPerDayTimer,
			kWillpower = RE::ActorValue::kLockpickingModifier,
			kEndurance = RE::ActorValue::kFavorsPerDay,
			kAgility = RE::ActorValue::kLastBribedIntimidated,
			kSpeed = RE::ActorValue::kLastFlattered,
			kPersonality = RE::ActorValue::kFame,
			kLuck = RE::ActorValue::kInfamy,
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

	class ClassCreationMenu : public RE::IMenu
	{
	private:
		static constexpr char SWF_NAME[] = "classcreationmenu";

	public:
		using Base = RE::IMenu;
		using Result = RE::UI_MESSAGE_RESULTS;

		ClassCreationMenu();
		virtual ~ClassCreationMenu() = default;

		// IMenu
		virtual void Accept(RE::FxDelegateHandler::CallbackProcessor* a_processor) override;
		virtual Result ProcessMessage(RE::UIMessage& a_message) override;
		virtual void AdvanceMovie(float a_interval, uint32_t a_currentTime) override;

		static bool ExecConsoleCommand(const RE::SCRIPT_PARAMETER* a_paramInfo,
			RE::SCRIPT_FUNCTION::ScriptData* a_scriptData,
			RE::TESObjectREFR* a_thisObj,
			RE::TESObjectREFR* a_containingObj,
			RE::Script* a_scriptObj,
			RE::ScriptLocals* a_locals,
			double& a_result,
			uint32_t& a_opcodeOffsetPtr);

		static void Open();
		static void Close();

		static constexpr std::string_view Name();

		static void Register();
		static RE::IMenu* Create();
		static bool RegisterFuncs(RE::BSScript::IVirtualMachine* a_vm);

	private:
		void OnMenuOpenMessage();
		void OnMenuCloseMessage();

		static void Log(const RE::FxDelegateArgs& a_params);
		static void OnTextFocus(const RE::FxDelegateArgs& a_params);
		static void OnTextUnfocus(const RE::FxDelegateArgs& a_params);
		static void OnConfirm(const RE::FxDelegateArgs& a_params);
		static void CloseMenu(const RE::FxDelegateArgs& a_params);

		void InitExtensions();
		void OnConfirm(Skyblivion::CustomClassData a_data);
		void SetInfo();

		// papyrus register helpers
		static void OpenMenuPapyrus(RE::StaticFunctionTag*);
		// static void CloseMenuPapyrus(RE::StaticFunctionTag*); //cant imagine a situation where you need to close programmatically

		void SanitizeString(std::string& a_str);

		static constexpr char COMMAND_NAME[] = "OpenClassMenu";
	};

	constexpr std::string_view ClassCreationMenu::Name()
	{
		return "ClassCreationMenu";
	}
}
