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
; result variables
string ClassName = ""
int Specialization = -1
int Attribute01 = -1
int Attribute02 = -1
int Skill01 = -1
int Skill02 = -1
int Skill03 = -1
int Skill04 = -1
int Skill05 = -1
int Skill06 = -1
int Skill07 = -1
int Skill08 = -1

; menu variables
string MenuName
string MenuSpecialization
string MenuAttribute01
string MenuAttribute02
string MenuSkill01
string MenuSkill02
string MenuSkill03
string MenuSkill04
string MenuSkill05
string MenuSkill06
string MenuSkill07
string MenuSkill08

; finalization variables
string ClassSpecialization
string ClassAttribute01
string ClassAttribute02
string ClassSkill01
string ClassSkill02
string ClassSkill03
string ClassSkill04
string ClassSkill05
string ClassSkill06
string ClassSkill07
string ClassSkill08

;========== main process ==========
Function CreateCustomClass()
	; open class menu in custom mode (mode 2)
	; second arg is only needed for confirmation mode so set to -1 why not
	Skywind.OpenClassMenu(2, -1);
EndFunction

Function ConfirmClass(int Attribute01, int Attribute02, int Specialization, int Skill01, int Skill02, int Skill03, int Skill04, int Skill05, int Skill06, int Skill07, int Skill08, int Skill09)
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

	BaseScript.SendClassInfo(ClassName, ClassSpecialization, ClassAttribute01, ClassAttribute02, \
								ClassSkill01, ClassSkill02, ClassSkill03, ClassSkill04, ClassSkill05, ClassSkill06, ClassSkill07, ClassSkill08)
	if GetStage()>10
		; prereq stage to avoid conflict with rapid chargen
		SetStage(13)
	endif
EndFunction

Function FillOutForms()
	string[] MenuList = new string[15]
	MenuList[0] = MenuName
	MenuList[1] = MenuSpecialization
	MenuList[2] = MenuAttribute01
	MenuList[3] = MenuAttribute02
	MenuList[4] = MenuSkill01
	MenuList[5] = MenuSkill02
	MenuList[6] = MenuSkill03
	MenuList[7] = MenuSkill04
	MenuList[8] = MenuSkill05
	MenuList[9] = MenuSkill06
	MenuList[10] = MenuSkill07
	MenuList[11] = MenuSkill08
	MenuList[12] = "Finish"
	MenuList[13] = "Reset"
	MenuList[14] = "Go Back"
	int aiButton = (((self as quest) as form) as UILIB_1).ShowList("Create Class", MenuList, 0, 0)
	If aiButton == 0
		SetClassName()
	ElseIf aiButton == 1
		SetSpecialization()
	ElseIf aiButton == 2
		SetFirstAttribute()
	ElseIf aiButton == 3
		SetSecondAttribute()
	ElseIf aiButton == 4
		SetSkill01()
	ElseIf aiButton == 5
		SetSkill02()
	ElseIf aiButton == 6
		SetSkill03()
	ElseIf aiButton == 7
		SetSkill04()
	ElseIf aiButton == 8
		SetSkill05()
	ElseIf aiButton == 9
		SetSkill06()
	ElseIf aiButton == 10
		SetSkill07()
	ElseIf aiButton == 11
		SetSkill08()
	ElseIf aiButton == 12
		ConfirmCustomClass()
	ElseIf aiButton == 13
		CreateCustomClass()
	Else
		if BaseScript.isDialogue
			BaseScript.doReset = 1
		else
			BaseScript.BeginClassSelection()
		endif
		
	EndIf
EndFunction

Function ResetCustomClass()
	MenuName = "Class Name: (Enter Name)"
	MenuSpecialization = "Specialization: (Select)"
	MenuAttribute01 = "Favored Attribute #1: (Select)"
	MenuAttribute02 = "Favored Attribute #2: (Select)"
	MenuSkill01 = "Major Skill #1: (Select)"
	MenuSkill02 = "Major Skill #2: (Select)"
	MenuSkill03 = "Major Skill #3: (Select)"
	MenuSkill04 = "Major Skill #4: (Select)"
	MenuSkill05 = "Major Skill #5: (Select)"
	MenuSkill06 = "Major Skill #6: (Select)"
	MenuSkill07 = "Major Skill #7: (Select)"
	MenuSkill08 = "Major Skill #8: (Select)"
	Specialization = -1
	Attribute01 = -1
	Attribute02 = -1
	Skill01 = -1
	Skill02 = -1
	Skill03 = -1
	Skill04 = -1
	Skill05 = -1
	Skill06 = -1
	Skill07 = -1
	Skill08 = -1
endFunction

;========== finish ==========
Function ConfirmCustomClass()
	if (Specialization == -1) || (Attribute01 == -1) || (Attribute02 == -1) || (Skill01 == -1) || (Skill02 == -1) || (Skill03 == -1) || (Skill04 == -1) || (Skill05 == -1) || (Skill06 == -1) || (Skill07 == -1) || (Skill08 == -1)
		SelectFail.Play(PlayerRef)
		FillOutForms()
	else
		string ClassDetails = ComputeSummary()
		debug.MessageBox(ClassDetails)
		BaseScript.ClassNameHolder.GetReference().GetBaseObject().SetName(ClassName)
		string fc = StringUtil.GetNthChar(ClassName,0)
		int aiButton
		if (fc == "a") || (fc == "A") || (fc == "e") || (fc == "E") || (fc == "i") || (fc == "I") || (fc == "o") || (fc == "O") || (fc == "u") || (fc == "U")
			aiButton = fbmwClassConfirmCustomB.Show()
		else
			aiButton = fbmwClassConfirmCustomA.Show()
		endif
		if aiButton == 0
			FinalizeCustomClass()
		else
			FillOutForms()
		endif
	endif
EndFunction

string Function ComputeSummary()
	; start
	String ClassDetails = "Class Name: " + ClassName + "\n\n"
	
	; specialization
	if Specialization == 0
		ClassSpecialization = "Combat"
	elseif Specialization == 1
		ClassSpecialization = "Magic"
	elseif Specialization == 2
		ClassSpecialization = "Stealth"
	endif
	ClassDetails += "Specialization: " + ClassSpecialization + "\n\n" 
	
	; attributes
	ClassAttribute01 = AttributeStringByIndex(Attribute01)
	ClassAttribute02 = AttributeStringByIndex(Attribute02)
	ClassDetails += "Favored Attributes: " + ClassAttribute01 + ", " + ClassAttribute02 + "\n\n"
	
	; skills
	ClassSkill01 = SkillStringByIndex(Skill01)
	ClassSkill02 = SkillStringByIndex(Skill02)
	ClassSkill03 = SkillStringByIndex(Skill03)
	ClassSkill04 = SkillStringByIndex(Skill04)
	ClassSkill05 = SkillStringByIndex(Skill05)
	ClassSkill06 = SkillStringByIndex(Skill06)
	ClassSkill07 = SkillStringByIndex(Skill07)
	ClassSkill08 = SkillStringByIndex(Skill08)
	ClassDetails += "Major Skills: " + ClassSkill01 + ", " + ClassSkill02 + ", " + ClassSkill03 + ", " + ClassSkill04 \
					 + ", " + ClassSkill05 + ", " + ClassSkill06 + ", " + ClassSkill07 + ", " + ClassSkill08
	return ClassDetails
EndFunction

;========== class name ==========
Function SetClassName()
	string asInput
	asInput = (((self as quest) as form) as UILIB_1).ShowTextInput("Set Class Name", "Adventurer")
	if asInput == ""
		MenuName = "Class Name: (Enter Name)"
	else
		MenuName = "Class Name: " + asInput
	endif
	ClassName = asInput
	FillOutForms()
EndFunction

;========== specialization ==========
Function SetSpecialization()
	string[] SpecializationList = new string[4]
	SpecializationList[0] = "Combat"
	SpecializationList[1] = "Magic"
	SpecializationList[2] = "Stealth"
	SpecializationList[3] = "Go Back"
	int aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Specialization:", SpecializationList, 0, 3)
	if aiButton == 0
		MenuSpecialization = "Specialization: Combat"
		Specialization = 0
	elseif aiButton == 1
		MenuSpecialization = "Specialization: Magic"
		Specialization = 1
	elseif aiButton == 2
		MenuSpecialization = "Specialization: Stealth"
		Specialization = 2
	else
		; no change
	endif
	FillOutForms()
