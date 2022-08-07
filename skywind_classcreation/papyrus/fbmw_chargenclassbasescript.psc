Scriptname fbmw_ChargenClassBaseScript extends Quest  conditional
{handles class selection}
;Made by Rovan 2/10/18
;changed by yeeb to use custom menu 8/7/22

;=========== properties ==============
;General
Actor Property PlayerRef Auto
Message Property fbmwClassSelectionMethod Auto
fbmw_ChargenSetSkillsScript property SkillsScript Auto
fbmw_ChargenClassGenerateScript property GenerateClassScript Auto
fbmw_ChargenClassPickListScript property PickClassScript Auto
fbmw_ChargenClassCustomScript property CustomClassScript Auto
ReferenceAlias Property ClassNameHolder Auto
idle property IdleWriteLedgerEnter auto
idle property IdleWriteLedgerWrite auto
idle property IdleStop_Loose auto
; ;Combat Class Messages
; Message Property fbmwClassConfirmArcher Auto
; Message Property fbmwClassConfirmBarbarian Auto
; Message Property fbmwClassConfirmCrusader Auto
; Message Property fbmwClassConfirmKnight Auto
; Message Property fbmwClassConfirmRogue Auto
; Message Property fbmwClassConfirmScout Auto
; Message Property fbmwClassConfirmWarrior Auto
; ;Magic Class Messages
; Message Property fbmwClassConfirmBattlemage Auto
; Message Property fbmwClassConfirmHealer Auto
; Message Property fbmwClassConfirmMage Auto
; Message Property fbmwClassConfirmNightblade Auto
; Message Property fbmwClassConfirmSorcerer Auto
; Message Property fbmwClassConfirmSpellsword Auto
; Message Property fbmwClassConfirmWitchhunter Auto
; ;Stealth Class Messages
; Message Property fbmwClassConfirmAcrobat Auto
; Message Property fbmwClassConfirmAgent Auto
; Message Property fbmwClassConfirmAssassin Auto
; Message Property fbmwClassConfirmBard Auto
; Message Property fbmwClassConfirmMonk Auto
; Message Property fbmwClassConfirmPilgrim Auto
; Message Property fbmwClassConfirmThief Auto

; reseting while in dialogue
int property doReset = 0 auto hidden conditional
bool property isDialogue = true auto hidden conditional

;=========== write ledger commands ==============
; define as functions here to make it easier to call in topicinfos
function LedgerEnter(actor myActor)
	;myActor.PlayIdle(IdleWriteLedgerEnter)
endFunction

function LedgerWrite(actor myActor)
	;myActor.PlayIdle(IdleWriteLedgerWrite)
endFunction

function LedgerStop(actor myActor)
	;myActor.PlayIdle(IdleStop_Loose)
	;myActor.SetActorValue("Variable01",0)
	;myActor.EvaluatePackage()
endFunction

;=========== starting point ==============
Function BeginClassSelection()
	int iMethod = fbmwClassSelectionMethod.Show()
	
	if iMethod == 0
		GenerateClassScript.GenerateClass()
	elseif iMethod == 1
		PickClassScript.PickFromClassList()
	else
		CustomClassScript.CreateCustomClass()
	endif
endFunction

;=========== general functions ==============
Function SendClassInfo(string ClassName, string Spec, string Att1, string Att2, string Sk1, string Sk2, string Sk3, string Sk4, string Sk5, string Sk6, string Sk7, string Sk8)
	fbmw_ClassMenuInformation InfoScript = (PlayerRef as fbmw_ClassMenuInformation)
	InfoScript.PlayerClass = ClassName
	InfoScript.Specialization = Spec
	InfoScript.Attribute1 = Att1
	InfoScript.Attribute2 = Att2
	InfoScript.Skill1 = Sk1
	InfoScript.Skill2 = Sk2
	InfoScript.Skill3 = Sk3
	InfoScript.Skill4 = Sk4
	InfoScript.Skill5 = Sk5
	InfoScript.Skill6 = Sk6
	InfoScript.Skill7 = Sk7
	InfoScript.Skill8 = Sk8
	ClassNameHolder.GetReference().GetBaseObject().SetName(ClassName)
