;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname fbmw_TIF__01062CF6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; fbmwChargen Generate Class
fbmw_ChargenClassGenerateScript myScript = GetOwningQuest() as fbmw_ChargenClassGenerateScript
;myScript.ResetScores()
myScript.Enter(akSpeaker)
myScript.BaseScript.doReset = 0
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