EndFunction

;========== Set First Attribute ==========
Function SetFirstAttribute()
	string[] AttributeList = new string[9]
	AttributeList[0] = "Strength"
	AttributeList[1] = "Intelligence"
	AttributeList[2] = "Willpower"
	AttributeList[3] = "Agility"
	AttributeList[4] = "Speed"
	AttributeList[5] = "Endurance"
	AttributeList[6] = "Personality"
	AttributeList[7] = "Luck"
	AttributeList[8] = "Go Back"
	int aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Favored Attribute:", AttributeList, 0, 8)
	If (aiButton > 7) || (aiButton < 0)
		FillOutForms()
		
	ElseIf aiButton == Attribute02
		SelectFail.Play(PlayerRef)
		SetFirstAttribute()
		
	Else
		Attribute01 = aiButton
		If aiButton == 0
			MenuAttribute01 = "Favored Attribute: " + "Strength"
		ElseIf aiButton == 1
			MenuAttribute01 = "Favored Attribute: " + "Intelligence"
		ElseIf aiButton == 2
			MenuAttribute01 = "Favored Attribute: " + "Willpower"
		ElseIf aiButton == 3
			MenuAttribute01 = "Favored Attribute: " + "Agility"
		ElseIf aiButton == 4
			MenuAttribute01 = "Favored Attribute: " + "Speed"
		ElseIf aiButton == 5
			MenuAttribute01 = "Favored Attribute: " + "Endurance"
		ElseIf aiButton == 6
			MenuAttribute01 = "Favored Attribute: " + "Personality"
		ElseIf aiButton == 7
			MenuAttribute01 = "Favored Attribute: " + "Luck"
		EndIf
		FillOutForms()
	EndIf
EndFunction

;========== Set Second Attribute ==========
Function SetSecondAttribute()
	string[] AttributeList = new string[9]
	AttributeList[0] = "Strength"
	AttributeList[1] = "Intelligence"
	AttributeList[2] = "Willpower"
	AttributeList[3] = "Agility"
	AttributeList[4] = "Speed"
	AttributeList[5] = "Endurance"
	AttributeList[6] = "Personality"
	AttributeList[7] = "Luck"
	AttributeList[8] = "Go Back"
	int aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Favored Attribute:", AttributeList, 0, 8)
	If (aiButton > 7) || (aiButton < 0)
		FillOutForms()
		
	ElseIf aiButton == Attribute01
		SelectFail.Play(PlayerRef)
		SetSecondAttribute()
		
	Else
		Attribute02 = aiButton
		If aiButton == 0
			MenuAttribute02 = "Favored Attribute: " + "Strength"
		ElseIf aiButton == 1
			MenuAttribute01 = "Favored Attribute: " + "Intelligence"
		ElseIf aiButton == 2
			MenuAttribute02 = "Favored Attribute: " + "Willpower"
		ElseIf aiButton == 3
			MenuAttribute02 = "Favored Attribute: " + "Agility"
		ElseIf aiButton == 4
			MenuAttribute02 = "Favored Attribute: " + "Speed"
		ElseIf aiButton == 5
			MenuAttribute02 = "Favored Attribute: " + "Endurance"
		ElseIf aiButton == 6
			MenuAttribute02 = "Favored Attribute: " + "Personality"
		ElseIf aiButton == 7
			MenuAttribute02 = "Favored Attribute: " + "Luck"
		EndIf
		FillOutForms()
	EndIf
EndFunction

;========== set skills==========
Function SetSkill01(int iType = -1)
	if iType == -1
		string[] TypeList = new string[4]
		TypeList[0] = "Combat"
		TypeList[1] = "Magic"
		TypeList[2] = "Stealth"
		TypeList[3] = "Go Back"
		iType = 10*(((self as quest) as form) as UILIB_1).ShowList("Select Skill Type:", TypeList, 0, 0)	;*10 to separate into categories, 0x = combat, 1x = magic, 2x = stealth
	endif
	int aiButton = -1
	If iType == 0
		string[] CombatList = new string[10]
		CombatList[0] = "Athletics"
		CombatList[1] = "Axe"
		CombatList[2] = "Block"
		CombatList[3] = "Blunt"
		CombatList[4] = "Heavy Armor"
		CombatList[5] = "Long Blade"
		CombatList[6] = "Medium Armor"
		CombatList[7] = "Polearm"
		CombatList[8] = "Smithing"
		CombatList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", CombatList, 0, 9)	;create the list of choices
		
	ElseIf iType == 10
		string[] MagicList = new string[10]
		MagicList[0] = "Alchemy"
		MagicList[1] = "Alteration"
		MagicList[2] = "Conjuration"
		MagicList[3] = "Destruction"
		MagicList[4] = "Enchanting"
		MagicList[5] = "Illusion"
		MagicList[6] = "Mysticism"
		MagicList[7] = "Restoration"
		MagicList[8] = "Unarmored"
		MagicList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", MagicList, 0, 9)
	
	ElseIf iType == 20
		string[] StealthList = new string[10]
		StealthList[0] = "Acrobatics"
		StealthList[1] = "Hand-to-Hand"
		StealthList[2] = "Light Armor"
		StealthList[3] = "Marksman"
		StealthList[4] = "Mercantile"
		StealthList[5] = "Security"
		StealthList[6] = "Short Blade"
		StealthList[7] = "Sneak"
		StealthList[8] = "Speechcraft"
		StealthList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", StealthList, 0, 9)
	
	EndIf
	
	int index = iType + aiButton
	If (aiButton > 8) || (aiButton < 0)	; > 8 is Go Back, < 0 is cancel
		FillOutForms()
		
	ElseIf !((iType == 00) || (iType == 10) || (iType == 20))
		FillOutForms()
	
	ElseIf (Skill02 == index) || (Skill03 == index) || (Skill04 == index) || (Skill05 == index) || (Skill06 == index) || (Skill07 == index) || (Skill08 == index)
		SelectFail.Play(PlayerRef)	;skill was already selected before in another slot
		SetSkill01(iType)
	
	Else
		Skill01 = index	;sets the actual integer for the skill selected. Sets the correct globals at the 'FinalizeCustomClass()' function
		If index == 00
			MenuSkill01 = "Major Skill #1: " + "Athletics"
		ElseIf index == 01
			MenuSkill01 = "Major Skill #1: " + "Axe"
		ElseIf index == 02
			MenuSkill01 = "Major Skill #1: " + "Block"
		ElseIf index == 03
			MenuSkill01 = "Major Skill #1: " + "Blunt"
		ElseIf index == 04
			MenuSkill01 = "Major Skill #1: " + "Heavy Armor"
		ElseIf index == 05
			MenuSkill01 = "Major Skill #1: " + "Long Blade"
		ElseIf index == 06
			MenuSkill01 = "Major Skill #1: " + "Medium Armor"
		ElseIf index == 07
			MenuSkill01 = "Major Skill #1: " + "Polearm"
		ElseIf index == 08
			MenuSkill01 = "Major Skill #1: " + "Smithing"
			
		ElseIf index == 10
			MenuSkill01 = "Major Skill #1: " + "Alchemy"
		ElseIf index == 11
			MenuSkill01 = "Major Skill #1: " + "Alteration"
		ElseIf index == 12
			MenuSkill01 = "Major Skill #1: " + "Conjuration"
		ElseIf index == 13
			MenuSkill01 = "Major Skill #1: " + "Destruction"
		ElseIf index == 14
			MenuSkill01 = "Major Skill #1: " + "Enchanting"
		ElseIf index == 15
			MenuSkill01 = "Major Skill #1: " + "Illusion"
		ElseIf index == 16
			MenuSkill01 = "Major Skill #1: " + "Mysticism"
		ElseIf index == 17
			MenuSkill01 = "Major Skill #1: " + "Restoration"
		ElseIf index == 18
			MenuSkill01 = "Major Skill #1: " + "Unarmored"
			
		ElseIf index == 20
			MenuSkill01 = "Major Skill #1: " + "Acrobatics"
		ElseIf index == 21
			MenuSkill01 = "Major Skill #1: " + "Hand-to-Hand"
		ElseIf index == 22
			MenuSkill01 = "Major Skill #1: " + "Light Armor"
		ElseIf index == 23
			MenuSkill01 = "Major Skill #1: " + "Marksman"
		ElseIf index == 24
			MenuSkill01 = "Major Skill #1: " + "Mercantile"
		ElseIf index == 25
			MenuSkill01 = "Major Skill #1: " + "Security"
		ElseIf index == 26
			MenuSkill01 = "Major Skill #1: " + "Short Blade"
		ElseIf index == 27
			MenuSkill01 = "Major Skill #1: " + "Sneak"
		ElseIf index == 28
			MenuSkill01 = "Major Skill #1: " + "Speechcraft"
			
		EndIf
		
		FillOutForms()
	EndIf
