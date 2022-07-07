Scriptname fbmw_ChargenBirthsignsScript extends Quest  
{Handles birthsign menu part of character generation. 
Build 0.9.9.6 added referecealias to hold birthsign name (same method as used for class, etc) and replaced Game.GetPlayer() with PlayerRef.
Build 0.9.9.16 revised general structure of code; birthsigns handled entirely by perks so that updates can be script-independent.}

;/
	Contributors: km816, yeeb, people who didn't comment their code
    Last updated: 2022.07.07 / July 7, 2022
/;

;=== properties
referencealias property BirthsignAlias auto
actor property PlayerRef auto

perk Property fbmwBirthsignApprenticePerk  Auto  
perk Property fbmwBirthsignAtronachPerk  Auto 
perk Property fbmwBirthsignLadyPerk  Auto   
perk Property fbmwBirthsignLordPerk  Auto   
perk Property fbmwBirthsignLoverPerk  Auto  
perk Property fbmwBirthsignMagePerk  Auto  
perk Property fbmwBirthsignRitualPerk  Auto   
perk Property fbmwBirthsignSerpentPerk  Auto  
perk Property fbmwBirthsignShadowPerk  Auto
perk Property fbmwBirthsignSteedPerk  Auto  
perk Property fbmwBirthsignThiefPerk  Auto    
perk Property fbmwBirthsignTowerPerk  Auto  
perk Property fbmwBirthsignWarriorPerk  Auto  

perk property PerkToAdd auto hidden

;=== chargen functions/events
Function Menu(Int aiMessage = 0, Int aiButton = 0, Bool abMenu = True)
	RegisterForModEvent("SW_BirthSignMenuClose", "onBirthSignMenuClose") ; the menu sends a mod event when closed
	Skywind.SetCompassAlpha(0.0) ; hide the compass so we can see the title
	UI.OpenCustomMenu("birthsignmenu")
EndFunction

Event onBirthSignMenuClose(string eventName, string strArg, float numArg, Form sender)
	Debug.Trace("I recieved: " + numArg)
	Skywind.SetCompassAlpha(100.0)
	ApplyNewBirthsign(numArg)
EndEvent

Event ApplyNewBirthsign(float numArg)
	string BirthsignName	
	If(numArg == 0)
		BirthsignName = SetSignToApprentice()
	ElseIf(numArg == 1)
		BirthsignName = SetSignToAtronach()
	ElseIf(numArg == 2)
		BirthsignName = SetSignToRitual()
	ElseIf(numArg == 3)
		BirthsignName = SetSignToMage()
	ElseIf(numArg == 4)
		BirthsignName = SetSignToLady()
	ElseIf(numArg == 5)
		BirthsignName = SetSignToLord()
	ElseIf(numArg == 6)
		BirthsignName = SetSignToSteed()
	ElseIf(numArg == 7)
		BirthsignName = SetSignToWarrior()
	ElseIf(numArg == 8)
		BirthsignName = SetSignToSerpent()
	ElseIf(numArg == 9)
		BirthsignName = SetSignToLover()
	ElseIf(numArg == 10)
		BirthsignName = SetSignToShadow()
	ElseIf(numArg == 11)
		BirthsignName = SetSignToTower()
	ElseIf(numArg == 12)
		BirthsignName = SetSignToThief()
	Else
		Debug.Notification("No birthsign selected? You broke the menu!")
		BirthsignName = ":("
	EndIf
	
	(BirthsignAlias.GetReference().GetBaseObject()).SetName(BirthsignName)
	(PlayerRef as fbmw_ClassMenuInformation).Birthsign = BirthsignName
	
	if GetStage()>10
		; prereq stage to avoid conflict with rapid chargen
		SetStage(13)
	endif
	
EndEvent 

;=== birthsign effects
string Function SetSignToApprentice()
	debug.trace("Apprentice birthsign applied")
	PerkToAdd = fbmwBirthsignApprenticePerk
	return "The Apprentice"
EndFunction

string Function SetSignToAtronach()
	debug.trace("Atronach birthsign applied")
	PerkToAdd = fbmwBirthsignAtronachPerk
	return "The Atronach"
EndFunction

string Function SetSignToLady()
	debug.trace("Lady birthsign applied")
	PerkToAdd = fbmwBirthsignLadyPerk
	return "The Lady"
EndFunction

string Function SetSignToLord()
	debug.trace("Lord birthsign applied")
	PerkToAdd = fbmwBirthsignLordPerk
	return "The Lord"
EndFunction

string Function SetSignToLover()
	debug.trace("Lover birthsign applied")
	PerkToAdd = fbmwBirthsignLoverPerk
	return "The Lover"
EndFunction

string Function SetSignToMage()
	debug.trace("Mage birthsign applied")
	PerkToAdd = fbmwBirthsignMagePerk
	return "The Mage"
EndFunction

string Function SetSignToRitual()
	debug.trace("Ritual birthsign applied")
	PerkToAdd = fbmwBirthsignRitualPerk
	return "The Ritual"
EndFunction

string Function SetSignToSerpent()
	debug.trace("Serpent birthsign applied")
	PerkToAdd = fbmwBirthsignSerpentPerk
	return "The Serpent"
EndFunction

string Function SetSignToShadow()
	debug.trace("Shadow birthsign applied")
	PerkToAdd = fbmwBirthsignShadowPerk
	return "The Shadow"
EndFunction

string Function SetSignToSteed()
	debug.trace("Steed birthsign applied")
	PerkToAdd = fbmwBirthsignSteedPerk
	return "The Steed"
EndFunction

string Function SetSignToThief()
	debug.trace("Thief birthsign applied")
	PerkToAdd = fbmwBirthsignThiefPerk
	return "The Thief"
EndFunction

string Function SetSignToTower()
	debug.trace("Tower birthsign applied")
	PerkToAdd = fbmwBirthsignTowerPerk
	return "The Tower"
EndFunction

string Function SetSignToWarrior()
	debug.trace("Warrior birthsign applied")
	PerkToAdd = fbmwBirthsignWarriorPerk
	return "The Warrior"
EndFunction 

function FinalizeBirthsign()
	PlayerRef.AddPerk(PerkToAdd)
endFunction 
