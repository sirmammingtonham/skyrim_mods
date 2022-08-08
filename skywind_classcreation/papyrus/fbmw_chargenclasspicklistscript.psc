Scriptname fbmw_ChargenClassPickListScript extends Quest  
{handles class selection}
;Made by Rovan 2/10/18
;changed by yeeb to use custom menu 8/7/22

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
	; open custom menu in class list mode (mode -1)
	Skywind.OpenClassMenu(-1)
endFunction

; function is called from plugin once proceed is pressed in menu
Function ConfirmClass(int classId)
	BaseScript.ConfirmClass(classId)
endFunction