EndFunction

Function SetSkill02(int iType = -1)
	if iType == -1
		string[] TypeList = new string[4]
		TypeList[0] = "Combat"
		TypeList[1] = "Magic"
		TypeList[2] = "Stealth"
		TypeList[3] = "Go Back"
		iType = 10*(((self as quest) as form) as UILIB_1).ShowList("Select Skill Type:", TypeList, 0, 0)
	endif
	int aiButton = -1
	If iType == 0
		string[] CombatList = new string[10]
		CombatList[0] = "Athletics"
		CombatList[1] = "Axe"
		CombatList[2] = "Block"
		CombatList[3] = "Blunt"
		CombatList[4] = "Heavy Armor"
		CombatList[5] = "Long Blade"
		CombatList[6] = "Medium Armor"
		CombatList[7] = "Polearm"
		CombatList[8] = "Smithing"
		CombatList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", CombatList, 0, 9)
		
	ElseIf iType == 10
		string[] MagicList = new string[10]
		MagicList[0] = "Alchemy"
		MagicList[1] = "Alteration"
		MagicList[2] = "Conjuration"
		MagicList[3] = "Destruction"
		MagicList[4] = "Enchanting"
		MagicList[5] = "Illusion"
		MagicList[6] = "Mysticism"
		MagicList[7] = "Restoration"
		MagicList[8] = "Unarmored"
		MagicList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", MagicList, 0, 9)
	
	ElseIf iType == 20
		string[] StealthList = new string[10]
		StealthList[0] = "Acrobatics"
		StealthList[1] = "Hand-to-Hand"
		StealthList[2] = "Light Armor"
		StealthList[3] = "Marksman"
		StealthList[4] = "Mercantile"
		StealthList[5] = "Security"
		StealthList[6] = "Short Blade"
		StealthList[7] = "Sneak"
		StealthList[8] = "Speechcraft"
		StealthList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", StealthList, 0, 9)
	
	EndIf
	
	int index = iType + aiButton
	If (aiButton > 8) || (aiButton < 0)
		FillOutForms()
		
	ElseIf !((iType == 00) || (iType == 10) || (iType == 20))
		FillOutForms()
	
	ElseIf (Skill01 == index) || (Skill03 == index) || (Skill04 == index) || (Skill05 == index) || (Skill06 == index) || (Skill07 == index) || (Skill08 == index)
		SelectFail.Play(PlayerRef)
		SetSkill01(iType)
	
	Else
		Skill02 = index
		If index == 00
			MenuSkill02 = "Major Skill #2: " + "Athletics"
		ElseIf index == 01
			MenuSkill02 = "Major Skill #2: " + "Axe"
		ElseIf index == 02
			MenuSkill02 = "Major Skill #2: " + "Block"
		ElseIf index == 03
			MenuSkill02 = "Major Skill #2: " + "Blunt"
		ElseIf index == 04
			MenuSkill02 = "Major Skill #2: " + "Heavy Armor"
		ElseIf index == 05
			MenuSkill02 = "Major Skill #2: " + "Long Blade"
		ElseIf index == 06
			MenuSkill02 = "Major Skill #2: " + "Medium Armor"
		ElseIf index == 07
			MenuSkill02 = "Major Skill #2: " + "Polearm"
		ElseIf index == 08
			MenuSkill02 = "Major Skill #2: " + "Smithing"
			
		ElseIf index == 10
			MenuSkill02 = "Major Skill #2: " + "Alchemy"
		ElseIf index == 11
			MenuSkill02 = "Major Skill #2: " + "Alteration"
		ElseIf index == 12
			MenuSkill02 = "Major Skill #2: " + "Conjuration"
		ElseIf index == 13
			MenuSkill02 = "Major Skill #2: " + "Destruction"
		ElseIf index == 14
			MenuSkill02 = "Major Skill #2: " + "Enchanting"
		ElseIf index == 15
			MenuSkill02 = "Major Skill #2: " + "Illusion"
		ElseIf index == 16
			MenuSkill02 = "Major Skill #2: " + "Mysticism"
		ElseIf index == 17
			MenuSkill02 = "Major Skill #2: " + "Restoration"
		ElseIf index == 18
			MenuSkill02 = "Major Skill #2: " + "Unarmored"
			
		ElseIf index == 20
			MenuSkill02 = "Major Skill #2: " + "Acrobatics"
		ElseIf index == 21
			MenuSkill02 = "Major Skill #2: " + "Hand-to-Hand"
		ElseIf index == 22
			MenuSkill02 = "Major Skill #2: " + "Light Armor"
		ElseIf index == 23
			MenuSkill02 = "Major Skill #2: " + "Marksman"
		ElseIf index == 24
			MenuSkill02 = "Major Skill #2: " + "Mercantile"
		ElseIf index == 25
			MenuSkill02 = "Major Skill #2: " + "Security"
		ElseIf index == 26
			MenuSkill02 = "Major Skill #2: " + "Short Blade"
		ElseIf index == 27
			MenuSkill02 = "Major Skill #2: " + "Sneak"
		ElseIf index == 28
			MenuSkill02 = "Major Skill #2: " + "Speechcraft"
		EndIf
		
		FillOutForms()
	EndIf
EndFunction

