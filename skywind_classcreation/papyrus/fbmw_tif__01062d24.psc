;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname fbmw_TIF__01062D24 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; fbmwChargen Generate Class
fbmw_ChargenClassBaseScript myScript = GetOwningQuest() as fbmw_ChargenClassBaseScript 
myScript.LedgerEnter(akSpeaker)
myScript.doReset = 0
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; fbmwChargen Generate Class
fbmw_ChargenClassPickListScript myScript = GetOwningQuest() as fbmw_ChargenClassPickListScript
myScript.PickFromClassList()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
