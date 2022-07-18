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

Event onClassQuizMenuClose(string eventName, string strArg, float z, Form sender)
	float t = Math.Floor((-1 + Math.sqrt(1 + 8 * z))/2); z is encoded as a cantor pair :)
	int specialization = (t * (t + 3) / 2 - z) as int;
	int selection = (z - t * (t + 1) / 2) as int;
	;Debug.Trace("z: " + z + " spec: " + specialization + " sel: " + selection)
	BaseScript.ConfirmClass(specialization, selection, true)
EndEvent