Function SetSkill03(int iType = -1)
	if iType == -1
		string[] TypeList = new string[4]
		TypeList[0] = "Combat"
		TypeList[1] = "Magic"
		TypeList[2] = "Stealth"
		TypeList[3] = "Go Back"
		iType = 10*(((self as quest) as form) as UILIB_1).ShowList("Select Skill Type:", TypeList, 0, 0)
	endif
	int aiButton = -1
	If iType == 0
		string[] CombatList = new string[10]
		CombatList[0] = "Athletics"
		CombatList[1] = "Axe"
		CombatList[2] = "Block"
		CombatList[3] = "Blunt"
		CombatList[4] = "Heavy Armor"
		CombatList[5] = "Long Blade"
		CombatList[6] = "Medium Armor"
		CombatList[7] = "Polearm"
		CombatList[8] = "Smithing"
		CombatList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", CombatList, 0, 9)
		
	ElseIf iType == 10
		string[] MagicList = new string[10]
		MagicList[0] = "Alchemy"
		MagicList[1] = "Alteration"
		MagicList[2] = "Conjuration"
		MagicList[3] = "Destruction"
		MagicList[4] = "Enchanting"
		MagicList[5] = "Illusion"
		MagicList[6] = "Mysticism"
		MagicList[7] = "Restoration"
		MagicList[8] = "Unarmored"
		MagicList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", MagicList, 0, 9)
	
	ElseIf iType == 20
		string[] StealthList = new string[10]
		StealthList[0] = "Acrobatics"
		StealthList[1] = "Hand-to-Hand"
		StealthList[2] = "Light Armor"
		StealthList[3] = "Marksman"
		StealthList[4] = "Mercantile"
		StealthList[5] = "Security"
		StealthList[6] = "Short Blade"
		StealthList[7] = "Sneak"
		StealthList[8] = "Speechcraft"
		StealthList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", StealthList, 0, 9)
	
	EndIf
	
	int index = iType + aiButton
	If (aiButton > 8) || (aiButton < 0)
		FillOutForms()
		
	ElseIf !((iType == 00) || (iType == 10) || (iType == 20))
		FillOutForms()
	
	ElseIf (Skill01 == index) || (Skill02 == index) || (Skill04 == index) || (Skill05 == index) || (Skill06 == index) || (Skill07 == index) || (Skill08 == index)
		SelectFail.Play(PlayerRef)
		SetSkill01(iType)
	
	Else
		Skill03 = index
		If index == 00
			MenuSkill03 = "Major Skill #3: " + "Athletics"
		ElseIf index == 01
			MenuSkill03 = "Major Skill #3: " + "Axe"
		ElseIf index == 02
			MenuSkill03 = "Major Skill #3: " + "Block"
		ElseIf index == 03
			MenuSkill03 = "Major Skill #3: " + "Blunt"
		ElseIf index == 04
			MenuSkill03 = "Major Skill #3: " + "Heavy Armor"
		ElseIf index == 05
			MenuSkill03 = "Major Skill #3: " + "Long Blade"
		ElseIf index == 06
			MenuSkill03 = "Major Skill #3: " + "Medium Armor"
		ElseIf index == 07
			MenuSkill03 = "Major Skill #3: " + "Polearm"
		ElseIf index == 08
			MenuSkill03 = "Major Skill #3: " + "Smithing"
			
		ElseIf index == 10
			MenuSkill03 = "Major Skill #3: " + "Alchemy"
		ElseIf index == 11
			MenuSkill03 = "Major Skill #3: " + "Alteration"
		ElseIf index == 12
			MenuSkill03 = "Major Skill #3: " + "Conjuration"
		ElseIf index == 13
			MenuSkill03 = "Major Skill #3: " + "Destruction"
		ElseIf index == 14
			MenuSkill03 = "Major Skill #3: " + "Enchanting"
		ElseIf index == 15
			MenuSkill03 = "Major Skill #3: " + "Illusion"
		ElseIf index == 16
			MenuSkill03 = "Major Skill #3: " + "Mysticism"
		ElseIf index == 17
			MenuSkill03 = "Major Skill #3: " + "Restoration"
		ElseIf index == 18
			MenuSkill03 = "Major Skill #3: " + "Unarmored"
			
		ElseIf index == 20
			MenuSkill03 = "Major Skill #3: " + "Acrobatics"
		ElseIf index == 21
			MenuSkill03 = "Major Skill #3: " + "Hand-to-Hand"
		ElseIf index == 22
			MenuSkill03 = "Major Skill #3: " + "Light Armor"
		ElseIf index == 23
			MenuSkill03 = "Major Skill #3: " + "Marksman"
		ElseIf index == 24
			MenuSkill03 = "Major Skill #3: " + "Mercantile"
		ElseIf index == 25
			MenuSkill03 = "Major Skill #3: " + "Security"
		ElseIf index == 26
			MenuSkill03 = "Major Skill #3: " + "Short Blade"
		ElseIf index == 27
			MenuSkill03 = "Major Skill #3: " + "Sneak"
		ElseIf index == 28
			MenuSkill03 = "Major Skill #3: " + "Speechcraft"
		EndIf
		
		FillOutForms()
	EndIf
EndFunction



Function SetSkill04(int iType = -1)
	if iType == -1
		string[] TypeList = new string[4]
		TypeList[0] = "Combat"
		TypeList[1] = "Magic"
		TypeList[2] = "Stealth"
		TypeList[3] = "Go Back"
		iType = 10*(((self as quest) as form) as UILIB_1).ShowList("Select Skill Type:", TypeList, 0, 0)
	endif
	int aiButton = -1
	If iType == 0
		string[] CombatList = new string[10]
		CombatList[0] = "Athletics"
		CombatList[1] = "Axe"
		CombatList[2] = "Block"
		CombatList[3] = "Blunt"
		CombatList[4] = "Heavy Armor"
		CombatList[5] = "Long Blade"
		CombatList[6] = "Medium Armor"
		CombatList[7] = "Polearm"
		CombatList[8] = "Smithing"
		CombatList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", CombatList, 0, 9)
		
	ElseIf iType == 10
		string[] MagicList = new string[10]
		MagicList[0] = "Alchemy"
		MagicList[1] = "Alteration"
		MagicList[2] = "Conjuration"
		MagicList[3] = "Destruction"
		MagicList[4] = "Enchanting"
		MagicList[5] = "Illusion"
		MagicList[6] = "Mysticism"
		MagicList[7] = "Restoration"
		MagicList[8] = "Unarmored"
		MagicList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", MagicList, 0, 9)
	
	ElseIf iType == 20
		string[] StealthList = new string[10]
		StealthList[0] = "Acrobatics"
		StealthList[1] = "Hand-to-Hand"
		StealthList[2] = "Light Armor"
		StealthList[3] = "Marksman"
		StealthList[4] = "Mercantile"
		StealthList[5] = "Security"
		StealthList[6] = "Short Blade"
		StealthList[7] = "Sneak"
		StealthList[8] = "Speechcraft"
		StealthList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", StealthList, 0, 9)
	
	EndIf
	
	int index = iType + aiButton
	If (aiButton > 8) || (aiButton < 0)
		FillOutForms()
		
	ElseIf !((iType == 00) || (iType == 10) || (iType == 20))
		FillOutForms()
	
	ElseIf (Skill01 == index) || (Skill02 == index) || (Skill03 == index) || (Skill05 == index) || (Skill06 == index) || (Skill07 == index) || (Skill08 == index)
		SelectFail.Play(PlayerRef)
		SetSkill01(iType)
	
	Else
		Skill04 = index
		If index == 00
			MenuSkill04 = "Major Skill #4: " + "Athletics"
		ElseIf index == 01
			MenuSkill04 = "Major Skill #4: " + "Axe"
		ElseIf index == 02
			MenuSkill04 = "Major Skill #4: " + "Block"
		ElseIf index == 03
			MenuSkill04 = "Major Skill #4: " + "Blunt"
		ElseIf index == 04
			MenuSkill04 = "Major Skill #4: " + "Heavy Armor"
		ElseIf index == 05
			MenuSkill04 = "Major Skill #4: " + "Long Blade"
		ElseIf index == 06
			MenuSkill04 = "Major Skill #4: " + "Medium Armor"
		ElseIf index == 07
			MenuSkill04 = "Major Skill #4: " + "Polearm"
		ElseIf index == 08
			MenuSkill04 = "Major Skill #4: " + "Smithing"
			
		ElseIf index == 10
			MenuSkill04 = "Major Skill #4: " + "Alchemy"
		ElseIf index == 11
			MenuSkill04 = "Major Skill #4: " + "Alteration"
		ElseIf index == 12
			MenuSkill04 = "Major Skill #4: " + "Conjuration"
		ElseIf index == 13
			MenuSkill04 = "Major Skill #4: " + "Destruction"
		ElseIf index == 14
			MenuSkill04 = "Major Skill #4: " + "Enchanting"
		ElseIf index == 15
			MenuSkill04 = "Major Skill #4: " + "Illusion"
		ElseIf index == 16
			MenuSkill04 = "Major Skill #4: " + "Mysticism"
		ElseIf index == 17
			MenuSkill04 = "Major Skill #4: " + "Restoration"
		ElseIf index == 18
			MenuSkill04 = "Major Skill #4: " + "Unarmored"
			
		ElseIf index == 20
			MenuSkill04 = "Major Skill #4: " + "Acrobatics"
		ElseIf index == 21
			MenuSkill04 = "Major Skill #4: " + "Hand-to-Hand"
		ElseIf index == 22
			MenuSkill04 = "Major Skill #4: " + "Light Armor"
		ElseIf index == 23
			MenuSkill04 = "Major Skill #4: " + "Marksman"
		ElseIf index == 24
			MenuSkill04 = "Major Skill #4: " + "Mercantile"
		ElseIf index == 25
			MenuSkill04 = "Major Skill #4: " + "Security"
		ElseIf index == 26
			MenuSkill04 = "Major Skill #4: " + "Short Blade"
		ElseIf index == 27
			MenuSkill04 = "Major Skill #4: " + "Sneak"
		ElseIf index == 28
			MenuSkill04 = "Major Skill #4: " + "Speechcraft"
		EndIf
		
		FillOutForms()
	EndIf
EndFunction

