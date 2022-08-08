Scriptname fbmw_ChargenClassCustomScript extends Quest  
{handles class selection
This iteration was developed for Skywind v0.9.9.28} 

;/
    Contributors: Rovan wrote most of it? idk he never comments his code
	              km816	maybe? no commenting
	              Thermo updated for athletics, acrobats and speechcraft. also added some comments
	redone by yeeb to use custom menu 8/7/22
/;

;========== general properties ==========
Actor Property PlayerRef Auto 
Sound Property SelectFail Auto
fbmw_ChargenClassBaseScript property BaseScript auto
Message Property fbmwClassConfirmCustomA Auto
Message Property fbmwClassConfirmCustomB Auto

;========== script variables ==========
; string ClassName = "Adventurer"

;========== main process ==========
Function CreateCustomClass()
	; open class menu in custom mode (mode -2)
	Skywind.OpenClassMenu(-2);
EndFunction

Function ConfirmClass(int Attribute01, int Attribute02, int Specialization, int Skill01, int Skill02, int Skill03, int Skill04, int Skill05, int Skill06, int Skill07, int Skill08, int Skill09)
	string[] SpecializationList = new string[3]
	SpecializationList[0] = "Combat"
	SpecializationList[1] = "Magic"
	SpecializationList[2] = "Stealth"

	string[] AttributeList = new string[8]
	AttributeList[0] = "Agility"
	AttributeList[1] = "Endurance"
	AttributeList[2] = "Intelligence"
	AttributeList[3] = "Luck"
	AttributeList[4] = "Personality"
	AttributeList[5] = "Speed"
	AttributeList[6] = "Strength"
	AttributeList[7] = "Willpower"

	string[] SkillList = new string[27]
	SkillList[0] = "Athletics"
	SkillList[1] = "Axe"
	SkillList[2] = "Block"
	SkillList[3] = "Blunt Weapon"
	SkillList[4] = "Heavy Armor"
	SkillList[5] = "Long Blade"
	SkillList[6] = "Medium Armor"
	SkillList[7] = "Polearms"
	SkillList[8] = "Smithing"
	SkillList[9] = "Alchemy"
	SkillList[10] = "Alteration"
	SkillList[11] = "Conjuration"
	SkillList[12] = "Destruction"
	SkillList[13] = "Enchant"
	SkillList[14] = "Illusion"
	SkillList[15] = "Mysticism"
	SkillList[16] = "Restoration"
	SkillList[17] = "Unarmored"
	SkillList[18] = "Acrobatics"
	SkillList[19] = "Hand-to-Hand"
	SkillList[20] = "Light Armor"
	SkillList[21] = "Marksman"
	SkillList[22] = "Mercantile"
	SkillList[23] = "Security"
	SkillList[24] = "Short Blade"
	SkillList[25] = "Sneak"
	SkillList[26] = "Speechcraft"

	; clean up any previous chargen
	BaseScript.SkillsScript.ResetClass()

	; specialization
	BaseScript.SkillsScript.fbmwClassSpecialization.SetValue(Specialization)

	; attributes
	if (Attribute01 == 0) || (Attribute02 == 0)
		BaseScript.SkillsScript.AgilityFavored = true
	endif
	if (Attribute01 == 1) || (Attribute02 == 1)
		BaseScript.SkillsScript.EnduranceFavored = true
	endif
	if (Attribute01 == 2) || (Attribute02 == 2)
		BaseScript.SkillsScript.IntelligenceFavored = true
	endif
	if (Attribute01 == 3) || (Attribute02 == 3)
		BaseScript.SkillsScript.LuckFavored = true
	endif
	if (Attribute01 == 4) || (Attribute02 == 4)
		BaseScript.SkillsScript.PersonalityFavored = true
	endif
	if (Attribute01 == 5) || (Attribute02 == 5)
		BaseScript.SkillsScript.SpeedFavored = true
	endif
	if (Attribute01 == 6) || (Attribute02 == 6)
		BaseScript.SkillsScript.StrengthFavored = true
	endif
	if (Attribute01 == 7) || (Attribute02 == 7)
		BaseScript.SkillsScript.WillpowerFavored = true
	endif

	; skills
	;===============combat=================
	if (Skill01 == 0) || (Skill02 == 0) || (Skill03 == 0) || (Skill04 == 0) || (Skill05 == 0) || (Skill06 == 0) || (Skill07 == 0) || (Skill08 == 0) || (Skill09 == 0)
		BaseScript.SkillsScript.fbmwClassAthleticsScore.SetValue(1)
	endif
	if (Skill01 == 1) || (Skill02 == 1) || (Skill03 == 1) || (Skill04 == 1) || (Skill05 == 1) || (Skill06 == 1) || (Skill07 == 1) || (Skill08 == 1) || (Skill09 == 1)
		BaseScript.SkillsScript.fbmwClassAxeScore.SetValue(1)
	endif
	if (Skill01 == 2) || (Skill02 == 2) || (Skill03 == 2) || (Skill04 == 2) || (Skill05 == 2) || (Skill06 == 2) || (Skill07 == 2) || (Skill08 == 2) || (Skill09 == 2)
		BaseScript.SkillsScript.fbmwClassBlockScore.SetValue(1)
	endif
	if (Skill01 == 3) || (Skill02 == 3) || (Skill03 == 3) || (Skill04 == 3) || (Skill05 == 3) || (Skill06 == 3) || (Skill07 == 3) || (Skill08 == 3) || (Skill09 == 3)
		BaseScript.SkillsScript.fbmwClassBluntScore.SetValue(1)
	endif
	if (Skill01 == 4) || (Skill02 == 4) || (Skill03 == 4) || (Skill04 == 4) || (Skill05 == 4) || (Skill06 == 4) || (Skill07 == 4) || (Skill08 == 4) || (Skill09 == 4)
		BaseScript.SkillsScript.fbmwClassHeavyArmorScore.SetValue(1)
	endif
	if (Skill01 == 5) || (Skill02 == 5) || (Skill03 == 5) || (Skill04 == 5) || (Skill05 == 5) || (Skill06 == 5) || (Skill07 == 5) || (Skill08 == 5) || (Skill09 == 5)
		BaseScript.SkillsScript.fbmwClassLongBladeScore.SetValue(1)
	endif
	if (Skill01 == 6) || (Skill02 == 6) || (Skill03 == 6) || (Skill04 == 6) || (Skill05 == 6) || (Skill06 == 6) || (Skill07 == 6) || (Skill08 == 6) || (Skill09 == 6)
		BaseScript.SkillsScript.fbmwClassMediumArmorScore.SetValue(1)
	endif
	if (Skill01 == 7) || (Skill02 == 7) || (Skill03 == 7) || (Skill04 == 7) || (Skill05 == 7) || (Skill06 == 7) || (Skill07 == 7) || (Skill08 == 7) || (Skill09 == 7)
		BaseScript.SkillsScript.fbmwClassPolearmsScore.SetValue(1)
	endif
	if (Skill01 == 8) || (Skill02 == 8) || (Skill03 == 8) || (Skill04 == 8) || (Skill05 == 8) || (Skill06 == 8) || (Skill07 == 8) || (Skill08 == 8) || (Skill09 == 8)
		BaseScript.SkillsScript.fbmwClassSmithingScore.SetValue(1)
	endif
	;===============magic=================
	if (Skill01 == 9) || (Skill02 == 9) || (Skill03 == 9) || (Skill04 == 9) || (Skill05 == 9) || (Skill06 == 9) || (Skill07 == 9) || (Skill08 == 9) || (Skill09 == 9)
		BaseScript.SkillsScript.fbmwClassAlchemyScore.SetValue(1)
	endif
	if (Skill01 == 10) || (Skill02 == 10) || (Skill03 == 10) || (Skill04 == 10) || (Skill05 == 10) || (Skill06 == 10) || (Skill07 == 10) || (Skill08 == 10) || (Skill09 == 10)
		BaseScript.SkillsScript.fbmwClassAlterationScore.SetValue(1)
	endif
	if (Skill01 == 11) || (Skill02 == 11) || (Skill03 == 11) || (Skill04 == 11) || (Skill05 == 11) || (Skill06 == 11) || (Skill07 == 11) || (Skill08 == 11) || (Skill09 == 11)
		BaseScript.SkillsScript.fbmwClassConjurationScore.SetValue(1)
	endif
	if (Skill01 == 12) || (Skill02 == 12) || (Skill03 == 12) || (Skill04 == 12) || (Skill05 == 12) || (Skill06 == 12) || (Skill07 == 12) || (Skill08 == 12) || (Skill09 == 12)
		BaseScript.SkillsScript.fbmwClassDestructionScore.SetValue(1)
	endif
	if (Skill01 == 13) || (Skill02 == 13) || (Skill03 == 13) || (Skill04 == 13) || (Skill05 == 13) || (Skill06 == 13) || (Skill07 == 13) || (Skill08 == 13) || (Skill09 == 13)
		BaseScript.SkillsScript.fbmwClassEnchantingScore.SetValue(1)
	endif
	if (Skill01 == 14) || (Skill02 == 14) || (Skill03 == 14) || (Skill04 == 14) || (Skill05 == 14) || (Skill06 == 14) || (Skill07 == 14) || (Skill08 == 14) || (Skill09 == 14)
		BaseScript.SkillsScript.fbmwClassIllusionScore.SetValue(1)
	endif
	if (Skill01 == 15) || (Skill02 == 15) || (Skill03 == 15) || (Skill04 == 15) || (Skill05 == 15) || (Skill06 == 15) || (Skill07 == 15) || (Skill08 == 15) || (Skill09 == 15)
		BaseScript.SkillsScript.fbmwClassMysticismScore.SetValue(1)
	endif
	if (Skill01 == 16) || (Skill02 == 16) || (Skill03 == 16) || (Skill04 == 16) || (Skill05 == 16) || (Skill06 == 16) || (Skill07 == 16) || (Skill08 == 16) || (Skill09 == 16)
		BaseScript.SkillsScript.fbmwClassRestorationScore.SetValue(1)
	endif
	if (Skill01 == 17) || (Skill02 == 17) || (Skill03 == 17) || (Skill04 == 17) || (Skill05 == 17) || (Skill06 == 17) || (Skill07 == 17) || (Skill08 == 17) || (Skill09 == 17)
		BaseScript.SkillsScript.fbmwClassUnarmoredScore.SetValue(1)
	endif
	;===============stealth=================
	if (Skill01 == 18) || (Skill02 == 18) || (Skill03 == 18) || (Skill04 == 18) || (Skill05 == 18) || (Skill06 == 18) || (Skill07 == 18) || (Skill08 == 18) || (Skill09 == 18)
		BaseScript.SkillsScript.fbmwClassAcrobaticsScore.SetValue(1)
	endif
	if (Skill01 == 19) || (Skill02 == 19) || (Skill03 == 19) || (Skill04 == 19) || (Skill05 == 19) || (Skill06 == 19) || (Skill07 == 19) || (Skill08 == 19) || (Skill09 == 19)
		BaseScript.SkillsScript.fbmwClassHandToHandScore.SetValue(1)
	endif
	if (Skill01 == 20) || (Skill02 == 20) || (Skill03 == 20) || (Skill04 == 20) || (Skill05 == 20) || (Skill06 == 20) || (Skill07 == 20) || (Skill08 == 20) || (Skill09 == 20)
		BaseScript.SkillsScript.fbmwClassLightArmorScore.SetValue(1)
	endif
	if (Skill01 == 21) || (Skill02 == 21) || (Skill03 == 21) || (Skill04 == 21) || (Skill05 == 21) || (Skill06 == 21) || (Skill07 == 21) || (Skill08 == 21) || (Skill09 == 21)
		BaseScript.SkillsScript.fbmwClassMarksmanScore.SetValue(1)
	endif
	if (Skill01 == 22) || (Skill02 == 22) || (Skill03 == 22) || (Skill04 == 22) || (Skill05 == 22) || (Skill06 == 22) || (Skill07 == 22) || (Skill08 == 22) || (Skill09 == 22)
		BaseScript.SkillsScript.fbmwClassMercantileScore.SetValue(1)
	endif
	if (Skill01 == 23) || (Skill02 == 23) || (Skill03 == 23) || (Skill04 == 23) || (Skill05 == 23) || (Skill06 == 23) || (Skill07 == 23) || (Skill08 == 23) || (Skill09 == 23)
		BaseScript.SkillsScript.fbmwClassSecurityScore.SetValue(1)
	endif
	if (Skill01 == 24) || (Skill02 == 24) || (Skill03 == 24) || (Skill04 == 24) || (Skill05 == 24) || (Skill06 == 24) || (Skill07 == 24) || (Skill08 == 24) || (Skill09 == 24)
		BaseScript.SkillsScript.fbmwClassShortBladesScore.SetValue(1)
	endif
	if (Skill01 == 25) || (Skill02 == 25) || (Skill03 == 25) || (Skill04 == 25) || (Skill05 == 25) || (Skill06 == 25) || (Skill07 == 25) || (Skill08 == 25) || (Skill09 == 25)
		BaseScript.SkillsScript.fbmwClassSneakScore.SetValue(1)
	endif
	if (Skill01 == 26) || (Skill02 == 26) || (Skill03 == 26) || (Skill04 == 26) || (Skill05 == 26) || (Skill06 == 26) || (Skill07 == 26) || (Skill08 == 26) || (Skill09 == 26)
		BaseScript.SkillsScript.fbmwClassSpeechcraftScore.SetValue(1)
	endif

	; todo
	BaseScript.SendClassInfo("Adventurer", SpecializationList[Specialization], AttributeList[Attribute01], AttributeList[Attribute02], \
								SkillList[Skill01], SkillList[Skill02], SkillList[Skill03], SkillList[Skill04], SkillList[Skill05], \
								SkillList[Skill06], SkillList[Skill07], SkillList[Skill08])
	if GetStage()>10
		; prereq stage to avoid conflict with rapid chargen
		SetStage(13)
	endif
EndFunction
