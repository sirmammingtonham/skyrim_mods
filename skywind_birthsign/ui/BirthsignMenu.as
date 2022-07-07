import gfx.io.GameDelegate;
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

import skyui.util.Translator;
import JSON;

class BirthsignMenu extends MovieClip {
    /* PRIVATE VARIABLES */
    // birthsign selection buttons
    private var apprentice:BirthsignButton;
    private var atronach:BirthsignButton;
    private var ritual:BirthsignButton;
    private var mage:BirthsignButton;
    private var lady:BirthsignButton;
    private var lord:BirthsignButton;
    private var steed:BirthsignButton;
    private var warrior:BirthsignButton;
    private var serpent:BirthsignButton;
    private var lover:BirthsignButton;
    private var shadow:BirthsignButton;
    private var tower:BirthsignButton;
    private var thief:BirthsignButton;

    // other buttons
    private var title_header:TextField;
    private var tip_button:Button;
    private var proceed_button:Button;

    // buff descriptions
    private var big_image:MovieClip;
    private var text_description:TextField;
    private var effects_list:EffectsList;

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
        this.birthsignData = JSON.parse("{\"apprentice\":{\"abilities\":[{\"type\":\"$ABILITY\",\"icon\":\"rest_fortify\"},{\"type\":\"$ABILITY\",\"icon\":\"default_effect\"}]},\"atronach\":{\"abilities\":[{\"type\":\"$ABILITY\",\"icon\":\"rest_fortify\"},{\"type\":\"$ABILITY\",\"icon\":\"myst_absorb\"},{\"type\":\"$ABILITY\",\"icon\":\"default_effect\"}]},\"ritual\":{\"abilities\":[{\"type\":\"$ABILITY\",\"icon\":\"default_power\"},{\"type\":\"$LESSER_POWER\",\"icon\":\"conj_turn\"},{\"type\":\"$GREATER_POWER\",\"icon\":\"rest_restore\"}]},\"mage\":{\"abilities\":[{\"type\":\"$ABILITY\",\"icon\":\"rest_fortify\"},{\"type\":\"$LESSER_POWER\",\"icon\":\"default_power\"}]},\"lady\":{\"abilities\":[{\"type\":\"$ABILITY\",\"icon\":\"rest_fortify\"},{\"type\":\"$ABILITY\",\"icon\":\"rest_fortify\"}]},\"lord\":{\"abilities\":[{\"type\":\"$ABILITY\",\"icon\":\"rest_fortify\"},{\"type\":\"$ABILITY\",\"icon\":\"rest_fortify\"},{\"type\":\"$ABILITY\",\"icon\":\"default_effect\"}]},\"steed\":{\"abilities\":[{\"type\":\"$ABILITY\",\"icon\":\"rest_fortify\"},{\"type\":\"$LESSER_POWER\",\"icon\":\"default_power\"}]},\"warrior\":{\"abilities\":[{\"type\":\"$ABILITY\",\"icon\":\"default_power\"}]},\"serpent\":{\"abilities\":[{\"type\":\"$ABILITY\",\"icon\":\"rest_fortify\"},{\"type\":\"$ABILITY\",\"icon\":\"default_effect\"},{\"type\":\"$LESSER_POWER\",\"icon\":\"dest_poison\"},{\"type\":\"$GREATER_POWER\",\"icon\":\"rest_cure\"}]},\"lover\":{\"abilities\":[{\"type\":\"$ABILITY\",\"icon\":\"rest_fortify\"},{\"type\":\"$ABILITY\",\"icon\":\"illu_paralysis\"}]},\"shadow\":{\"abilities\":[{\"type\":\"$LESSER_POWER\",\"icon\":\"default_power\"},{\"type\":\"$GREATER_POWER\",\"icon\":\"illu_invis\"}]},\"tower\":{\"abilities\":[{\"type\":\"$LESSER_POWER\",\"icon\":\"default_power\"},{\"type\":\"$GREATER_POWER\",\"icon\":\"alte_open\"},{\"type\":\"$GREATER_POWER\",\"icon\":\"myst_reflect\"}]},\"thief\":{\"abilities\":[{\"type\":\"$ABILITY\",\"icon\":\"illu_sanctuary\"}]}}");
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
        tip_button.addEventListener(EventTypes.ROLL_OVER, this, "handleTipRollover");
        proceed_button.addEventListener(EventTypes.CLICK, this, "handleProceedPress");

        initializeTranslations();

        apprentice.simulateClick();
        tip_button.disableFocus = true;

        skse.SendModEvent("SW_BirthSignMenuOpen");

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
    private function initializeTranslations() {
        apprentice.theField.htmlText = Translator.translate("$the");
        apprentice.textField.htmlText = Translator.translate("$apprentice");

        atronach.theField.htmlText = Translator.translate("$the");
        atronach.textField.htmlText = Translator.translate("$atronach");

        ritual.theField.htmlText = Translator.translate("$the");
        ritual.textField.htmlText = Translator.translate("$ritual");

        mage.theField.htmlText = Translator.translate("$the");
        mage.textField.htmlText = Translator.translate("$mage");

        lady.theField.htmlText = Translator.translate("$the");
        lady.textField.htmlText = Translator.translate("$lady");

        lord.theField.htmlText = Translator.translate("$the");
        lord.textField.htmlText = Translator.translate("$lord");

        steed.theField.htmlText = Translator.translate("$the");
        steed.textField.htmlText = Translator.translate("$steed");

        warrior.theField.htmlText = Translator.translate("$the");
        warrior.textField.htmlText = Translator.translate("$warrior");

        serpent.theField.htmlText = Translator.translate("$the");
        serpent.textField.htmlText = Translator.translate("$serpent");

        lover.theField.htmlText = Translator.translate("$the");
        lover.textField.htmlText = Translator.translate("$lover");

        shadow.theField.htmlText = Translator.translate("$the");
        shadow.textField.htmlText = Translator.translate("$shadow");

        tower.theField.htmlText = Translator.translate("$the");
        tower.textField.htmlText = Translator.translate("$tower");

        thief.theField.htmlText = Translator.translate("$the");
        thief.textField.htmlText = Translator.translate("$thief");

        // tip_button.textField.text = Translator.translate("$BirthsignMenuTips");
        title_header.textField.htmlText = Translator.translate("$BirthsignMenuTitle");

        proceed_button.textField.htmlText = Translator.translate("$Proceed");
    }

    private function handleBirthsignPress(idx:Number) {
        var name:String = this.signs[idx];
        var data = birthsignData[name];

        this.selectedIdx = idx;
        this.text_description.htmlText = Translator.translate("$" + name + "_DESC");
        this.effects_list._y = this.text_description._y + this.text_description.textHeight + 30;

        this.effects_list.dataProvider = {sign: name, abilities: data["abilities"]};

        this.big_image.gotoAndStop(name);
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

    private function handleTipRollover(a_event:Object):Void {
        tip_button.textField.htmlText = Translator.translate("$BirthsignMenuTips");
    }

    private function handleProceedPress(a_event:Object):Void {
        skse.SendModEvent("SW_BirthSignMenuClose", "", this.selectedIdx);
        skse.CloseMenu("CustomMenu");
    }

    public function log(a_message:String):Void {
        skse.Log(a_message);
    }
}