Function SetSkill05(int iType = -1)
	if iType == -1
		string[] TypeList = new string[4]
		TypeList[0] = "Combat"
		TypeList[1] = "Magic"
		TypeList[2] = "Stealth"
		TypeList[3] = "Go Back"
		iType = 10*(((self as quest) as form) as UILIB_1).ShowList("Select Skill Type:", TypeList, 0, 0)
	endif
	int aiButton = -1
	If iType == 0
		string[] CombatList = new string[10]
		CombatList[0] = "Athletics"
		CombatList[1] = "Axe"
		CombatList[2] = "Block"
		CombatList[3] = "Blunt"
		CombatList[4] = "Heavy Armor"
		CombatList[5] = "Long Blade"
		CombatList[6] = "Medium Armor"
		CombatList[7] = "Polearm"
		CombatList[8] = "Smithing"
		CombatList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", CombatList, 0, 9)
		
	ElseIf iType == 10
		string[] MagicList = new string[10]
		MagicList[0] = "Alchemy"
		MagicList[1] = "Alteration"
		MagicList[2] = "Conjuration"
		MagicList[3] = "Destruction"
		MagicList[4] = "Enchanting"
		MagicList[5] = "Illusion"
		MagicList[6] = "Mysticism"
		MagicList[7] = "Restoration"
		MagicList[8] = "Unarmored"
		MagicList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", MagicList, 0, 9)
	
	ElseIf iType == 20
		string[] StealthList = new string[10]
		StealthList[0] = "Acrobatics"
		StealthList[1] = "Hand-to-Hand"
		StealthList[2] = "Light Armor"
		StealthList[3] = "Marksman"
		StealthList[4] = "Mercantile"
		StealthList[5] = "Security"
		StealthList[6] = "Short Blade"
		StealthList[7] = "Sneak"
		StealthList[8] = "Speechcraft"
		StealthList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", StealthList, 0, 9)
	
	EndIf
	
	int index = iType + aiButton
	If (aiButton > 8) || (aiButton < 0)
		FillOutForms()
		
	ElseIf !((iType == 00) || (iType == 10) || (iType == 20))
		FillOutForms()
	
	ElseIf (Skill01 == index) || (Skill02 == index) || (Skill03 == index) || (Skill04 == index) || (Skill06 == index) || (Skill07 == index) || (Skill08 == index)
		SelectFail.Play(PlayerRef)
		SetSkill01(iType)
	
	Else
		Skill05 = index
		If index == 00
			MenuSkill05 = "Major Skill #5: " + "Athletics"
		ElseIf index == 01
			MenuSkill05 = "Major Skill #5: " + "Axe"
		ElseIf index == 02
			MenuSkill05 = "Major Skill #5: " + "Block"
		ElseIf index == 03
			MenuSkill05 = "Major Skill #5: " + "Blunt"
		ElseIf index == 04
			MenuSkill05 = "Major Skill #5: " + "Heavy Armor"
		ElseIf index == 05
			MenuSkill05 = "Major Skill #5: " + "Long Blade"
		ElseIf index == 06
			MenuSkill05 = "Major Skill #5: " + "Medium Armor"
		ElseIf index == 07
			MenuSkill05 = "Major Skill #5: " + "Polearm"
		ElseIf index == 08
			MenuSkill05 = "Major Skill #5: " + "Smithing"
			
		ElseIf index == 10
			MenuSkill05 = "Major Skill #5: " + "Alchemy"
		ElseIf index == 11
			MenuSkill05 = "Major Skill #5: " + "Alteration"
		ElseIf index == 12
			MenuSkill05 = "Major Skill #5: " + "Conjuration"
		ElseIf index == 13
			MenuSkill05 = "Major Skill #5: " + "Destruction"
		ElseIf index == 14
			MenuSkill05 = "Major Skill #5: " + "Enchanting"
		ElseIf index == 15
			MenuSkill05 = "Major Skill #5: " + "Illusion"
		ElseIf index == 16
			MenuSkill05 = "Major Skill #5: " + "Mysticism"
		ElseIf index == 17
			MenuSkill05 = "Major Skill #5: " + "Restoration"
		ElseIf index == 18
			MenuSkill05 = "Major Skill #5: " + "Unarmored"
			
		ElseIf index == 20
			MenuSkill05 = "Major Skill #5: " + "Acrobatics"
		ElseIf index == 21
			MenuSkill05 = "Major Skill #5: " + "Hand-to-Hand"
		ElseIf index == 22
			MenuSkill05 = "Major Skill #5: " + "Light Armor"
		ElseIf index == 23
			MenuSkill05 = "Major Skill #5: " + "Marksman"
		ElseIf index == 24
			MenuSkill05 = "Major Skill #5: " + "Mercantile"
		ElseIf index == 25
			MenuSkill05 = "Major Skill #5: " + "Security"
		ElseIf index == 26
			MenuSkill05 = "Major Skill #5: " + "Short Blade"
		ElseIf index == 27
			MenuSkill05 = "Major Skill #5: " + "Sneak"
		ElseIf index == 28
			MenuSkill05 = "Major Skill #5: " + "Speechcraft"
		EndIf
		
		FillOutForms()
	EndIf
EndFunction

Function SetSkill06(int iType = -1)
	if iType == -1
		string[] TypeList = new string[4]
		TypeList[0] = "Combat"
		TypeList[1] = "Magic"
		TypeList[2] = "Stealth"
		TypeList[3] = "Go Back"
		iType = 10*(((self as quest) as form) as UILIB_1).ShowList("Select Skill Type:", TypeList, 0, 0)
	endif
	int aiButton = -1
	If iType == 0
		string[] CombatList = new string[10]
		CombatList[0] = "Athletics"
		CombatList[1] = "Axe"
		CombatList[2] = "Block"
		CombatList[3] = "Blunt"
		CombatList[4] = "Heavy Armor"
		CombatList[5] = "Long Blade"
		CombatList[6] = "Medium Armor"
		CombatList[7] = "Polearm"
		CombatList[8] = "Smithing"
		CombatList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", CombatList, 0, 9)
		
	ElseIf iType == 10
		string[] MagicList = new string[10]
		MagicList[0] = "Alchemy"
		MagicList[1] = "Alteration"
		MagicList[2] = "Conjuration"
		MagicList[3] = "Destruction"
		MagicList[4] = "Enchanting"
		MagicList[5] = "Illusion"
		MagicList[6] = "Mysticism"
		MagicList[7] = "Restoration"
		MagicList[8] = "Unarmored"
		MagicList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", MagicList, 0, 9)
	
	ElseIf iType == 20
		string[] StealthList = new string[10]
		StealthList[0] = "Acrobatics"
		StealthList[1] = "Hand-to-Hand"
		StealthList[2] = "Light Armor"
		StealthList[3] = "Marksman"
		StealthList[4] = "Mercantile"
		StealthList[5] = "Security"
		StealthList[6] = "Short Blade"
		StealthList[7] = "Sneak"
		StealthList[8] = "Speechcraft"
		StealthList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", StealthList, 0, 9)
	
	EndIf
	
	int index = iType + aiButton
	If (aiButton > 8) || (aiButton < 0)
		FillOutForms()
		
	ElseIf !((iType == 00) || (iType == 10) || (iType == 20))
		FillOutForms()
	
	ElseIf (Skill01 == index) || (Skill02 == index) || (Skill03 == index) || (Skill04 == index) || (Skill05 == index) || (Skill07 == index) || (Skill08 == index)
		SelectFail.Play(PlayerRef)
		SetSkill01(iType)
	
	Else
		Skill06 = index
		If index == 00
			MenuSkill06 = "Major Skill #6: " + "Athletics"
		ElseIf index == 01
			MenuSkill06 = "Major Skill #6: " + "Axe"
		ElseIf index == 02
			MenuSkill06 = "Major Skill #6: " + "Block"
		ElseIf index == 03
			MenuSkill06 = "Major Skill #6: " + "Blunt"
		ElseIf index == 04
			MenuSkill06 = "Major Skill #6: " + "Heavy Armor"
		ElseIf index == 05
			MenuSkill06 = "Major Skill #6: " + "Long Blade"
		ElseIf index == 06
			MenuSkill06 = "Major Skill #6: " + "Medium Armor"
		ElseIf index == 07
			MenuSkill06 = "Major Skill #6: " + "Polearm"
		ElseIf index == 08
			MenuSkill06 = "Major Skill #6: " + "Smithing"
			
		ElseIf index == 10
			MenuSkill06 = "Major Skill #6: " + "Alchemy"
		ElseIf index == 11
			MenuSkill06 = "Major Skill #6: " + "Alteration"
		ElseIf index == 12
			MenuSkill06 = "Major Skill #6: " + "Conjuration"
		ElseIf index == 13
			MenuSkill06 = "Major Skill #6: " + "Destruction"
		ElseIf index == 14
			MenuSkill06 = "Major Skill #6: " + "Enchanting"
		ElseIf index == 15
			MenuSkill06 = "Major Skill #6: " + "Illusion"
		ElseIf index == 16
			MenuSkill06 = "Major Skill #6: " + "Mysticism"
		ElseIf index == 17
			MenuSkill06 = "Major Skill #6: " + "Restoration"
		ElseIf index == 18
			MenuSkill06 = "Major Skill #6: " + "Unarmored"
			
		ElseIf index == 20
			MenuSkill06 = "Major Skill #6: " + "Acrobatics"
		ElseIf index == 21
			MenuSkill06 = "Major Skill #6: " + "Hand-to-Hand"
		ElseIf index == 22
			MenuSkill06 = "Major Skill #6: " + "Light Armor"
		ElseIf index == 23
			MenuSkill06 = "Major Skill #6: " + "Marksman"
		ElseIf index == 24
			MenuSkill06 = "Major Skill #6: " + "Mercantile"
		ElseIf index == 25
			MenuSkill06 = "Major Skill #6: " + "Security"
		ElseIf index == 26
			MenuSkill06 = "Major Skill #6: " + "Short Blade"
		ElseIf index == 27
			MenuSkill06 = "Major Skill #6: " + "Sneak"
		ElseIf index == 28
			MenuSkill06 = "Major Skill #6: " + "Speechcraft"
		EndIf
		
		FillOutForms()
	EndIf
