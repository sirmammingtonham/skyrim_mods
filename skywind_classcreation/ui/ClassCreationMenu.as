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
    // class
    private var acrobat:ClassCreationButton;
    private var agent:ClassCreationButton;
    private var archer:ClassCreationButton;
    private var assassin:ClassCreationButton;
    private var barbarian:ClassCreationButton;
    private var bard:ClassCreationButton;
    private var battlemage:ClassCreationButton;
    private var crusader:ClassCreationButton;
    private var healer:ClassCreationButton;
    private var knight:ClassCreationButton;
    private var mage:ClassCreationButton;
    private var monk:ClassCreationButton;
    private var nightblade:ClassCreationButton;
    private var pilgrim:ClassCreationButton;
    private var rogue:ClassCreationButton;
    private var scout:ClassCreationButton;
    private var sorcerer:ClassCreationButton;
    private var spellsword:ClassCreationButton;
    private var thief:ClassCreationButton;
    private var warrior:ClassCreationButton;
    private var witchhunter:ClassCreationButton;
    private var custom:ClassCreationButton;

    // specialization
    private var specWarrior:ClassCreationButton;
    private var specMage:ClassCreationButton;
    private var specThief:ClassCreationButton;

    // attributes
    private var agility:ClassCreationButton;
    private var endurance:ClassCreationButton;
    private var intelligence:ClassCreationButton;
    private var luck:ClassCreationButton;
    private var personality:ClassCreationButton;
    private var speed:ClassCreationButton;
    private var strength:ClassCreationButton;
    private var willpower:ClassCreationButton;

    // warrior skills
    private var armorer:ClassCreationButton;
    private var athletics:ClassCreationButton;
    private var axe:ClassCreationButton;
    private var block:ClassCreationButton;
    private var blunt_weapon:ClassCreationButton;
    private var heavy_armor:ClassCreationButton;
    private var long_blade:ClassCreationButton;
    private var medium_armor:ClassCreationButton;
    private var polearm:ClassCreationButton;
    // mage skills
    private var alchemy:ClassCreationButton;
    private var alteration:ClassCreationButton;
    private var conjuration:ClassCreationButton;
    private var destruction:ClassCreationButton;
    private var enchant:ClassCreationButton;
    private var illusion:ClassCreationButton;
    private var mysticism:ClassCreationButton;
    private var restoration:ClassCreationButton;
    private var unarmored:ClassCreationButton;
    // thief skills
    private var acrobatics:ClassCreationButton;
    private var hand_to_hand:ClassCreationButton;
    private var light_armor:ClassCreationButton;
    private var marksman:ClassCreationButton;
    private var mercantile:ClassCreationButton;
    private var security:ClassCreationButton;
    private var short_blade:ClassCreationButton;
    private var sneak:ClassCreationButton;
    private var speechcraft:ClassCreationButton;

    private var attributes_si:MovieClip;
    private var skills_si:MovieClip;

    private var proceed:Button;
    private var back:Button;

    private var class_art:MovieClip;
    private var class_description:TextField;

    private var skill_art:MovieClip;
    private var skill_description:TextField;

    /////
    private var _numAttributes:Number = 0;
    private var _numSkills:Number = 0;
    private var _classButtons:Array;
    private var _specializationButtons:Array;
    private var _attributeButtons:Array;
    private var _skillButtons:Array;

    public function ClassCreationMenu() {
        super();
        _classButtons = [acrobat,
            agent,
            archer,
            assassin,
            barbarian,
            bard,
            battlemage,
            crusader,
            healer,
            knight,
            mage,
            monk,
            nightblade,
            pilgrim,
            rogue,
            scout,
            sorcerer,
            spellsword,
            thief,
            warrior,
            witchhunter,
            custom];
        _specializationButtons = [specWarrior, specMage, specThief];
        _attributeButtons = [agility,
            endurance,
            intelligence,
            luck,
            personality,
            speed,
            strength,
            willpower];
        _skillButtons = [armorer,
            athletics,
            axe,
            block,
            blunt_weapon,
            heavy_armor,
            long_blade,
            medium_armor,
            polearm,
            alchemy,
            alteration,
            conjuration,
            destruction,
            enchant,
            illusion,
            mysticism,
            restoration,
            unarmored,
            acrobatics,
            hand_to_hand,
            light_armor,
            marksman,
            mercantile,
            security,
            short_blade,
            sneak,
            speechcraft];
    }

    public function onLoad():Void {
        super.onLoad();
        this.setButtonText();

        acrobat.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        agent.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        archer.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        assassin.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        barbarian.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        bard.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        battlemage.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        crusader.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        healer.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        knight.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        mage.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        monk.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        nightblade.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        pilgrim.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        rogue.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        scout.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        sorcerer.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        spellsword.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        thief.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        warrior.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        witchhunter.addEventListener(EventTypes.CLICK, this, "handleClassPress");
        custom.addEventListener(EventTypes.CLICK, this, "handleClassPress");

        specWarrior.addEventListener(EventTypes.CLICK, this, "handleSpecializationPress");
        specMage.addEventListener(EventTypes.CLICK, this, "handleSpecializationPress");
        specThief.addEventListener(EventTypes.CLICK, this, "handleSpecializationPress");
        specWarrior.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        specMage.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        specThief.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");

        agility.addEventListener(EventTypes.CLICK, this, "handleAttributePress")
        endurance.addEventListener(EventTypes.CLICK, this, "handleAttributePress")
        intelligence.addEventListener(EventTypes.CLICK, this, "handleAttributePress")
        luck.addEventListener(EventTypes.CLICK, this, "handleAttributePress")
        personality.addEventListener(EventTypes.CLICK, this, "handleAttributePress")
        speed.addEventListener(EventTypes.CLICK, this, "handleAttributePress")
        strength.addEventListener(EventTypes.CLICK, this, "handleAttributePress")
        willpower.addEventListener(EventTypes.CLICK, this, "handleAttributePress")
        agility.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover")
        endurance.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover")
        intelligence.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover")
        luck.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover")
        personality.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover")
        speed.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover")
        strength.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover")
        willpower.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover")

        // warrior
        armorer.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        athletics.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        axe.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        block.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        blunt_weapon.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        heavy_armor.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        long_blade.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        medium_armor.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        polearm.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        armorer.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        athletics.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        axe.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        block.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        blunt_weapon.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        heavy_armor.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        long_blade.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        medium_armor.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        polearm.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        // mage
        alchemy.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        alteration.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        conjuration.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        destruction.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        enchant.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        illusion.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        mysticism.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        restoration.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        unarmored.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        alchemy.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        alteration.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        conjuration.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        destruction.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        enchant.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        illusion.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        mysticism.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        restoration.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        unarmored.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        // thief
        acrobatics.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        hand_to_hand.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        light_armor.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        marksman.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        mercantile.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        security.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        short_blade.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        sneak.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        speechcraft.addEventListener(EventTypes.CLICK, this, "handleSkillPress");
        acrobatics.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        hand_to_hand.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        light_armor.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        marksman.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        mercantile.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        security.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        short_blade.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        sneak.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        speechcraft.addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");

        ///
        proceed.addEventListener(EventTypes.CLICK, this, "handleProceedPress");
        back.addEventListener(EventTypes.CLICK, this, "handleBackPress");


        ////
        acrobat.simulateClick();
    }

    public function InitExtensions():Void {
        super.InitExtensions();
    }

    public function handleInput(details:InputDetails, pathToFocus:Array):Boolean {
        return true;
    }

    private function handleProceedPress(a_event:Object) {

    }

    private function handleBackPress(a_event:Object) {

    }

    private function handleClassPress(a_event:Object) {
        class_art.gotoAndStop(a_event.target._name);
    }

    private function handleSpecializationPress(a_event:Object) {

    }

    private function handleAttributePress(a_event:Object) {
        if (a_event.target.selected) {
            _numAttributes += 1;
            if (_numAttributes == 2) {
                for (var i = 0; i < _attributeButtons.length; i++) {
                    var button = _attributeButtons[i];
                    if (!button.selected) {
                        button.disabled = true;
                    }
                }
            }

        } else {
            _numAttributes -= 1;
            if (_numAttributes == 1) {
                for (var i = 0; i < _attributeButtons.length; i++) {
                    _attributeButtons[i].disabled = false;
                }
            }
        }

        attributes_si.gotoAndStop(_numAttributes + 1);
    }

    private function handleSkillPress(a_event:Object) {
        if (a_event.target.selected) {
            _numSkills += 1;
            if (_numSkills == 8) {
                for (var i = 0; i < _skillButtons.length; i++) {
                    var button = _skillButtons[i];
                    if (!button.selected) {
                        button.disabled = true;
                    }
                }
            }

        } else {
            _numSkills -= 1;
            if (_numSkills == 7) {
                for (var i = 0; i < _skillButtons.length; i++) {
                    _skillButtons[i].disabled = false;
                }
            }
        }

        skills_si.gotoAndStop(_numSkills + 1);
    }

    private function handleButtonHover(a_event:Object) {
        skill_art.gotoAndStop(a_event.target._name);
        skill_description.text = Translator.translate("$"+a_event.target._name.toUpperCase() + "_DESC");
    }

    private function setButtonText() {
        skill_description.text = "";
        class_description.text = ""; // todo: change to default

        acrobat.texts.textField.text = Translator.translate("$ACROBAT");
        agent.texts.textField.text = Translator.translate("$AGENT");
        archer.texts.textField.text = Translator.translate("$ARCHER");
        assassin.texts.textField.text = Translator.translate("$ASSASSIN");
        barbarian.texts.textField.text = Translator.translate("$BARBARIAN");
        bard.texts.textField.text = Translator.translate("$BARD");
        battlemage.texts.textField.text = Translator.translate("$BATTLEMAGE");
        crusader.texts.textField.text = Translator.translate("$CRUSADER");
        healer.texts.textField.text = Translator.translate("$HEALER");
        knight.texts.textField.text = Translator.translate("$KNIGHT");
        mage.texts.textField.text = Translator.translate("$MAGE");
        monk.texts.textField.text = Translator.translate("$MONK");
        nightblade.texts.textField.text = Translator.translate("$NIGHTBLADE");
        pilgrim.texts.textField.text = Translator.translate("$PILGRIM");
        rogue.texts.textField.text = Translator.translate("$ROGUE");
        scout.texts.textField.text = Translator.translate("$SCOUT");
        sorcerer.texts.textField.text = Translator.translate("$SORCERER");
        spellsword.texts.textField.text = Translator.translate("$SPELLSWORD");
        thief.texts.textField.text = Translator.translate("$THIEF");
        warrior.texts.textField.text = Translator.translate("$WARRIOR");
        witchhunter.texts.textField.text = Translator.translate("$WITCHHUNTER");
        custom.texts.textField.text = Translator.translate("$CUSTOM");

        specWarrior.texts.textField.autoSize = "center";
        specMage.texts.textField.autoSize = "center";
        specThief.texts.textField.autoSize = "center";
        specWarrior.texts.textField.text = Translator.translate("$WARRIOR");
        specMage.texts.textField.text = Translator.translate("$MAGE");
        specThief.texts.textField.text = Translator.translate("$THIEF");

        // attributes
        agility.texts.textField.text = Translator.translate("$AGILITY");
        endurance.texts.textField.text = Translator.translate("$ENDURANCE");
        intelligence.texts.textField.text = Translator.translate("$INTELLIGENCE");
        luck.texts.textField.text = Translator.translate("$LUCK");
        personality.texts.textField.text = Translator.translate("$PERSONALITY");
        speed.texts.textField.text = Translator.translate("$SPEED");
        strength.texts.textField.text = Translator.translate("$STRENGTH");
        willpower.texts.textField.text = Translator.translate("$WILLPOWER");
        // warrior skills
        armorer.texts.textField.text = Translator.translate("$ARMORER");
        athletics.texts.textField.text = Translator.translate("$ATHLETICS");
        axe.texts.textField.text = Translator.translate("$AXE");
        block.texts.textField.text = Translator.translate("$BLOCK");
        blunt_weapon.texts.textField.text = Translator.translate("$BLUNT_WEAPON");
        heavy_armor.texts.textField.text = Translator.translate("$HEAVY_ARMOR");
        long_blade.texts.textField.text = Translator.translate("$LONG_BLADE");
        medium_armor.texts.textField.text = Translator.translate("$MEDIUM_ARMOR");
        polearm.texts.textField.text = Translator.translate("$POLEARM");
        // mage skills
        alchemy.texts.textField.text = Translator.translate("$ALCHEMY");
        alteration.texts.textField.text = Translator.translate("$ALTERATION");
        conjuration.texts.textField.text = Translator.translate("$CONJURATION");
        destruction.texts.textField.text = Translator.translate("$DESTRUCTION");
        enchant.texts.textField.text = Translator.translate("$ENCHANT");
        illusion.texts.textField.text = Translator.translate("$ILLUSION");
        mysticism.texts.textField.text = Translator.translate("$MYSTICISM");
        restoration.texts.textField.text = Translator.translate("$RESTORATION");
        unarmored.texts.textField.text = Translator.translate("$UNARMORED");
        // thief skills
        acrobatics.texts.textField.text = Translator.translate("$ACROBATICS");
        hand_to_hand.texts.textField.text = Translator.translate("$HAND_TO_HAND");
        light_armor.texts.textField.text = Translator.translate("$LIGHT_ARMOR");
        marksman.texts.textField.text = Translator.translate("$MARKSMAN");
        mercantile.texts.textField.text = Translator.translate("$MERCANTILE");
        security.texts.textField.text = Translator.translate("$SECURITY");
        short_blade.texts.textField.text = Translator.translate("$SHORT_BLADE");
        sneak.texts.textField.text = Translator.translate("$SNEAK");
        speechcraft.texts.textField.text = Translator.translate("$SPEECHCRAFT");
    }

}
