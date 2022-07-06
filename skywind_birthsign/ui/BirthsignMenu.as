﻿import gfx.io.GameDelegate;
import gfx.ui.NavigationCode;
import gfx.ui.InputDetails;
import Shared.GlobalFunc;

import gfx.controls.Button;
import gfx.controls.DropdownMenu;
import gfx.controls.ScrollingList;
import gfx.controls.Slider;
import gfx.controls.TextInput;

import gfx.events.EventDispatcher;
import gfx.events.EventTypes;
import JSON;

class BirthsignMenu extends MovieClip {
    /* PRIVATE VARIABLES */
    // birthsign selection buttons
    private var apprentice:BirthsignButton;
    private var atronach:Button;
    private var ritual:Button;
    private var mage:Button;
    private var lady:Button;
    private var lord:Button;
    private var steed:Button;
    private var warrior:Button;
    private var serpent:Button;
    private var lover:Button;
    private var shadow:Button;
    private var tower:Button;
    private var thief:Button;

    // other buttons
    private var tip_button:Button;
    private var proceed_button:Button;

    // buff descriptions
    private var big_image:MovieClip;
    private var text_description:TextField;
    private var buff_desc0:MovieClip;
    private var buff_desc1:MovieClip;
    private var buff_desc2:MovieClip;
    private var buff_desc3:MovieClip;
    private var buff_descs:Array;

    private var birthsignData;
    private var signs:Array = ["apprentice",
        "atronach",
        "ritual",
        "mage",
        "lady",
        "lord",
        "steed",
        "warrior",
        "serpent",
        "lover",
        "shadow",
        "tower",
        "thief"];

    // track stuff
    private var selectedIdx:Number;