EndFunction

Function SetSkill07(int iType = -1)
	if iType == -1
		string[] TypeList = new string[4]
		TypeList[0] = "Combat"
		TypeList[1] = "Magic"
		TypeList[2] = "Stealth"
		TypeList[3] = "Go Back"
		iType = 10*(((self as quest) as form) as UILIB_1).ShowList("Select Skill Type:", TypeList, 0, 0)
	endif
	int aiButton = -1
	If iType == 0
		string[] CombatList = new string[10]
		CombatList[0] = "Athletics"
		CombatList[1] = "Axe"
		CombatList[2] = "Block"
		CombatList[3] = "Blunt"
		CombatList[4] = "Heavy Armor"
		CombatList[5] = "Long Blade"
		CombatList[6] = "Medium Armor"
		CombatList[7] = "Polearm"
		CombatList[8] = "Smithing"
		CombatList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", CombatList, 0, 9)
		
	ElseIf iType == 10
		string[] MagicList = new string[10]
		MagicList[0] = "Alchemy"
		MagicList[1] = "Alteration"
		MagicList[2] = "Conjuration"
		MagicList[3] = "Destruction"
		MagicList[4] = "Enchanting"
		MagicList[5] = "Illusion"
		MagicList[6] = "Mysticism"
		MagicList[7] = "Restoration"
		MagicList[8] = "Unarmored"
		MagicList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", MagicList, 0, 9)
	
	ElseIf iType == 20
		string[] StealthList = new string[10]
		StealthList[0] = "Acrobatics"
		StealthList[1] = "Hand-to-Hand"
		StealthList[2] = "Light Armor"
		StealthList[3] = "Marksman"
		StealthList[4] = "Mercantile"
		StealthList[5] = "Security"
		StealthList[6] = "Short Blade"
		StealthList[7] = "Sneak"
		StealthList[8] = "Speechcraft"
		StealthList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", StealthList, 0, 9)
	
	EndIf
	
	int index = iType + aiButton
	If (aiButton > 8) || (aiButton < 0)
		FillOutForms()
		
	ElseIf !((iType == 00) || (iType == 10) || (iType == 20))
		FillOutForms()
	
	ElseIf (Skill01 == index) || (Skill02 == index) || (Skill03 == index) || (Skill04 == index) || (Skill05 == index) || (Skill06 == index) || (Skill08 == index)
		SelectFail.Play(PlayerRef)
		SetSkill01(iType)
	
	Else
		Skill07 = index
		If index == 00
			MenuSkill07 = "Major Skill #7: " + "Athletics"
		ElseIf index == 01
			MenuSkill07 = "Major Skill #7: " + "Axe"
		ElseIf index == 02
			MenuSkill07 = "Major Skill #7: " + "Block"
		ElseIf index == 03
			MenuSkill07 = "Major Skill #7: " + "Blunt"
		ElseIf index == 04
			MenuSkill07 = "Major Skill #7: " + "Heavy Armor"
		ElseIf index == 05
			MenuSkill07 = "Major Skill #7: " + "Long Blade"
		ElseIf index == 06
			MenuSkill07 = "Major Skill #7: " + "Medium Armor"
		ElseIf index == 07
			MenuSkill07 = "Major Skill #7: " + "Polearm"
		ElseIf index == 08
			MenuSkill07 = "Major Skill #7: " + "Smithing"
			
		ElseIf index == 10
			MenuSkill07 = "Major Skill #7: " + "Alchemy"
		ElseIf index == 11
			MenuSkill07 = "Major Skill #7: " + "Alteration"
		ElseIf index == 12
			MenuSkill07 = "Major Skill #7: " + "Conjuration"
		ElseIf index == 13
			MenuSkill07 = "Major Skill #7: " + "Destruction"
		ElseIf index == 14
			MenuSkill07 = "Major Skill #7: " + "Enchanting"
		ElseIf index == 15
			MenuSkill07 = "Major Skill #7: " + "Illusion"
		ElseIf index == 16
			MenuSkill07 = "Major Skill #7: " + "Mysticism"
		ElseIf index == 17
			MenuSkill07 = "Major Skill #7: " + "Restoration"
		ElseIf index == 18
			MenuSkill07 = "Major Skill #7: " + "Unarmored"
			
		ElseIf index == 20
			MenuSkill07 = "Major Skill #7: " + "Acrobatics"
		ElseIf index == 21
			MenuSkill07 = "Major Skill #7: " + "Hand-to-Hand"
		ElseIf index == 22
			MenuSkill07 = "Major Skill #7: " + "Light Armor"
		ElseIf index == 23
			MenuSkill07 = "Major Skill #7: " + "Marksman"
		ElseIf index == 24
			MenuSkill07 = "Major Skill #7: " + "Mercantile"
		ElseIf index == 25
			MenuSkill07 = "Major Skill #7: " + "Security"
		ElseIf index == 26
			MenuSkill07 = "Major Skill #7: " + "Short Blade"
		ElseIf index == 27
			MenuSkill07 = "Major Skill #7: " + "Sneak"
		ElseIf index == 28
			MenuSkill07 = "Major Skill #7: " + "Speechcraft"
		EndIf
		
		FillOutForms()
	EndIf
EndFunction