endFunction 

;=========== method 1/method 2 shared functions ==============
Function ConfirmClass(int class)
	If class == 0; acrobat
		SetClassToAcrobat()
	elseIf class == 1; agent
		SetClassToAgent()
	elseIf class == 2; archer
		SetClassToArcher()
	elseIf class == 3; assassin
		SetClassToAssassin()
	elseIf class == 4; barbarian
		SetClassToBarbarian()
	elseIf class == 5; bard
		SetClassToBard()
	elseIf class == 6; battlemage
		SetClassToBattlemage()
	elseIf class == 7; crusader
		SetClassToCrusader()
	elseIf class == 8; healer
		SetClassToHealer()
	elseIf class == 9; knight
		SetClassToKnight()
	elseIf class == 10; mage
		SetClassToMage()
	elseIf class == 11; monk
		SetClassToMonk()
	elseIf class == 12; nightblade
		SetClassToNightblade()
	elseIf class == 13; pilgrim
		SetClassToPilgrim()
	elseIf class == 14; rogue
		SetClassToRogue()
	elseIf class == 15; scout
		SetClassToScout()
	elseIf class == 16; sorcerer
		SetClassToSorcerer()
	elseIf class == 17; spellsword
		SetClassToSpellsword()
	elseIf class == 18; thief
		SetClassToThief()
	elseIf class == 19; warrior
		SetClassToWarrior()
	elseIf class == 20; witchhunter
		SetClassToWitchhunter()
	endIf
EndFunction 

;=========== premade classes ==============
Function SetClassToAcrobat()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(3) ; Sets Specialization to Stealth
	SkillsScript.AgilityFavored = true ; First Attribute
	SkillsScript.EnduranceFavored = true ; Second Attribute
	SkillsScript.fbmwClassPolearmsScore.SetValue(1)
	SkillsScript.fbmwClassAlterationScore.SetValue(1)
	SkillsScript.fbmwClassHandToHandScore.SetValue(1)
	SkillsScript.fbmwClassLightArmorScore.SetValue(1)
	SkillsScript.fbmwClassMarksmanScore.SetValue(1)
	SkillsScript.fbmwClassSneakScore.SetValue(1)
	SkillsScript.fbmwClassSpeechcraftScore.SetValue(1)
	SkillsScript.fbmwClassUnarmoredScore.SetValue(1)
	SendClassInfo("Acrobat", "Stealth", "Agility", "Endurance", "Polearm", "Alteration", "Hand-to-Hand", "Light Armor", "Marksman", "Sneak", "Speechcraft", "Unarmored")
EndFunction

Function SetClassToAgent()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(3) ; Sets Specialization to Stealth
	SkillsScript.AgilityFavored = true ; Second Attribute
	SkillsScript.PersonalityFavored = true ; First Attribute
	SkillsScript.fbmwClassSpeechcraftScore.SetValue(1)
	SkillsScript.fbmwClassConjurationScore.SetValue(1)
	SkillsScript.fbmwClassIllusionScore.SetValue(1)
	SkillsScript.fbmwClassLightArmorScore.SetValue(1)
	SkillsScript.fbmwClassSecurityScore.SetValue(1)
	SkillsScript.fbmwClassShortBladesScore.SetValue(1)
	SkillsScript.fbmwClassSpeechcraftScore.SetValue(1)
	SkillsScript.fbmwClassUnarmoredScore.SetValue(1)
	SendClassInfo("Agent", "Stealth", "Agility", "Personality", "Speechcraft", "Conjuration", "Illusion", "Light Armor", "Security", "Short Blade", "Speechcraft", "Unarmored")
EndFunction

