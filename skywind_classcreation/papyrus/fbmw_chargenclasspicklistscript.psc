Scriptname fbmw_ChargenClassPickListScript extends Quest  
{handles class selection}
;Made by Rovan 2/10/18

;========== General properties ==========
Actor Property PlayerRef Auto 
fbmw_ChargenClassBaseScript property BaseScript auto
Message Property fbmwClassTypeList Auto

;========== convienience function ==========
function Enter(actor myActor)
	BaseScript.LedgerEnter(myActor)
endFunction

function Write(actor myActor)
	BaseScript.LedgerWrite(myActor)
endFunction

;========== Classes sorted by specialization ==========
Function PickFromClassList()
	; select class specialization
	Skywind.OpenClassMenu(1);
	; int aiButton = fbmwClassTypeList.Show()
	; If aiButton == 0 ; Combat
	; 	ClassesChooseCombat()
	; ElseIf aiButton == 1 ; Stealth
	; 	ClassesChooseMage()
	; ElseIf aiButton == 2 ; Mage
	; 	ClassesChooseStealth()
	; ElseIf aiButton == 3 ; Cancel
	; 	if BaseScript.isDialogue
	; 		BaseScript.doReset = 1
	; 	else
	; 		BaseScript.BeginClassSelection()
	; 	endif
	; EndIf
endFunction

Function ClassesChooseCombat() ; major skills are set to 1, minor skills are set to 2, the actual stat part happens in the fbmwSetSkills script
	string[] ClassList = new string[8]
	ClassList[0] = "Archer"
	ClassList[1] = "Barbarian"
	ClassList[2] = "Crusader"
	ClassList[3] = "Knight"
	ClassList[4] = "Rogue"
	ClassList[5] = "Scout"
	ClassList[6] = "Warrior"
	ClassList[7] = "Cancel"
	int aiButton = (((self as quest) as form) as UILIB_1).ShowList("Combat-Specialized Classes", ClassList, 0, 7)
	If (aiButton >= 0) && (aiButton <= 6)
		BaseScript.ConfirmClass(1,aiButton,false)
	else ; Back
		PickFromClassList()
	EndIf
EndFunction

Function ClassesChooseMage()
	string[] ClassList = new string[8]
	ClassList[0] = "Battlemage"
	ClassList[1] = "Healer"
	ClassList[2] = "Mage"
	ClassList[3] = "Nightblade"
	ClassList[4] = "Sorcerer"
	ClassList[5] = "Spellsword"
	ClassList[6] = "Witchhunter"
	ClassList[7] = "Cancel"
	int aiButton = (((self as quest) as form) as UILIB_1).ShowList("Magic-Specialized Classes", ClassList, 0, 7)
	If (aiButton >= 0) && (aiButton <= 6)
		BaseScript.ConfirmClass(2,aiButton,false)
	else ; Back
		PickFromClassList()
	EndIf
EndFunction

Function ClassesChooseStealth()
	string[] ClassList = new string[8]
	ClassList[0] = "Acrobat"
	ClassList[1] = "Agent"
	ClassList[2] = "Assassin"
	ClassList[3] = "Bard"
	ClassList[4] = "Monk"
	ClassList[5] = "Pilgrim"
	ClassList[6] = "Thief"
	ClassList[7] = "Cancel"
	int aiButton = (((self as quest) as form) as UILIB_1).ShowList("Stealth-Specialized Classes", ClassList, 0, 7)
	If (aiButton >= 0) && (aiButton <= 6)
		BaseScript.ConfirmClass(3,aiButton,false)
	else ; Back
		PickFromClassList()
	EndIf
EndFunction
