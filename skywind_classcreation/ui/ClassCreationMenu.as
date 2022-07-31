import gfx.controls.TextInput;
import gfx.controls.Button;
import gfx.io.GameDelegate;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import Shared.GlobalFunc;
import skyui.defines.Input;
import skyui.util.Translator;


import gfx.events.EventDispatcher;
import gfx.events.EventTypes;

class ClassCreationMenu extends MovieClip {
    // specialization
    private var warrior:Button;
    private var mage:Button;
    private var thief:Button;

    // attributes
    private var agility:Button;
    private var endurance:Button;
    private var intelligence:Button;
    private var luck:Button;
    private var personality:Button;
    private var speed:Button;
    private var strength:Button;
    private var willpower:Button;

    // warrior skills
    private var armorer:Button;
    private var athletics:Button;
    private var axe:Button;
    private var block:Button;
    private var blunt_weapon:Button;
    private var heavy_armor:Button;
    private var long_blade:Button;
    private var medium_armor:Button;
    private var polearm:Button;
    // mage skills
    private var alchemy:Button;
    private var alteration:Button;
    private var conjuration:Button;
    private var destruction:Button;
    private var enchant:Button;
    private var illusion:Button;
    private var mysticism:Button;
    private var restoration:Button;
    private var unarmored:Button;
    // thief skills
    private var acrobatics:Button;
    private var hand_to_hand:Button;
    private var light_armor:Button;
    private var marksman:Button;
    private var mercantile:Button;
    private var security:Button;
    private var short_blade:Button;
    private var sneak:Button;
    private var speechcraft:Button;

    /////
    private var _numAttributes;



    public function ClassCreationMenu() {
        super();
    }

    public function onLoad():Void {
        super.onLoad();
        setButtonText();

        _numAttributes = 0;

        // warrior
        armorer.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        armorer.addEventListener(EventTypes.ROLL_OVER, this, "handleAttributePress");
        athletics.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        axe.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        block.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        blunt_weapon.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        heavy_armor.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        long_blade.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        medium_armor.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        polearm.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        // mage
        alchemy.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        alteration.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        conjuration.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        destruction.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        enchant.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        illusion.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        mysticism.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        restoration.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        unarmored.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        // thief
        acrobatics.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        hand_to_hand.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        light_armor.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        marksman.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        mercantile.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        security.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        short_blade.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        sneak.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
        speechcraft.addEventListener(EventTypes.CLICK, this, "handleAttributePress");
    }

    public function InitExtensions():Void {
        super.InitExtensions();
    }

    public function handleInput(details:InputDetails, pathToFocus:Array):Boolean {
        return true;
    }

    private function handleAttributePress(a_event:Object) {
        // a_event.target.gotoAndStop("over");
        // trace(a_event.target.toggle);
    }

    private function setButtonText() {
        // attributes
        agility.textField.text = Translator.translate("$AGILITY");
        endurance.textField.text = Translator.translate("$ENDURANCE");
        intelligence.textField.text = Translator.translate("$INTELLIGENCE");
        luck.textField.text = Translator.translate("$LUCK");
        personality.textField.text = Translator.translate("$PERSONALITY");
        speed.textField.text = Translator.translate("$SPEED");
        strength.textField.text = Translator.translate("$STRENGTH");
        willpower.textField.text = Translator.translate("$WILLPOWER");
        // warrior skills
        armorer.textField.text = Translator.translate("$ARMORER");
        athletics.textField.text = Translator.translate("$ATHLETICS");
        axe.textField.text = Translator.translate("$AXE");
        block.textField.text = Translator.translate("$BLOCK");
        blunt_weapon.textField.text = Translator.translate("$BLUNT_WEAPON");
        heavy_armor.textField.text = Translator.translate("$HEAVY_ARMOR");
        long_blade.textField.text = Translator.translate("$LONG_BLADE");
        medium_armor.textField.text = Translator.translate("$MEDIUM_ARMOR");
        polearm.textField.text = Translator.translate("$POLEARM");
        // mage skills
        alchemy.textField.text = Translator.translate("$ALCHEMY");
        alteration.textField.text = Translator.translate("$ALTERATION");
        conjuration.textField.text = Translator.translate("$CONJURATION");
        destruction.textField.text = Translator.translate("$DESTRUCTION");
        enchant.textField.text = Translator.translate("$ENCHANT");
        illusion.textField.text = Translator.translate("$ILLUSION");
        mysticism.textField.text = Translator.translate("$MYSTICISM");
        restoration.textField.text = Translator.translate("$RESTORATION");
        unarmored.textField.text = Translator.translate("$UNARMORED");
        // thief skills
        acrobatics.textField.text = Translator.translate("$ACROBATICS");
        hand_to_hand.textField.text = Translator.translate("$HAND_TO_HAND");
        light_armor.textField.text = Translator.translate("$LIGHT_ARMOR");
        marksman.textField.text = Translator.translate("$MARKSMAN");
        mercantile.textField.text = Translator.translate("$MERCANTILE");
        security.textField.text = Translator.translate("$SECURITY");
        short_blade.textField.text = Translator.translate("$SHORT_BLADE");
        sneak.textField.text = Translator.translate("$SNEAK");
        speechcraft.textField.text = Translator.translate("$SPEECHCRAFT");
    }

}
