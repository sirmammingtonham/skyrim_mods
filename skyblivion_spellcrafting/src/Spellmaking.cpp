#include "PCH.h"

#include "Spellmaking.h"

namespace Spellmaking
{
	RE::SpellItem* CraftSpell(std::string_view name, RE::MagicSystem::Delivery rangeType, RE::MagicSystem::CastingType castType, const std::vector<Scaleform::AvailableEffect>& selectedMappings)
	{
		auto factory = RE::IFormFactory::GetConcreteFormFactoryByType<RE::SpellItem>();
		if (!factory) {
			return nullptr;
		}

		auto spell = factory->Create();
		if (!spell) {
			logger::info("couldnt create spell...");
			return nullptr;
		}

		spell->fullName = name;
		spell->data.spellType = RE::MagicSystem::SpellType::kSpell;

		spell->data.castingType = castType;	 //static_cast<RE::MagicSystem::CastingType>(static_cast<std::ptrdiff_t>(castType+1));
		spell->data.delivery = rangeType;

		//RE::EffectSetting* test = RE::TESForm::LookupByID<RE::EffectSetting>(selectedMappings[0].effectID);
		//logger::info(std::to_string(test->sourceFiles.array->size()).c_str());
		//logger::info(test->sourceFiles.array->front()->fileName);

		spell->data.chargeTime = CalculateChargeTime(selectedMappings);
		logger::info("calculated charge time {}", spell->data.chargeTime);

		spell->menuDispObject = selectedMappings[0].spell->GetMenuDisplayObject();

		spell->boundData.boundMin.x = 0;
		spell->boundData.boundMin.y = 0;
		spell->boundData.boundMin.z = 0;
		spell->boundData.boundMax.x = 0;
		spell->boundData.boundMax.y = 0;
		spell->boundData.boundMax.z = 0;

		for (auto& selected : selectedMappings) {
			auto effect = new RE::Effect();
			effect->effectItem.magnitude = static_cast<float>(selected.magnitude);
			effect->effectItem.area = selected.area;
			effect->effectItem.duration = selected.duration;
			effect->baseEffect = selected.effect;

			effect->cost = CalculateEffectCost(selected.magnitude, selected.area, selected.duration, effect->baseEffect, rangeType);  // only doing this until I can figure out why the costOverride doesn't work

			spell->effects.push_back(effect);
		}

		auto player = RE::PlayerCharacter::GetSingleton();
		auto cost = spell->CalculateMagickaCost(player);

		logger::info("calculated cost: {}", cost);

		//spell->data.costOverride = 1000; // doesnt work for some reason...

		_craftedSpell = spell;
		return spell;
	}

	float CalculateChargeTime(const std::vector<Scaleform::AvailableEffect>& selectedMappings)
	{
		float x = 0.0f;
		for (auto& selected : selectedMappings) {
			// maybe we just use the spellmaking settings in creation kit to balance charge time?
			x += selected.effect->data.spellmakingChargeTime;
		}
		return x;
	}

	// straight from open morrowind kinda
	float CalculateEffectCost(uint32_t magnitude, uint32_t area, uint32_t duration, RE::EffectSetting* effectSetting, RE::MagicSystem::Delivery rangeType)
	{
		float x = effectSetting->data.baseCost;
		x *= std::max(static_cast<float>(pow(magnitude, 1.28f)), 1.0f);
		x *= std::max(duration, 1U);
		x *= std::max(area * 0.15f, 1.0f);
		if (rangeType == RE::MagicSystem::Delivery::kAimed)
			x *= 1.5f;
		return x;
	}

	float CalculateCost(const std::vector<Scaleform::AvailableEffect>& selectedEffects, RE::MagicSystem::Delivery rangeType)
	{
		float ret = 0.0f;
		for (auto& selected : selectedEffects) {
			ret += CalculateEffectCost(selected.magnitude, selected.area, selected.duration, selected.effect, rangeType);
		}
		return ret;
	}

	std::string CalculateSpellSchool(const std::vector<Scaleform::AvailableEffect>& selectedEffects)
	{
		if (selectedEffects.empty()) {
			return "-";
		}
		auto max_selected = std::max_element(selectedEffects.begin(), selectedEffects.end(), [](const Scaleform::AvailableEffect& a_lhs, const Scaleform::AvailableEffect& a_rhs) {
			return a_lhs.magnitude < a_rhs.magnitude;
		});
		auto effect = max_selected->effect;
		
		// get associated skill of effect
		using av = RE::ActorValue;
		switch (effect->GetMagickSkill()) {
		case av::kNone:
			return "-";
		case av::kAlteration:
			return "Alteration";
		case av::kIllusion:
			return "Illusion";
		case av::kConjuration:
			return "Conjuration";
		case av::kDestruction:
			return "Destruction";
		case av::kRestoration:
			return "Restoration";
		default:
			logger::error("calculatespellschool skill error");
			return "-";
		}
	}
	std::string CalculateSpellLevel(const std::vector<Scaleform::AvailableEffect>& selectedEffects, RE::MagicSystem::Delivery rangeType)
	{
		if (selectedEffects.empty()) {
			return "Novice";
		}
		float total = CalculateCost(selectedEffects, rangeType);

		if (total < 50.0) {
			return "Novice";
		} else if (total < 250.0) {
			return "Apprentice";
		} else if (total < 1000.0) {
			return "Journeyman";
		} else if (total < 2000.0) {
			return "Expert";
		} else {
			return "Master";
		}
	}