Function SetClassToArcher()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(1) ; Sets Specialization to Combat
	SkillsScript.StrengthFavored = true ; Second Attribute
	SkillsScript.AgilityFavored = true ; First Attribute
	SkillsScript.fbmwClassBlockScore.SetValue(1)
	SkillsScript.fbmwClassLongBladeScore.SetValue(1)
	SkillsScript.fbmwClassMediumArmorScore.SetValue(1)
	SkillsScript.fbmwClassPolearmsScore.SetValue(1)
	SkillsScript.fbmwClassRestorationScore.SetValue(1)
	SkillsScript.fbmwClassLightArmorScore.SetValue(1)
	SkillsScript.fbmwClassMarksmanScore.SetValue(1)
	SkillsScript.fbmwClassSneakScore.SetValue(1)
	SendClassInfo("Archer", "Combat", "Strength", "Agility", "Block", "Long Blade", "Medium Armor", "Polearm", "Restoration", "Light Armor", "Marksman", "Sneak")
EndFunction

Function SetClassToAssassin()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(3) ; Sets Specialization to Stealth
	SkillsScript.SpeedFavored = true ; First Attribute
	SkillsScript.IntelligenceFavored = true ; Second Attribute
	SkillsScript.fbmwClassBlockScore.SetValue(1)
	SkillsScript.fbmwClassLongBladeScore.SetValue(1)
	SkillsScript.fbmwClassAlchemyScore.SetValue(1)
	SkillsScript.fbmwClassLightArmorScore.SetValue(1)
	SkillsScript.fbmwClassMarksmanScore.SetValue(1)
	SkillsScript.fbmwClassSecurityScore.SetValue(1)	
	SkillsScript.fbmwClassShortBladesScore.SetValue(1)
	SkillsScript.fbmwClassSneakScore.SetValue(1)		
	SendClassInfo("Assassin", "Stealth", "Speed", "Intelligence", "Block", "Long Blade", "Alchemy", "Light Armor", "Marksman", "Security", "Short Blade", "Sneak")
EndFunction

Function SetClassToBarbarian()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(1) ; Sets Specialization to Combat
	SkillsScript.StrengthFavored = true ; Second Attribute
	SkillsScript.SpeedFavored = true ; First Attribute
	SkillsScript.fbmwClassAxeScore.SetValue(1)
	SkillsScript.fbmwClassBlockScore.SetValue(1)
	SkillsScript.fbmwClassBluntScore.SetValue(1)
	SkillsScript.fbmwClassMediumArmorScore.SetValue(1)
	SkillsScript.fbmwClassSmithingScore.SetValue(1)
	SkillsScript.fbmwClassLightArmorScore.SetValue(1)
	SkillsScript.fbmwClassMarksmanScore.SetValue(1)
	SkillsScript.fbmwClassUnarmoredScore.SetValue(1)			
	SendClassInfo("Barbarian", "Combat", "Strength", "Speed", "Axe", "Block", "Blunt", "Medium Armor", "Smithing", "Light Armor", "Marksman", "Unarmored")
EndFunction

Function SetClassToBard()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(3) ; Sets Specialization to Stealth
	SkillsScript.IntelligenceFavored = true ; Second Attribute
	SkillsScript.PersonalityFavored = true ; First Attribute
	SkillsScript.fbmwClassBlockScore.SetValue(1)
	SkillsScript.fbmwClassLongBladeScore.SetValue(1)
	SkillsScript.fbmwClassMediumArmorScore.SetValue(1)
	SkillsScript.fbmwClassAlchemyScore.SetValue(1)
	SkillsScript.fbmwClassEnchantingScore.SetValue(1)
	SkillsScript.fbmwClassIllusionScore.SetValue(1)
	SkillsScript.fbmwClassSecurityScore.SetValue(1)
	SkillsScript.fbmwClassSpeechcraftScore.SetValue(1)			
	SendClassInfo("Bard", "Stealth", "Intelligence", "Personality", "Block", "Long Blade", "Medium Armor", "Alchemy", "Enchanting", "Illusion", "Security", "Speechcraft")