    /* INITIALIZATION */
    public function BirthsignMenu() {
        super();
        EventDispatcher.initialize(this);

        this.birthsignData = JSON.parse("{\"apprentice\":{\"description\":\"The Apprentice is one of the charges of the Mage, and its season is Sun's Height. Those born under the sign of the Apprentice have much more magicka, but are more vulnerable to magick as well.\",\"class\":\"mage\",\"abilities\":[{\"type\":\"ABILITY\",\"icon\":\"rest_fortify\",\"name\":\"Elfborn\",\"description\":\"Fortify Magicka 1.5x\"},{\"type\":\"ABILITY\",\"icon\":\"dest_elemental_weakness\",\"name\":\"Elfborn\",\"description\":\"Weakness to Magicka 50% on Self\"}]},\"atronach\":{\"description\":\"The Atronach is one of the Mage's charges and its season is Sun's Dusk. Those born under this sign are natural sorcerers who frequently absorb hostile spells and possess deep reserves of magicka, but they cannot regenerate magicka naturally.\",\"class\":\"mage\",\"abilities\":[{\"type\":\"ABILITY\",\"icon\":\"rest_fortify\",\"name\":\"Wombburn\",\"description\":\"Fortify Magicka 2.0x\"},{\"type\":\"ABILITY\",\"icon\":\"myst_absorb\",\"name\":\"Wombburn\",\"description\":\"Spell Absorption 50% on Self\"},{\"type\":\"ABILITY\",\"icon\":\"dest_elemental_weakness\",\"name\":\"Wombburn (change icon)\",\"description\":\"-100% Magicka regen\"}]},\"ritual\":{\"description\":\"The Ritual is one of the Mage's charges and its season is Morning Star. Those born under this sign carry the Divine's blessing. They can turn the undead, their spells are more powerful against them, and they have the ability to greatly restore their health and magicka once each day.\",\"class\":\"mage\",\"abilities\":[{\"type\":\"ABILITY\",\"icon\":\"default_conjuration\",\"name\":\"Arkay's Grace\",\"description\":\"All spells are 25% more powerful vs. undead\"},{\"type\":\"LESSER POWER\",\"icon\":\"conj_turn\",\"name\":\"Blessed Ward\",\"description\":\"Turn Undead 100 points (level 30?) for 30 seconds.\"},{\"type\":\"GREATER POWER\",\"icon\":\"rest_restore\",\"name\":\"Mara's Grace\",\"description\":\"Restore Health and Magicka 100pts\"}]},\"mage\":{\"description\":\"The Mage is a guardian constellation whose season is Rain's Hand when magicka was first used by men. Those born under the Mage  are often talented, arrogant, and absent-minded. They have more magicka than others, and can intensify the power of their spells at the cost of greater magicka drain.\",\"class\":\"mage\",\"abilities\":[{\"type\":\"ABILITY\",\"icon\":\"rest_fortify\",\"name\":\"Fay\",\"description\":\"Fortify Magicka 0.5x\"},{\"type\":\"LESSER POWER\",\"icon\":\"default_mysticism\",\"name\":\"Fay\",\"description\":\"Spells are 25% more powerful for 30 seconds but cost 10% more magicka\"}]},\"lady\":{\"description\":\"The Lady is one of the Warrior's charges and her season is Hearthfire. Those born under the sign of the Lady are beloved and possess great fortitude.\",\"class\":\"warrior\",\"abilities\":[{\"type\":\"ABILITY\",\"icon\":\"rest_fortify\",\"name\":\"Lady's Favor\",\"description\":\"Fortify Personality 25 Points\"},{\"type\":\"ABILITY\",\"icon\":\"rest_fortify\",\"name\":\"Lady's Grace\",\"description\":\"Fortify Endurance 25 Points\"}]},\"lord\":{\"description\":\"The Lord is one of the Warrior's charges. During his season of First Seed he oversees planting over all Tamriel. Those born under the sign of the Lord are stronger and can work longer than those born under other signs, but they are more suceptible to fire.\",\"class\":\"warrior\",\"abilities\":[{\"type\":\"ABILITY\",\"icon\":\"rest_fortify\",\"name\":\"Blood of the North\",\"description\":\"Fortify Strength 25 Points\"},{\"type\":\"ABILITY\",\"icon\":\"rest_fortify\",\"name\":\"Blood of the North\",\"description\":\"Fortify Endurance 25 Points\"},{\"type\":\"ABILITY\",\"icon\":\"dest_elemental_weakness\",\"name\":\"Trollkin\",\"description\":\"Weakness to Fire 100%\"}]},\"steed\":{\"description\":\"The Steed is one of the Warrior's charges, and its season is Mid Year. Those born under the sign of the Steed are impatient and always hurrying from one place to another. They can also make their blows in battle more swift, though more tiring.\",\"class\":\"warrior\",\"abilities\":[{\"type\":\"ABILITY\",\"icon\":\"rest_fortify\",\"name\":\"\",\"description\":\"Fortify Speed 25 Points on Self\"},{\"type\":\"LESSER POWER\",\"icon\":\"default_alteration\",\"name\":\"\",\"description\":\"Weapon speed increased 20%, but lose 2 stamina/sec for 30 seconds\"}]},\"warrior\":{\"description\":\"The Warrior is a guardian constellation. His season is Last Seed when his strength is needed for the harvest. Those born under this sign are short-tempered and can sometimes strike foes with devistating force.\",\"class\":\"warrior\",\"abilities\":[{\"type\":\"ABILITY\",\"icon\":\"default_destruction\",\"name\":\"\",\"description\":\"All physical attacks have a 10% chance of doing double damage\"}]},\"serpent\":{\"description\":\"The Serpent wanders the sky threating other constellations and has no set season. Those born under this sign are the most blessed and the most cursed on Tamriel. Their luck is strong, but they are vulnerable to poison, and they may inflict a bite on others that poisions them both. Once each day, they may instantly cure themselves of poison.\",\"class\":\"serpent\",\"abilities\":[{\"type\":\"ABILITY\",\"icon\":\"rest_fortify\",\"name\":\"Star-Curse\",\"description\":\"Fortify Luck 25 points\"},{\"type\":\"ABILITY\",\"icon\":\"dest_elemental_weakness\",\"name\":\"Star-Curse\",\"description\":\"Weakness to Poison 100% on self\"},{\"type\":\"LESSER POWER\",\"icon\":\"dest_poison\",\"name\":\"Snake's Bite\",\"description\":\"Poison on touch 3 points & self 1 points for 30 seconds\"},{\"type\":\"GREATER POWER\",\"icon\":\"rest_cure\",\"name\":\"Snake Spell\",\"description\":\"Cure posion\"}]},\"lover\":{\"description\":\"The Lover is one of the Thief's charges and her season is Sun's Dawn. Those born under the sign of the Lover are graceful and passionate. Though it is exhausting they can sometimes paralyze others with the touch of their lips.\",\"class\":\"thief\",\"abilities\":[{\"type\":\"ABILITY\",\"icon\":\"rest_fortify\",\"name\":\"Mooncalf\",\"description\":\"Fortify Agility 25 points on self\"},{\"type\":\"ABILITY\",\"icon\":\"illu_paralysis\",\"name\":\"Lover's Kiss\",\"description\":\"Paralyze 60 Seconds on Touch, Damage Fatigue 200 Points on Self\"}]},\"shadow\":{\"description\":\"The Shadow is a charge of the Thief, and his season is Second Seed. The Shadow grants those born under the sign the ability to better hide in shadows, though the effort is tiring, and once each day they may render themselves invisible for a time.\",\"class\":\"thief\",\"abilities\":[{\"type\":\"LESSER POWER\",\"icon\":\"default_illusion\",\"name\":\"Fingernail Moon\",\"description\":\"20% harder to detect & drains 2 stamina/sec for the next 30 seconds\"},{\"type\":\"GREATER POWER\",\"icon\":\"illu_invis\",\"name\":\"Moonshadow\",\"description\":\"Invisibility for 60 Seconds on Self\"}]},\"tower\":{\"description\":\"The Tower is one of the Thief's charges and its season is Frostfall. Those born under the sign of the Tower have a knack for avoiding others when they wish to hide and once each day they can open difficult locks and reflect some blows back at any who attack them.\",\"class\":\"thief\",\"abilities\":[{\"type\":\"LESSER POWER\",\"icon\":\"default_alteration\",\"name\":\"The Master's Hands\",\"description\":\"For 15 seconds, detect life 200ft & locks are 20% easier to pick\"},{\"type\":\"GREATER POWER\",\"icon\":\"alte_open\",\"name\":\"Tower Key\",\"description\":\"Open Adept Lock [50 Points] on Target\"},{\"type\":\"GREATER POWER\",\"icon\":\"myst_reflect\",\"name\":\"Tower Warden\",\"description\":\"Reflect Damage 5% for 120 Seconds on Self\"}]},\"thief\":{\"description\":\"The Thief is a guardian constellation, and its season is the darkest month of Evening Star. Those born under the sign of the Thief are not typically thieves, though they take risks more often and only rarely come to harm. They do run out of luck eventually, however, and often don't live as long as those born under other signs.\",\"class\":\"thief\",\"abilities\":[{\"type\":\"ABILITY\",\"icon\":\"illu_sanctuary\",\"name\":\"Akiviri Danger-Sense\",\"description\":\"Sanctuary 10 points\"}]}}");
        this.buff_descs = new Array(4);
        this.buff_descs[0] = buff_desc0;
        this.buff_descs[1] = buff_desc1;
        this.buff_descs[2] = buff_desc2;
        this.buff_descs[3] = buff_desc3;
    }