	RE::SpellItem* GetCraftedSpell()
	{
		// can't think of a better way of returning this
		// just have to make sure in papyrus that a spell has been created?
		if (!_craftedSpell) {
			logger::error("make sure that a spell is crafted before you ask for it!");
		}
		return _craftedSpell;
		"Journeyman";
	}

	void QueueSpellSave(RE::SpellItem* spell)
	{
		logger::info("added spell");
		_craftedSpells.push_back(spell);
	}

	void SaveCallback(SKSE::SerializationInterface* a_intfc)
	{
		logger::info("starting save callback");
		if (!a_intfc->OpenRecord('SPEL', 1)) {
			logger::error("Failed to open record for modified spells!");
		} else {
			std::size_t size = _craftedSpells.size();
			if (!a_intfc->WriteRecordData(size)) {
				logger::error("Failed to write size of crafted spells!");
			} else {
				for (auto& spell : _craftedSpells) {
					if (!SpellSerializer::SerializeSpell(a_intfc, spell)) {
						logger::error("Failed to write data for spell {}!", spell->fullName.c_str());
						break;
					} else {
						logger::info("wrote data for spell {}", spell->fullName.c_str());
					}
				}
			}
		}
	}

	void LoadCallback(SKSE::SerializationInterface* a_intfc)
	{
		logger::info("started load callback");
		_craftedSpells.clear();
		uint32_t type;
		uint32_t version;
		uint32_t length;
		auto player = RE::PlayerCharacter::GetSingleton();
		while (a_intfc->GetNextRecordInfo(type, version, length)) {
			switch (type) {
			case 'SPEL':
				{
					std::size_t size;
					if (!a_intfc->ReadRecordData(size)) {
						logger::error("Failed to load size!");
						break;
					}

					for (uint32_t i = 0; i < size; ++i) {
						RE::SpellItem* spell = SpellSerializer::DeserializeSpell(a_intfc);
						if (!spell) {
							logger::error("couldn't load spell!");
							break;
						}

						logger::info("successfully loaded spell {}", spell->fullName.c_str());

						_craftedSpells.push_back(spell);
						player->AddSpell(spell);
					}
				}
				break;
			default:
				logger::error("Unrecognized signature type!");
				break;
			}
		}
	}
}

namespace Spellmaking::SpellSerializer
{
	bool SerializeEffectItem(SKSE::SerializationInterface* a_intfc, RE::Effect* effect)
	{
		a_intfc->WriteRecordData(effect->effectItem.magnitude);
		a_intfc->WriteRecordData(effect->effectItem.area);
		a_intfc->WriteRecordData(effect->effectItem.duration);
		//a_intfc->WriteRecordData(&(effect->pad0C));
		a_intfc->WriteRecordData(effect->cost);

		a_intfc->WriteRecordData(effect->baseEffect->formID);
		return true;
	}

	RE::Effect* DeserializeEffectItem(SKSE::SerializationInterface* a_intfc)
	{
		auto effect = new RE::Effect();
		a_intfc->ReadRecordData(effect->effectItem.magnitude);
		a_intfc->ReadRecordData(effect->effectItem.area);
		a_intfc->ReadRecordData(effect->effectItem.duration);
		a_intfc->ReadRecordData(effect->cost);

		RE::FormID id;
		a_intfc->ReadRecordData(id);
		effect->baseEffect = RE::TESForm::LookupByID<RE::EffectSetting>(id);
		assert(effect->baseEffect);
		//logger::info("loaded effect {}", effect->baseEffect->fullName.c_str());
		return effect;
	}