EndFunction

Function SetClassToBattlemage()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(2) ; Sets Specialization to Magic
	SkillsScript.StrengthFavored = true ; Second Attribute
	SkillsScript.IntelligenceFavored = true ; First Attribute
	SkillsScript.fbmwClassAxeScore.SetValue(1)
	SkillsScript.fbmwClassHeavyArmorScore.SetValue(1)
	SkillsScript.fbmwClassSmithingScore.SetValue(1)
	SkillsScript.fbmwClassAlterationScore.SetValue(1)
	SkillsScript.fbmwClassConjurationScore.SetValue(1)
	SkillsScript.fbmwClassDestructionScore.SetValue(1)
	SkillsScript.fbmwClassEnchantingScore.SetValue(1)
	SkillsScript.fbmwClassMysticismScore.SetValue(1)	
	SendClassInfo("Battlemage", "Magic", "Strength", "Intelligence", "Axe", "Heavy Armor", "Smithing", "Alteration", "Conjuration", "Destruction", "Enchanting", "Mysticism")
EndFunction

Function SetClassToCrusader()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(1) ; Sets Specialization to Combat
	SkillsScript.StrengthFavored = true ; Second Attribute
	SkillsScript.AgilityFavored = true ; First Attribute
	SkillsScript.fbmwClassBlockScore.SetValue(1)
	SkillsScript.fbmwClassBluntScore.SetValue(1)
	SkillsScript.fbmwClassHeavyArmorScore.SetValue(1)
	SkillsScript.fbmwClassLongBladeScore.SetValue(1)
	SkillsScript.fbmwClassSmithingScore.SetValue(1)
	SkillsScript.fbmwClassAlchemyScore.SetValue(1)		
	SkillsScript.fbmwClassDestructionScore.SetValue(1)
	SkillsScript.fbmwClassRestorationScore.SetValue(1)
	SendClassInfo("Crusader", "Combat", "Strength", "Agility", "Block", "Blunt", "Heavy Armor", "Long Blade", "Smithing", "Alchemy", "Destruction", "Restoration")
EndFunction

Function SetClassToHealer()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(2) ; Sets Specialization to Magic
	SkillsScript.WillpowerFavored = true ; First Attribute
	SkillsScript.PersonalityFavored = true ; Second Attribute
	SkillsScript.fbmwClassBluntScore.SetValue(1)
	SkillsScript.fbmwClassAlchemyScore.SetValue(1)
	SkillsScript.fbmwClassAlterationScore.SetValue(1)
	SkillsScript.fbmwClassMysticismScore.SetValue(1)
	SkillsScript.fbmwClassRestorationScore.SetValue(1)
	SkillsScript.fbmwClassHandToHandScore.SetValue(1)
	SkillsScript.fbmwClassSpeechcraftScore.SetValue(1)
	SkillsScript.fbmwClassUnarmoredScore.SetValue(1)
	SendClassInfo("Healer", "Magic", "Willpower", "Personality", "Blunt", "Alchemy", "Alteration", "Mysticism", "Restoration", "Hand-to-Hand", "Speechcraft", "Unarmored")	
EndFunction

Function SetClassToKnight()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(1) ; Sets Specialization to Combat
	SkillsScript.StrengthFavored = true ; Second Attribute
	SkillsScript.PersonalityFavored = true ; First Attribute
	SkillsScript.fbmwClassBlockScore.SetValue(1)
	SkillsScript.fbmwClassHeavyArmorScore.SetValue(1)
	SkillsScript.fbmwClassLongBladeScore.SetValue(1)
	SkillsScript.fbmwClassMediumArmorScore.SetValue(1)
	SkillsScript.fbmwClassSmithingScore.SetValue(1)
	SkillsScript.fbmwClassRestorationScore.SetValue(1)	
	SkillsScript.fbmwClassSpeechcraftScore.SetValue(1)
	SkillsScript.fbmwClassUnarmoredScore.SetValue(1)
	SendClassInfo("Knight", "Combat", "Strength", "Personality", "Block", "Heavy Armor", "Long Blade", "Medium Armor", "Smithing", "Restoration", "Speechcraft", "Unarmored")