    public function onLoad():Void {
        apprentice.addEventListener(EventTypes.CLICK, this, "handleApprenticePress");
        atronach.addEventListener(EventTypes.CLICK, this, "handleAtronachPress");
        ritual.addEventListener(EventTypes.CLICK, this, "handleRitualPress");
        mage.addEventListener(EventTypes.CLICK, this, "handleMagePress");
        lady.addEventListener(EventTypes.CLICK, this, "handleLadyPress");
        lord.addEventListener(EventTypes.CLICK, this, "handleLordPress");
        steed.addEventListener(EventTypes.CLICK, this, "handleSteedPress");
        warrior.addEventListener(EventTypes.CLICK, this, "handleWarriorPress");
        serpent.addEventListener(EventTypes.CLICK, this, "handleSerpentPress");
        lover.addEventListener(EventTypes.CLICK, this, "handleLoverPress");
        shadow.addEventListener(EventTypes.CLICK, this, "handleShadowPress");
        tower.addEventListener(EventTypes.CLICK, this, "handleTowerPress");
        thief.addEventListener(EventTypes.CLICK, this, "handleThiefPress");

        proceed_button.addEventListener(EventTypes.CLICK, this, "handleProceedPress");

        apprentice.simulateClick();

        log("loaded");
    }

    public function handleInput(details:InputDetails, pathToFocus:Array):Boolean {
        var nextClip = pathToFocus.shift();

        if (nextClip.handleInput(details, pathToFocus)) {
            return true;
        }

        // if (GlobalFunc.IsKeyPressed(details) && (details.navEquivalent == NavigationCode.TAB || details.navEquivalent == NavigationCode.SHIFT_TAB)) {
        // GameDelegate.call("CloseMenu", []);
        // }
        return true;
    }