Function SetSkill08(int iType = -1)
	if iType == -1
		string[] TypeList = new string[4]
		TypeList[0] = "Combat"
		TypeList[1] = "Magic"
		TypeList[2] = "Stealth"
		TypeList[3] = "Go Back"
		iType = 10*(((self as quest) as form) as UILIB_1).ShowList("Select Skill Type:", TypeList, 0, 0)
	endif
	int aiButton = -1
	If iType == 0
		string[] CombatList = new string[10]
		CombatList[0] = "Athletics"
		CombatList[1] = "Axe"
		CombatList[2] = "Block"
		CombatList[3] = "Blunt"
		CombatList[4] = "Heavy Armor"
		CombatList[5] = "Long Blade"
		CombatList[6] = "Medium Armor"
		CombatList[7] = "Polearm"
		CombatList[8] = "Smithing"
		CombatList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", CombatList, 0, 9)
		
	ElseIf iType == 10
		string[] MagicList = new string[10]
		MagicList[0] = "Alchemy"
		MagicList[1] = "Alteration"
		MagicList[2] = "Conjuration"
		MagicList[3] = "Destruction"
		MagicList[4] = "Enchanting"
		MagicList[5] = "Illusion"
		MagicList[6] = "Mysticism"
		MagicList[7] = "Restoration"
		MagicList[8] = "Unarmored"
		MagicList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", MagicList, 0, 9)
	
	ElseIf iType == 20
		string[] StealthList = new string[10]
		StealthList[0] = "Acrobatics"
		StealthList[1] = "Hand-to-Hand"
		StealthList[2] = "Light Armor"
		StealthList[3] = "Marksman"
		StealthList[4] = "Mercantile"
		StealthList[5] = "Security"
		StealthList[6] = "Short Blade"
		StealthList[7] = "Sneak"
		StealthList[8] = "Speechcraft"
		StealthList[9] = "Go Back"
		aiButton = (((self as quest) as form) as UILIB_1).ShowList("Select Skill:", StealthList, 0, 9)
	
	EndIf
	
	int index = iType + aiButton
	If (aiButton > 8) || (aiButton < 0)
		FillOutForms()
		
	ElseIf !((iType == 00) || (iType == 10) || (iType == 20))
		FillOutForms()
	
	ElseIf (Skill01 == index) || (Skill02 == index) || (Skill03 == index) || (Skill04 == index) || (Skill05 == index) || (Skill06 == index) || (Skill07 == index)
		SelectFail.Play(PlayerRef)
		SetSkill01(iType)
	
	Else
		Skill08 = index
		If index == 00
			MenuSkill08 = "Major Skill #8: " + "Athletics"
		ElseIf index == 01
			MenuSkill08 = "Major Skill #8: " + "Axe"
		ElseIf index == 02
			MenuSkill08 = "Major Skill #8: " + "Block"
		ElseIf index == 03
			MenuSkill08 = "Major Skill #8: " + "Blunt"
		ElseIf index == 04
			MenuSkill08 = "Major Skill #8: " + "Heavy Armor"
		ElseIf index == 05
			MenuSkill08 = "Major Skill #8: " + "Long Blade"
		ElseIf index == 06
			MenuSkill08 = "Major Skill #8: " + "Medium Armor"
		ElseIf index == 07
			MenuSkill08 = "Major Skill #8: " + "Polearm"
		ElseIf index == 08
			MenuSkill08 = "Major Skill #8: " + "Smithing"
			
		ElseIf index == 10
			MenuSkill08 = "Major Skill #8: " + "Alchemy"
		ElseIf index == 11
			MenuSkill08 = "Major Skill #8: " + "Alteration"
		ElseIf index == 12
			MenuSkill08 = "Major Skill #8: " + "Conjuration"
		ElseIf index == 13
			MenuSkill08 = "Major Skill #8: " + "Destruction"
		ElseIf index == 14
			MenuSkill08 = "Major Skill #8: " + "Enchanting"
		ElseIf index == 15
			MenuSkill08 = "Major Skill #8: " + "Illusion"
		ElseIf index == 16
			MenuSkill08 = "Major Skill #8: " + "Mysticism"
		ElseIf index == 17
			MenuSkill08 = "Major Skill #8: " + "Restoration"
		ElseIf index == 18
			MenuSkill08 = "Major Skill #8: " + "Unarmored"
			
		ElseIf index == 20
			MenuSkill08 = "Major Skill #8: " + "Acrobatics"
		ElseIf index == 21
			MenuSkill08 = "Major Skill #8: " + "Hand-to-Hand"
		ElseIf index == 22
			MenuSkill08 = "Major Skill #8: " + "Light Armor"
		ElseIf index == 23
			MenuSkill08 = "Major Skill #8: " + "Marksman"
		ElseIf index == 24
			MenuSkill08 = "Major Skill #8: " + "Mercantile"
		ElseIf index == 25
			MenuSkill08 = "Major Skill #8: " + "Security"
		ElseIf index == 26
			MenuSkill08 = "Major Skill #8: " + "Short Blade"
		ElseIf index == 27
			MenuSkill08 = "Major Skill #8: " + "Sneak"
		ElseIf index == 28
			MenuSkill08 = "Major Skill #8: " + "Speechcraft"
		EndIf
		
		FillOutForms()
	EndIf
EndFunction

string Function SkillStringByIndex(int index)
	string SkillString
	If index == 00
		SkillString =  "Athletics"
	ElseIf index == 01
		SkillString =  "Axe"
	ElseIf index == 02
		SkillString =  "Block"
	ElseIf index == 03
		SkillString =  "Blunt"
	ElseIf index == 04
		SkillString =  "Heavy Armor"
	ElseIf index == 05
		SkillString =  "Long Blade"
	ElseIf index == 06
		SkillString =  "Medium Armor"
	ElseIf index == 07
		SkillString =  "Polearm"
	ElseIf index == 08
		SkillString =  "Smithing"
		
	ElseIf index == 10
		SkillString =  "Alchemy"
	ElseIf index == 11
		SkillString =  "Alteration"
	ElseIf index == 12
		SkillString =  "Conjuration"
	ElseIf index == 13
		SkillString =  "Destruction"
	ElseIf index == 14
		SkillString =  "Enchanting"
	ElseIf index == 15
		SkillString =  "Illusion"
	ElseIf index == 16
		SkillString =  "Mysticism"
	ElseIf index == 17
		SkillString =  "Restoration"
	ElseIf index == 18
		SkillString =  "Unarmored"

	ElseIf index == 20
		SkillString =  "Acrobatics"	
	ElseIf index == 21
		SkillString =  "Hand-to-Hand"
	ElseIf index == 22
		SkillString =  "Light Armor"
	ElseIf index == 23
		SkillString =  "Marksman"
	ElseIf index == 24
		SkillString =  "Mercantile"
	ElseIf index == 25
		SkillString =  "Security"
	ElseIf index == 26
		SkillString =  "Short Blade"
	ElseIf index == 27
		SkillString =  "Sneak"
	ElseIf index == 28
		SkillString =  "Speechcraft"	
	EndIf
	
	return SkillString
	
endFunction

string Function AttributeStringByIndex(int index)
	string AttributeString
	If index == 0
		AttributeString =  "Strength"
	ElseIf index == 1
		AttributeString =  "Intelligence"
	ElseIf index == 2
		AttributeString =  "Willpower"
	ElseIf index == 3
		AttributeString =  "Agility"
	ElseIf index == 4
		AttributeString =  "Speed"
	ElseIf index == 5
		AttributeString =  "Endurance"
	ElseIf index == 6
		AttributeString =  "Personality"
	ElseIf index == 7
		AttributeString =  "Luck"
	EndIf
	return AttributeString
endFunction 