EndFunction

Function SetClassToMage()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(2) ; Sets Specialization to Magic
	SkillsScript.IntelligenceFavored = true ; First Attribute
	SkillsScript.WillpowerFavored = true ; Second Attribute
	SkillsScript.fbmwClassAlchemyScore.SetValue(1)
	SkillsScript.fbmwClassAlterationScore.SetValue(1)
	SkillsScript.fbmwClassConjurationScore.SetValue(1)
	SkillsScript.fbmwClassDestructionScore.SetValue(1)	
	SkillsScript.fbmwClassEnchantingScore.SetValue(1)
	SkillsScript.fbmwClassIllusionScore.SetValue(1)
	SkillsScript.fbmwClassMysticismScore.SetValue(1)
	SkillsScript.fbmwClassRestorationScore.SetValue(1)
	SendClassInfo("Mage", "Magic", "Intelligence", "Willpower", "Alchemy", "Alteration", "Conjuration", "Destruction", "Enchanting", "Illusion", "Mysticism", "Restoration")
EndFunction

Function SetClassToMonk()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(3) ; Sets Specialization to Stealth
	SkillsScript.WillpowerFavored = true ; First Attribute
	SkillsScript.AgilityFavored = true ; Second Attribute
	SkillsScript.fbmwClassBluntScore.SetValue(1)
	SkillsScript.fbmwClassPolearmsScore.SetValue(1)
	SkillsScript.fbmwClassRestorationScore.SetValue(1)
	SkillsScript.fbmwClassHandToHandScore.SetValue(1)
	SkillsScript.fbmwClassLightArmorScore.SetValue(1)
	SkillsScript.fbmwClassSneakScore.SetValue(1)
	SkillsScript.fbmwClassSpeechcraftScore.SetValue(1)
	SkillsScript.fbmwClassUnarmoredScore.SetValue(1)
	SendClassInfo("Monk", "Stealth", "Willpower", "Agility", "Blunt", "Polearm", "Restoration", "Hand-to-Hand", "Light Armor", "Sneak", "Speechcraft", "Unarmored")
EndFunction

Function SetClassToNightblade()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(2) ; Sets Specialization to Magic
	SkillsScript.WillpowerFavored = true ; First Attribute
	SkillsScript.SpeedFavored = true ; Second Attribute
	SkillsScript.fbmwClassAlterationScore.SetValue(1)
	SkillsScript.fbmwClassDestructionScore.SetValue(1)
	SkillsScript.fbmwClassIllusionScore.SetValue(1)
	SkillsScript.fbmwClassMysticismScore.SetValue(1)
	SkillsScript.fbmwClassLightArmorScore.SetValue(1)
	SkillsScript.fbmwClassSecurityScore.SetValue(1)
	SkillsScript.fbmwClassShortBladesScore.SetValue(1)
	SkillsScript.fbmwClassSneakScore.SetValue(1)
	SendClassInfo("Nightblade", "Magic", "Willpower", "Speed", "Alteration", "Destruction", "Illusion", "Mysticism", "Light Armor", "Security", "Short Blade", "Sneak")
EndFunction

Function SetClassToPilgrim()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(3) ; Sets Specialization to Stealth
	SkillsScript.EnduranceFavored = true ; First Attribute
	SkillsScript.PersonalityFavored = true ; Second Attribute
	SkillsScript.fbmwClassMediumArmorScore.SetValue(1)
	SkillsScript.fbmwClassAlchemyScore.SetValue(1)
	SkillsScript.fbmwClassIllusionScore.SetValue(1)
	SkillsScript.fbmwClassRestorationScore.SetValue(1)
	SkillsScript.fbmwClassHandToHandScore.SetValue(1)
	SkillsScript.fbmwClassMarksmanScore.SetValue(1)
	SkillsScript.fbmwClassRestorationScore.SetValue(1)
	SkillsScript.fbmwClassSpeechcraftScore.SetValue(1)
	SendClassInfo("Pilgrim", "Stealth", "Endurance", "Personality", "Medium Armor", "Alchemy", "Illusion", "Restoration", "Hand-to-Hand", "Marksman", "Restoration", "Speechcraft")