    /* PRIVATE FUNCTIONS */
    private function handleBirthsignPress(idx:Number) {
        this.selectedIdx = idx;
        var name:String = this.signs[idx];
        var data = birthsignData[name];
        this.big_image.gotoAndStop(name);
        this.text_description.htmlText = data["description"];
        for (var i:Number = 0; i < 4; i++) {
            if (i < data["abilities"].length) {
                var ability = data["abilities"][i];
                this.buff_descs[i].gotoAndStop("enabled");
                this.buff_descs[i].icon.gotoAndStop(ability["icon"]);
                this.buff_descs[i].textField.htmlText = ability["type"] + ": " + ability["name"] + " - " + ability["description"];
            } else {
                this.buff_descs[i].gotoAndStop("disabled");
            }
        }
    }

    // bruh why cant i just pass in arguments
    private function handleApprenticePress(a_event:Object):Void {
        this.handleBirthsignPress(0);
    }

    private function handleAtronachPress(a_event:Object):Void {
        this.handleBirthsignPress(1);
    }

    private function handleRitualPress(a_event:Object):Void {
        this.handleBirthsignPress(2);
    }

    private function handleMagePress(a_event:Object):Void {
        this.handleBirthsignPress(3);
    }

    private function handleLadyPress(a_event:Object):Void {
        this.handleBirthsignPress(4);
    }

    private function handleLordPress(a_event:Object):Void {
        this.handleBirthsignPress(5);
    }

    private function handleSteedPress(a_event:Object):Void {
        this.handleBirthsignPress(6);
    }

    private function handleWarriorPress(a_event:Object):Void {
        this.handleBirthsignPress(7);
    }

    private function handleSerpentPress(a_event:Object):Void {
        this.handleBirthsignPress(8);
    }

    private function handleLoverPress(a_event:Object):Void {
        this.handleBirthsignPress(9);
    }

    private function handleShadowPress(a_event:Object):Void {
        this.handleBirthsignPress(10);
    }

    private function handleTowerPress(a_event:Object):Void {
        this.handleBirthsignPress(11);
    }

    private function handleThiefPress(a_event:Object):Void {
        this.handleBirthsignPress(12);
    }

    private function handleProceedPress(a_event:Object):Void {
        GameDelegate.call("ConfirmSelection", [this.selectedIdx]);
    }

    public function log(a_message:String):Void {
        GameDelegate.call("Log", [a_message]);
    }
}

