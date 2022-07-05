#pragma once

#include <optional>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "RE/Skyrim.h"
#include "SKSE/API.h"

#include "SpellmakingMenu.h"

namespace Spellmaking
{
	namespace
	{
		std::vector<RE::SpellItem*> _craftedSpells;
		RE::SpellItem* _craftedSpell = nullptr;
	}

	enum class Levels
	{
		kNovice = 0,
		kApprentice = 1,
		kJourneyman = 2,
		kExpert = 3,
		kMaster = 4
	};

	// spellmaking funcs
	RE::SpellItem* CraftSpell(std::string_view name, RE::MagicSystem::Delivery rangeType, RE::MagicSystem::CastingType castType, const std::vector<Scaleform::AvailableEffect>& selectedMappings);
	float CalculateChargeTime(const std::vector<Scaleform::AvailableEffect>& selectedMappings);
	float CalculateEffectCost(uint32_t magnitude, uint32_t area, uint32_t duration, RE::EffectSetting* effectSetting, RE::MagicSystem::Delivery rangeType);
	float CalculateCost(const std::vector<Scaleform::AvailableEffect>& selectedEffects, RE::MagicSystem::Delivery rangeType);
	std::string CalculateSpellSchool(const std::vector<Scaleform::AvailableEffect>& selectedEffects);
	std::string CalculateSpellLevel(const std::vector<Scaleform::AvailableEffect>& selectedEffects, RE::MagicSystem::Delivery rangeType);

	// class funcs
	RE::SpellItem* GetCraftedSpell();
	void QueueSpellSave(RE::SpellItem* spell);

	// serialization
	void SaveCallback(SKSE::SerializationInterface* a_intfc);
	void LoadCallback(SKSE::SerializationInterface* a_intfc);

	namespace SpellSerializer
	{
		enum class EquipSlot : std::uint32_t
		{
			kNone = 0,
			kEitherHand = 1, // if spell is on both hands
			kRightHand = 0x13f42,
			kLeftHand = 0x13f43,
			kBothHands = 0x13f45,  // if the spell must use both hands
		};

		bool SerializeEffectItem(SKSE::SerializationInterface* a_intfc, RE::Effect* effect);
		RE::Effect* DeserializeEffectItem(SKSE::SerializationInterface* a_intfc);

		bool SerializeSpell(SKSE::SerializationInterface* a_intfc, RE::SpellItem* spell);
		RE::SpellItem* DeserializeSpell(SKSE::SerializationInterface* a_intfc);
	};
};