EndFunction

Function SetClassToRogue()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(1) ; Sets Specialization to Combat
	SkillsScript.SpeedFavored = true ; First Attribute
	SkillsScript.PersonalityFavored = true ; Second Attribute
	SkillsScript.fbmwClassAxeScore.SetValue(1)
	SkillsScript.fbmwClassLongBladeScore.SetValue(1)
	SkillsScript.fbmwClassMediumArmorScore.SetValue(1)
	SkillsScript.fbmwClassHandToHandScore.SetValue(1)
	SkillsScript.fbmwClassLightArmorScore.SetValue(1)
	SkillsScript.fbmwClassSecurityScore.SetValue(1)	
	SkillsScript.fbmwClassShortBladesScore.SetValue(1)
	SkillsScript.fbmwClassSpeechcraftScore.SetValue(1)
	SendClassInfo("Rogue", "Combat", "Speed", "Personality", "Axe", "Long Blade", "Medium Armor", "Hand-to-Hand", "Light Armor", "Security", "Short Blade", "Speechcraft")
EndFunction

Function SetClassToScout()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(1) ; Sets Specialization to Combat
	SkillsScript.SpeedFavored = true ; First Attribute
	SkillsScript.EnduranceFavored = true ; Second Attribute
	SkillsScript.fbmwClassMediumArmorScore.SetValue(1)
	SkillsScript.fbmwClassPolearmsScore.SetValue(1)
	SkillsScript.fbmwClassAlchemyScore.SetValue(1)
	SkillsScript.fbmwClassAlterationScore.SetValue(1)
	SkillsScript.fbmwClassLightArmorScore.SetValue(1)
	SkillsScript.fbmwClassMarksmanScore.SetValue(1)	
	SkillsScript.fbmwClassSneakScore.SetValue(1)
	SkillsScript.fbmwClassUnarmoredScore.SetValue(1)	
	SendClassInfo("Scout", "Combat", "Speed", "Endurance", "Medium Armor", "Polearm", "Alchemy", "Alteration", "Light Armor", "Marksman", "Sneak", "Unarmored")
EndFunction

Function SetClassToSorcerer()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(2) ; Sets Specialization to Magic
	SkillsScript.IntelligenceFavored = true ; Second Attribute
	SkillsScript.EnduranceFavored = true ; First Attribute
	SkillsScript.fbmwClassHeavyArmorScore.SetValue(1)
	SkillsScript.fbmwClassAlterationScore.SetValue(1)
	SkillsScript.fbmwClassConjurationScore.SetValue(1)
	SkillsScript.fbmwClassDestructionScore.SetValue(1)
	SkillsScript.fbmwClassEnchantingScore.SetValue(1)
	SkillsScript.fbmwClassMysticismScore.SetValue(1)	
	SkillsScript.fbmwClassMarksmanScore.SetValue(1)
	SkillsScript.fbmwClassShortBladesScore.SetValue(1)
	SendClassInfo("Sorcerer", "Magic", "Intelligence", "Endurance", "Heavy Armor", "Alteration", "Conjuration", "Destruction", "Enchanting", "Mysticism", "Marksman", "Short Blade")
EndFunction

