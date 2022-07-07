ScriptName TES4SpellmakingStationScript extends ObjectReference Conditional
Actor Property PlayerRef Auto Conditional;TES4FormID:20;
Event OnInit()
    self.BlockActivation()
EndEvent
Event OnActivate(ObjectReference akActivateRef)
    If (((akActivateRef == PlayerRef) == True))
        spellmaking.OpenSpellmaking()
    EndIf
EndEvent