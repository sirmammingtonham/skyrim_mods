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
	namespace Skywind
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
			kAthletics = 0,
			kAxe,
			kBlock,
			kBlunt,
			kHeavyArmor,
			kLongBlade,
			kMediumArmor,
			kPolearm,
			kSmithing,
			kAlchemy,
			kAlteration,
			kConjuration,
			kDestruction,
			kEnchanting,
			kIllusion,
			kMysticism,
			kRestoration,
			kUnarmorerd,
			kAcrobatics,
			kHandToHand,
			kLightArmor,
			kMarksman,
			kMercantile,
			kSecurity,
			kShortBlade,
			kSneak,
			kSpeechcraft,
		};

		struct CustomClassData
		{
			std::pair<Attribute, Attribute> attributes;
			Specialization specialization;
			std::array<Skill, 9> skills;

			std::string name;
			std::string description;
		};

		enum ActorValue
		{
			kAxe = RE::ActorValue::kEnchanting,
			kBlock = RE::ActorValue::kBlock,
			kBlunt = RE::ActorValue::kTwoHanded,
			kHeavyArmor = RE::ActorValue::kHeavyArmor,
			kLongBlade = RE::ActorValue::kOneHanded,
			kMediumArmor = RE::ActorValue::kHeavyArmorModifier,
			kPolearm = RE::ActorValue::kSmithing,
			kSmithing = RE::ActorValue::kSmithingModifier,
			kAthletics = RE::ActorValue::kTwoHandedModifier,
			kAlchemy = RE::ActorValue::kAlchemyModifier,
			kAlteration = RE::ActorValue::kAlteration,
			kConjuration = RE::ActorValue::kConjuration,
			kDestruction = RE::ActorValue::kDestruction,
			kEnchanting = RE::ActorValue::kEnchantingModifier,
			kIllusion = RE::ActorValue::kIllusion,
			kMysticism = RE::ActorValue::kAlchemy,
			kRestoration = RE::ActorValue::kRestoration,
			kUnarmorerd = RE::ActorValue::kSneakingModifier,
			kHandToHand = RE::ActorValue::kLightArmorModifier,
			kLightArmor = RE::ActorValue::kLightArmor,
			kMarksman = RE::ActorValue::kArchery,
			kSecurity = RE::ActorValue::kLockpicking,
			kShortBlade = RE::ActorValue::kPickpocket,
			kSneak = RE::ActorValue::kSneak,
			kMercantile = RE::ActorValue::kSpeech,
			kAcrobatics = RE::ActorValue::kOneHandedModifier,
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
		enum MenuMode
		{
			kQuiz = 0,
			kList,
			kCustom,
		};
		static MenuMode _mode;
		// CLIK::TextField _;

	public:
		using Base = RE::IMenu;
		using Result = RE::UI_MESSAGE_RESULTS;

		ClassCreationMenu();
		virtual ~ClassCreationMenu() = default;

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

		static bool Exec(const RE::SCRIPT_PARAMETER* a_paramInfo, RE::SCRIPT_FUNCTION::ScriptData* a_scriptData, RE::TESObjectREFR* a_thisObj, RE::TESObjectREFR* a_containingObj, RE::Script* a_scriptObj, RE::ScriptLocals* a_locals, double& a_result, uint32_t& a_opcodeOffsetPtr);
		// static void Register();

	private:
		void OnMenuOpenMessage();
		void OnMenuCloseMessage();

		static void Log(const RE::FxDelegateArgs& a_params);
		static void OnTextFocus(const RE::FxDelegateArgs& a_params);
		static void OnTextUnfocus(const RE::FxDelegateArgs& a_params);
		static void OnProceedQuiz(const RE::FxDelegateArgs& a_params);
		static void OnProceedList(const RE::FxDelegateArgs& a_params);
		static void OnProceedCustom(const RE::FxDelegateArgs& a_params);
		static void OnBack(const RE::FxDelegateArgs& a_params);
		static void CloseMenu(const RE::FxDelegateArgs& a_params);

		void InitExtensions();
		void OnProceedQuiz();
		void OnProceedList(Skywind::Class a_class);
		void OnProceedCustom(Skywind::CustomClassData a_data);
		void OnBack();
		void SetMode();
		void SetInfo();

		// papyrus register helpers
		static void OpenMenuPapyrus(RE::StaticFunctionTag*, int32_t type, int32_t confirmationClass);
		// static void CloseMenuPapyrus(RE::StaticFunctionTag*); //cant imaging a situation where you need to close programmatically

		void SanitizeString(std::string& a_str);
	};

	constexpr std::string_view ClassCreationMenu::Name()
	{
		return "ClassCreationMenu";
	}
}