Function SetClassToSpellsword()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(2) ; Sets Specialization to Magic
	SkillsScript.WillpowerFavored = true ; Second Attribute
	SkillsScript.EnduranceFavored = true ; First Attribute
	SkillsScript.fbmwClassBlockScore.SetValue(1)
	SkillsScript.fbmwClassMediumArmorScore.SetValue(1)
	SkillsScript.fbmwClassLongBladeScore.SetValue(1)
	SkillsScript.fbmwClassAlchemyScore.SetValue(1)
	SkillsScript.fbmwClassAlterationScore.SetValue(1)
	SkillsScript.fbmwClassDestructionScore.SetValue(1)
	SkillsScript.fbmwClassEnchantingScore.SetValue(1)
	SkillsScript.fbmwClassRestorationScore.SetValue(1)
	SendClassInfo("Spellsword", "Magic", "Willpower", "Endurance", "Block", "Medium Armor", "Long Blade", "Alchemy", "Alteration", "Destruction", "Enchanting", "Restoration")
EndFunction

Function SetClassToThief()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(3) ; Sets Specialization to Stealth
	SkillsScript.AgilityFavored = true ; Second Attribute
	SkillsScript.SpeedFavored = true ; First Attribute
	SkillsScript.fbmwClassHandToHandScore.SetValue(1)
	SkillsScript.fbmwClassLightArmorScore.SetValue(1)
	SkillsScript.fbmwClassMarksmanScore.SetValue(1)
	SkillsScript.fbmwClassSecurityScore.SetValue(1)
	SkillsScript.fbmwClassShortBladesScore.SetValue(1)
	SkillsScript.fbmwClassSneakScore.SetValue(1)
	SkillsScript.fbmwClassSpeechcraftScore.SetValue(1)
	SkillsScript.fbmwClassUnarmoredScore.SetValue(1)
	SendClassInfo("Thief", "Stealth", "Agility", "Speed", "Hand-to-Hand", "Light Armor", "Marksman", "Security", "Short Blade", "Sneak", "Speechcraft", "Unarmored")
EndFunction

Function SetClassToWarrior()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(1) ; Sets Specialization to Combat
	SkillsScript.StrengthFavored = true ; Second Attribute
	SkillsScript.EnduranceFavored = true ; First Attribute
	SkillsScript.fbmwClassAxeScore.SetValue(1)
	SkillsScript.fbmwClassBlockScore.SetValue(1)
	SkillsScript.fbmwClassBluntScore.SetValue(1)
	SkillsScript.fbmwClassHeavyArmorScore.SetValue(1)
	SkillsScript.fbmwClassMediumArmorScore.SetValue(1)	
	SkillsScript.fbmwClassLongBladeScore.SetValue(1)
	SkillsScript.fbmwClassPolearmsScore.SetValue(1)
	SkillsScript.fbmwClassSmithingScore.SetValue(1)		
	SendClassInfo("Warrior", "Combat", "Strength", "Endurance", "Axe", "Block", "Blunt", "Heavy Armor", "Medium Armor", "Long Blade", "Polearm", "Smithing")
EndFunction

Function SetClassToWitchhunter()
	SkillsScript.ResetClass()
	SkillsScript.fbmwClassSpecialization.SetValue(2) ; Sets Specialization to Magic
	SkillsScript.IntelligenceFavored = true ; First Attribute
	SkillsScript.AgilityFavored = true ; Second Attribute
	SkillsScript.fbmwClassBluntScore.SetValue(1)
	SkillsScript.fbmwClassPolearmsScore.SetValue(1)
	SkillsScript.fbmwClassAlchemyScore.SetValue(1)
	SkillsScript.fbmwClassConjurationScore.SetValue(1)
	SkillsScript.fbmwClassEnchantingScore.SetValue(1)
	SkillsScript.fbmwClassMysticismScore.SetValue(1)
	SkillsScript.fbmwClassSneakScore.SetValue(1)
	SkillsScript.fbmwClassUnarmoredScore.SetValue(1)
	SendClassInfo("Witchhunter", "Magic", "Intelligence", "Agility", "Blunt", "Polearm", "Alchemy", "Conjuration", "Enchanting", "Mysticism", "Sneak", "Unarmored")
EndFunction