;========== finalize ==========
Function FinalizeCustomClass()
	; clean up any previous chargen
	BaseScript.SkillsScript.ResetClass()

	; specialization
	BaseScript.SkillsScript.fbmwClassSpecialization.SetValue(Specialization)
	
	; attributes
	if (Attribute01 == 0) || (Attribute01 == 0)
		BaseScript.SkillsScript.StrengthFavored = true
	endif
	if (Attribute01 == 1) || (Attribute01 == 1)
		BaseScript.SkillsScript.IntelligenceFavored = true
	endif
	if (Attribute01 == 2) || (Attribute01 == 2)
		BaseScript.SkillsScript.WillpowerFavored = true
	endif
	if (Attribute01 == 3) || (Attribute01 == 3)
		BaseScript.SkillsScript.AgilityFavored = true
	endif
	if (Attribute01 == 4) || (Attribute01 == 4)
		BaseScript.SkillsScript.SpeedFavored = true
	endif
	if (Attribute01 == 5) || (Attribute01 == 5)
		BaseScript.SkillsScript.EnduranceFavored = true
	endif
	if (Attribute01 == 6) || (Attribute01 == 6)
		BaseScript.SkillsScript.PersonalityFavored = true
	endif
	if (Attribute01 == 7) || (Attribute01 == 7)
		BaseScript.SkillsScript.LuckFavored = true
	endif
	
	; skills
	;===============combat=================
	if (Skill01 == 00) || (Skill02 == 00) || (Skill03 == 00) || (Skill04 == 00) || (Skill05 == 00) || (Skill06 == 00) || (Skill07 == 00) || (Skill08 == 00)
		BaseScript.SkillsScript.fbmwClassAthleticsScore.SetValue(1)
	endif
	if (Skill01 == 01) || (Skill02 == 01) || (Skill03 == 01) || (Skill04 == 01) || (Skill05 == 01) || (Skill06 == 01) || (Skill07 == 01) || (Skill08 == 01)
		BaseScript.SkillsScript.fbmwClassAxeScore.SetValue(1)
	endif
	if (Skill01 == 02) || (Skill02 == 02) || (Skill03 == 02) || (Skill04 == 02) || (Skill05 == 02) || (Skill06 == 02) || (Skill07 == 02) || (Skill08 == 02)
		BaseScript.SkillsScript.fbmwClassBlockScore.SetValue(1)
	endif
	if (Skill01 == 03) || (Skill02 == 03) || (Skill03 == 03) || (Skill04 == 03) || (Skill05 == 03) || (Skill06 == 03) || (Skill07 == 03) || (Skill08 == 03)
		BaseScript.SkillsScript.fbmwClassBluntScore.SetValue(1)
	endif
	if (Skill01 == 04) || (Skill02 == 04) || (Skill03 == 04) || (Skill04 == 04) || (Skill05 == 04) || (Skill06 == 04) || (Skill07 == 04) || (Skill08 == 04)
		BaseScript.SkillsScript.fbmwClassHeavyArmorScore.SetValue(1)
	endif
	if (Skill01 == 05) || (Skill02 == 05) || (Skill03 == 05) || (Skill04 == 05) || (Skill05 == 05) || (Skill06 == 05) || (Skill07 == 05) || (Skill08 == 05)
		BaseScript.SkillsScript.fbmwClassLongBladeScore.SetValue(1)
	endif
	if (Skill01 == 06) || (Skill02 == 06) || (Skill03 == 06) || (Skill04 == 06) || (Skill05 == 06) || (Skill06 == 06) || (Skill07 == 06) || (Skill08 == 06)
		BaseScript.SkillsScript.fbmwClassMediumArmorScore.SetValue(1)
	endif
	if (Skill01 == 07) || (Skill02 == 07) || (Skill03 == 07) || (Skill04 == 07) || (Skill05 == 07) || (Skill06 == 07) || (Skill07 == 07) || (Skill08 == 07)
		BaseScript.SkillsScript.fbmwClassPolearmsScore.SetValue(1)
	endif
	if (Skill01 == 08) || (Skill02 == 08) || (Skill03 == 08) || (Skill04 == 08) || (Skill05 == 08) || (Skill06 == 08) || (Skill07 == 08) || (Skill08 == 08)
		BaseScript.SkillsScript.fbmwClassSmithingScore.SetValue(1)
	endif
	;===============magic=================
	if (Skill01 == 10) || (Skill02 == 10) || (Skill03 == 10) || (Skill04 == 10) || (Skill05 == 10) || (Skill06 == 10) || (Skill07 == 10) || (Skill08 == 10)
		BaseScript.SkillsScript.fbmwClassAlchemyScore.SetValue(1)
	endif
	if (Skill01 == 11) || (Skill02 == 11) || (Skill03 == 11) || (Skill04 == 11) || (Skill05 == 11) || (Skill06 == 11) || (Skill07 == 11) || (Skill08 == 11)
		BaseScript.SkillsScript.fbmwClassAlterationScore.SetValue(1)
	endif
	if (Skill01 == 12) || (Skill02 == 12) || (Skill03 == 12) || (Skill04 == 12) || (Skill05 == 12) || (Skill06 == 12) || (Skill07 == 12) || (Skill08 == 12)
		BaseScript.SkillsScript.fbmwClassConjurationScore.SetValue(1)
	endif
	if (Skill01 == 13) || (Skill02 == 13) || (Skill03 == 13) || (Skill04 == 13) || (Skill05 == 13) || (Skill06 == 13) || (Skill07 == 13) || (Skill08 == 13)
		BaseScript.SkillsScript.fbmwClassDestructionScore.SetValue(1)
	endif
	if (Skill01 == 14) || (Skill02 == 14) || (Skill03 == 14) || (Skill04 == 14) || (Skill05 == 14) || (Skill06 == 14) || (Skill07 == 14) || (Skill08 == 14)
		BaseScript.SkillsScript.fbmwClassEnchantingScore.SetValue(1)
	endif
	if (Skill01 == 15) || (Skill02 == 15) || (Skill03 == 15) || (Skill04 == 15) || (Skill05 == 15) || (Skill06 == 15) || (Skill07 == 15) || (Skill08 == 15)
		BaseScript.SkillsScript.fbmwClassIllusionScore.SetValue(1)
	endif
	if (Skill01 == 16) || (Skill02 == 16) || (Skill03 == 16) || (Skill04 == 16) || (Skill05 == 16) || (Skill06 == 16) || (Skill07 == 16) || (Skill08 == 16)
		BaseScript.SkillsScript.fbmwClassMysticismScore.SetValue(1)
	endif
	if (Skill01 == 17) || (Skill02 == 17) || (Skill03 == 17) || (Skill04 == 17) || (Skill05 == 17) || (Skill06 == 17) || (Skill07 == 17) || (Skill08 == 17)
		BaseScript.SkillsScript.fbmwClassRestorationScore.SetValue(1)
	endif
	if (Skill01 == 18) || (Skill02 == 18) || (Skill03 == 18) || (Skill04 == 18) || (Skill05 == 18) || (Skill06 == 18) || (Skill07 == 18) || (Skill08 == 18)
		BaseScript.SkillsScript.fbmwClassUnarmoredScore.SetValue(1)
	endif
	;===============stealth=================
	if (Skill01 == 20) || (Skill02 == 20) || (Skill03 == 20) || (Skill04 == 20) || (Skill05 == 20) || (Skill06 == 20) || (Skill07 == 20) || (Skill08 == 20)
		BaseScript.SkillsScript.fbmwClassAcrobaticsScore.SetValue(1)
	endif
	if (Skill01 == 21) || (Skill02 == 21) || (Skill03 == 21) || (Skill04 == 21) || (Skill05 == 21) || (Skill06 == 21) || (Skill07 == 21) || (Skill08 == 21)
		BaseScript.SkillsScript.fbmwClassHandToHandScore.SetValue(1)
	endif
	if (Skill01 == 22) || (Skill02 == 22) || (Skill03 == 22) || (Skill04 == 22) || (Skill05 == 22) || (Skill06 == 22) || (Skill07 == 22) || (Skill08 == 22)
		BaseScript.SkillsScript.fbmwClassLightArmorScore.SetValue(1)
	endif
	if (Skill01 == 23) || (Skill02 == 23) || (Skill03 == 23) || (Skill04 == 23) || (Skill05 == 23) || (Skill06 == 23) || (Skill07 == 23) || (Skill08 == 23)
		BaseScript.SkillsScript.fbmwClassMarksmanScore.SetValue(1)
	endif
	if (Skill01 == 24) || (Skill02 == 24) || (Skill03 == 24) || (Skill04 == 24) || (Skill05 == 24) || (Skill06 == 24) || (Skill07 == 24) || (Skill08 == 24)
		BaseScript.SkillsScript.fbmwClassMercantileScore.SetValue(1)
	endif
	if (Skill01 == 25) || (Skill02 == 25) || (Skill03 == 25) || (Skill04 == 25) || (Skill05 == 25) || (Skill06 == 25) || (Skill07 == 25) || (Skill08 == 25)
		BaseScript.SkillsScript.fbmwClassSecurityScore.SetValue(1)
	endif
	if (Skill01 == 26) || (Skill02 == 26) || (Skill03 == 26) || (Skill04 == 26) || (Skill05 == 26) || (Skill06 == 26) || (Skill07 == 26) || (Skill08 == 26)
		BaseScript.SkillsScript.fbmwClassShortBladesScore.SetValue(1)
	endif
	if (Skill01 == 27) || (Skill02 == 27) || (Skill03 == 27) || (Skill04 == 27) || (Skill05 == 27) || (Skill06 == 27) || (Skill07 == 27) || (Skill08 == 27)
		BaseScript.SkillsScript.fbmwClassSneakScore.SetValue(1)
	endif
	if (Skill01 == 28) || (Skill02 == 28) || (Skill03 == 28) || (Skill04 == 28) || (Skill05 == 28) || (Skill06 == 28) || (Skill07 == 28) || (Skill08 == 28)
		BaseScript.SkillsScript.fbmwClassSpeechcraftScore.SetValue(1)
	endif

	BaseScript.SendClassInfo(ClassName, ClassSpecialization, ClassAttribute01, ClassAttribute02, \
							 ClassSkill01, ClassSkill02, ClassSkill03, ClassSkill04, ClassSkill05, ClassSkill06, ClassSkill07, ClassSkill08)
	if GetStage()>10
		; prereq stage to avoid conflict with rapid chargen
		SetStage(13)
	endif
EndFunction
