Scriptname fbmw_ChargenClassGenerateScript extends Quest conditional
{handles class selection}
;Made by Rovan 2/10/18
;redone by yeeb 7/17/22

;========== general properties ==========
Actor Property PlayerRef Auto 
fbmw_ChargenClassBaseScript property BaseScript auto

;========== convienience function ==========
function Enter(actor myActor)
	BaseScript.LedgerEnter(myActor)
	UI.OpenCustomMenu("classquizmenu")
	RegisterForModEvent("SW_ClassQuizMenuClose", "onClassQuizMenuClose")
endFunction

function Write(actor myActor)
	BaseScript.LedgerWrite(myActor)
endFunction

Function GenerateClass()
	UI.OpenCustomMenu("classquizmenu")
endFunction

Event onClassQuizMenuClose(string eventName, string strArg, float classId, Form sender)
	; open class menu in confirmation mode and pass classid
	Skywind.OpenClassMenu(classId as int)
	BaseScript.ConfirmClass(classId as int)
EndEvent