	// haven't tested if the game even saves the spell form at all
	// might have to create a new spell instead
	bool SerializeSpell(SKSE::SerializationInterface* a_intfc, RE::SpellItem* spell)
	{
		auto player = RE::PlayerCharacter::GetSingleton();

		// serialize name
		std::size_t len = strlen(spell->fullName.c_str());
		a_intfc->WriteRecordData(len);
		auto name = spell->fullName.c_str();
		for (uint32_t i = 0; i < len; ++i) {
			a_intfc->WriteRecordData(name[i]);
		}

		// serialize other stuff (menudisplay formid, equip slot)
		a_intfc->WriteRecordData(spell->menuDispObject->formID);
		auto leftH = player->GetEquippedObject(true) ? player->GetEquippedObject(true)->formID : 0U; // null aware operators would be cool
		auto rightH = player->GetEquippedObject(false) ? player->GetEquippedObject(false)->formID : 0U;
		if (leftH == rightH && rightH == spell->formID) {
			if (spell->equipSlot->flags.any(RE::BGSEquipSlot::Flag::kUseAllParents)) {
				a_intfc->WriteRecordData(EquipSlot::kBothHands);
			}
			else {
				a_intfc->WriteRecordData(EquipSlot::kEitherHand);
			}
		} else if (leftH == spell->formID) {
			a_intfc->WriteRecordData(EquipSlot::kLeftHand);
		} else if (rightH == spell->formID) {
			a_intfc->WriteRecordData(EquipSlot::kRightHand);
		} else {
			a_intfc->WriteRecordData(EquipSlot::kNone);
		}

		// serialize the spell's effects
		if (a_intfc->WriteRecordData(spell->effects.size())) {
			logger::info("saving {} effects", spell->effects.size());
			for (uint32_t i = 0; i < spell->effects.size(); ++i) {
				if (SerializeEffectItem(a_intfc, spell->effects[i])) {
					logger::info("saving effect {}", spell->effects[i]->baseEffect->fullName.c_str());
				} else {
					return false;
				}
			}
		}
		// serialize the data struct
		a_intfc->WriteRecordData(spell->data.costOverride);
		a_intfc->WriteRecordData(spell->data.spellType);
		a_intfc->WriteRecordData(spell->data.chargeTime);
		a_intfc->WriteRecordData(spell->data.castingType);
		a_intfc->WriteRecordData(spell->data.delivery);
		a_intfc->WriteRecordData(spell->data.castDuration);
		a_intfc->WriteRecordData(spell->data.range);

		//logger::info("successfully saved spell {}", spell->fullName.c_str());
		return true;
	}

	RE::SpellItem* DeserializeSpell(SKSE::SerializationInterface* a_intfc)
	{
		auto player = RE::PlayerCharacter::GetSingleton();
		auto equipManager = RE::ActorEquipManager::GetSingleton();
		// create a new spell, unfortunately wont be able to keep spell in favorites but whatever
		// also will have to re-equip between loads
		auto factory = RE::IFormFactory::GetConcreteFormFactoryByType<RE::SpellItem>();
		if (!factory) {
			return nullptr;
		}

		auto spell = factory->Create();

		// get name
		std::size_t len;
		a_intfc->ReadRecordData(len);
		char* name = new char[len + 1];
		for (uint32_t i = 0; i < len; ++i) {
			a_intfc->ReadRecordData(name[i]);
		}
		name[len] = '\0';

		spell->fullName = name;
		delete[] name;

		// get menu display obj
		RE::FormID id;
		a_intfc->ReadRecordData(id);
		spell->menuDispObject = static_cast<RE::TESBoundObject*>(RE::TESForm::LookupByID(id));

		EquipSlot hand;
		a_intfc->ReadRecordData(hand);

		// get effects
		uint32_t size;
		if (a_intfc->ReadRecordData(size)) {
			logger::info("found {} effects", size);
			for (uint32_t i = 0; i < size; ++i) {
				spell->effects.push_back(DeserializeEffectItem(a_intfc));
			}
		}

		// get data struct
		a_intfc->ReadRecordData(spell->data.costOverride);
		a_intfc->ReadRecordData(spell->data.spellType);
		a_intfc->ReadRecordData(spell->data.chargeTime);
		a_intfc->ReadRecordData(spell->data.castingType);
		a_intfc->ReadRecordData(spell->data.delivery);
		a_intfc->ReadRecordData(spell->data.castDuration);
		a_intfc->ReadRecordData(spell->data.range);

		if (equipManager) {
			if (hand == EquipSlot::kEitherHand) {
				auto slotLeft = RE::TESForm::LookupByID(static_cast<RE::FormID>(EquipSlot::kLeftHand))->As<RE::BGSEquipSlot>();
				auto slotRight = RE::TESForm::LookupByID(static_cast<RE::FormID>(EquipSlot::kRightHand))->As<RE::BGSEquipSlot>();
				equipManager->EquipSpell(player, spell, slotLeft);
				equipManager->EquipSpell(player, spell, slotRight);
			} else if (hand != EquipSlot::kNone) {
				logger::debug("attempting spell equip");
				auto slot = RE::TESForm::LookupByID(static_cast<RE::FormID>(hand))->As<RE::BGSEquipSlot>();
				equipManager->EquipSpell(player, spell, slot);
			}
		}
		return spell;
	}
}