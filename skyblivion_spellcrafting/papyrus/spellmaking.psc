Scriptname Spellmaking  

Function OpenSpellmaking() Global Native ; opens the spellmaking menu
Function CloseSpellmaking() Global Native ; closes spellmaking menu

; obsolete since we added purchase confirmation to the plugin
; Spell Function GetCraftedSpell() Global Native ; returns the last spell crafted through the spellmaking menu
; float Function GetSpellCost(Spell s) Global Native ; returns the gold price of spell {s}
; Function QueueSpellSave(Spell s) Global Native ; adds spell {s} to the cosave (will be automatically resaved on subsequent saves)