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
    // private var custom:ClassCreationButton;

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
    private var athletics:ClassCreationButton;
    private var axe:ClassCreationButton;
    private var block:ClassCreationButton;
    private var blunt_weapon:ClassCreationButton;
    private var heavy_armor:ClassCreationButton;
    private var long_blade:ClassCreationButton;
    private var medium_armor:ClassCreationButton;
    private var polearms:ClassCreationButton;
    private var smithing:ClassCreationButton;
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
            witchhunter];
        _specializationButtons = [specWarrior, specMage, specThief];
        _attributeButtons = [agility,
            endurance,
            intelligence,
            luck,
            personality,
            speed,
            strength,
            willpower];
        _skillButtons = [athletics,
            axe,
            block,
            blunt_weapon,
            heavy_armor,
            long_blade,
            medium_armor,
            polearms,
            smithing,
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

        for (var i = 0; i < _classButtons.length; i++) {
            _classButtons[i].addEventListener(EventTypes.CLICK, this, "handleClassPress");
        }

        for (var i = 0; i < _specializationButtons.length; i++) {
            _specializationButtons[i].addEventListener(EventTypes.CLICK, this, "handleSpecializationPress");
            _specializationButtons[i].addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        }

        for (var i = 0; i < _attributeButtons.length; i++) {
            _attributeButtons[i].addEventListener(EventTypes.CLICK, this, "handleAttributePress");
            _attributeButtons[i].addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        }

        for (var i = 0; i < _skillButtons.length; i++) {
            _skillButtons[i].addEventListener(EventTypes.CLICK, this, "handleSkillPress");
            _skillButtons[i].addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        }

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
        unclickAll();
        switch (a_event.target) {
            case acrobat:  {
                clickAll([specThief, athletics, polearms, unarmored, acrobatics, hand_to_hand, light_armor, marksman, security, sneak, agility, endurance]);
                break;
            }
            case agent:  {
                clickAll([specThief, block, illusion, unarmored, acrobatics, light_armor, mercantile, short_blade, sneak, speechcraft, personality, agility]);
                break;
            }
            case archer:  {
                clickAll([specWarrior, athletics, block, long_blade, medium_armor, polearms, restoration, light_armor, marksman, sneak, agility, strength]);
                break;
            }
            case assassin:  {
                clickAll([specThief, athletics, block, alchemy, acrobatics, light_armor, marksman, security, short_blade, sneak, speed, intelligence]);
                break;
            }
            case barbarian:  {
                clickAll([specWarrior, athletics, axe, block, blunt_weapon, medium_armor, smithing, acrobatics, hand_to_hand, light_armor, strength, speed]);
                break;
            }
            case bard:  {
                clickAll([specThief, block, long_blade, medium_armor, alchemy, illusion, acrobatics, mercantile, security, speechcraft, personality, intelligence]);
                break;
            }
            case battlemage:  {
                clickAll([specMage, axe, blunt_weapon, heavy_armor, alteration, conjuration, destruction, enchant, mysticism, marksman, intelligence, strength]);
                break;
            }
            case crusader:  {
                clickAll([specWarrior, block, blunt_weapon, heavy_armor, long_blade, medium_armor, smithing, alchemy, destruction, restoration, agility, strength]);
                break;
            }
            case healer:  {
                clickAll([specMage, polearms, alchemy, alteration, illusion, mysticism, restoration, unarmored, hand_to_hand, speechcraft, willpower, personality]);
                break;
            }
            case knight:  {
                clickAll([specWarrior, axe, block, heavy_armor, long_blade, medium_armor, polearms, smithing, enchant, speechcraft, strength, personality]);
                break;
            }
            case mage:  {
                clickAll([specMage, alchemy, alteration, conjuration, destruction, enchant, illusion, mysticism, restoration, unarmored, intelligence, willpower]);
                break;
            }
            case monk:  {
                clickAll([specThief, athletics, polearms, restoration, unarmored, acrobatics, hand_to_hand, light_armor, marksman, sneak, agility, willpower]);
                break;
            }
            case nightblade:  {
                clickAll([specMage, alteration, destruction, illusion, mysticism, unarmored, light_armor, security, short_blade, sneak, willpower, speed]);
                break;
            }
            case pilgrim:  {
                clickAll([specThief, block, blunt_weapon, medium_armor, alchemy, restoration, marksman, mercantile, short_blade, speechcraft, personality, endurance]);
                break;
            }
            case rogue:  {
                clickAll([specWarrior, athletics, axe, block, long_blade, hand_to_hand, light_armor, mercantile, short_blade, speechcraft, speed, personality]);
                break;
            }
            case scout:  {
                clickAll([specWarrior, athletics, block, long_blade, medium_armor, alchemy, alteration, light_armor, marksman, sneak, speed, endurance]);
                break;
            }
            case sorcerer:  {
                clickAll([specMage, long_blade, medium_armor, alteration, conjuration, destruction, enchant, illusion, mysticism, short_blade, intelligence, endurance]);
                break;
            }
            case spellsword:  {
                clickAll([specMage, axe, block, long_blade, medium_armor, alchemy, alteration, destruction, enchant, restoration, willpower, endurance]);
                break;
            }
            case thief:  {
                clickAll([specThief, acrobatics, hand_to_hand, light_armor, marksman, mercantile, security, short_blade, sneak, speechcraft, speed, agility]);
                break;
            }
            case warrior:  {
                clickAll([specWarrior, athletics, axe, block, blunt_weapon, heavy_armor, long_blade, medium_armor, polearms, smithing, strength, endurance]);
                break;
            }
            case witchhunter:  {
                clickAll([specMage, blunt_weapon, alchemy, conjuration, enchant, illusion, mysticism, light_armor, marksman, sneak, intelligence, agility]);
                break;
            }
        }
        // a_event.target.disabled = true;
        class_art.gotoAndStop(a_event.target._name);
        class_description.text = Translator.translate("$" + a_event.target._name.toUpperCase() + "_DESC");
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
            if (_numSkills == 9) {
                for (var i = 0; i < _skillButtons.length; i++) {
                    var button = _skillButtons[i];
                    if (!button.selected) {
                        button.disabled = true;
                    }
                }
            }

        } else {
            _numSkills -= 1;
            if (_numSkills == 8) {
                for (var i = 0; i < _skillButtons.length; i++) {
                    _skillButtons[i].disabled = false;
                }
            }
        }

        skills_si.gotoAndStop(_numSkills + 1);
    }

    private function handleButtonHover(a_event:Object) {
        skill_art.gotoAndStop(a_event.target._name);
        skill_description.text = Translator.translate("$" + a_event.target._name.toUpperCase() + "_DESC");
    }

    private function setButtonText() {
        skill_description.text = "";
        class_description.text = ""; // todo: change to default

        for (var i = 0; i < _classButtons.length; i++) {
            _classButtons[i].texts.textField.text = Translator.translate("$" + _classButtons[i]._name.toUpperCase());
        }

        for (var i = 0; i < _attributeButtons.length; i++) {
            _attributeButtons[i].texts.textField.text = Translator.translate("$" + _attributeButtons[i]._name.toUpperCase());
        }

        for (var i = 0; i < _skillButtons.length; i++) {
            _skillButtons[i].texts.textField.text = Translator.translate("$" + _skillButtons[i]._name.toUpperCase());
        }


        specWarrior.texts.textField.autoSize = "center";
        specMage.texts.textField.autoSize = "center";
        specThief.texts.textField.autoSize = "center";
        specWarrior.texts.textField.text = Translator.translate("$WARRIOR");
        specMage.texts.textField.text = Translator.translate("$MAGE");
        specThief.texts.textField.text = Translator.translate("$THIEF");
    }

    private function clickAll(buttons:Array) {
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].simulateClick();
        }
    }

    private function unclickAll() {
        // might be a more efficient way but fuck it :)
        for (var i = 0; i < _attributeButtons.length; i++) {
            if (_attributeButtons[i].selected) {
                _attributeButtons[i].simulateClick();
            }
        }
        for (var i = 0; i < _skillButtons.length; i++) {
            if (_skillButtons[i].selected) {
                _skillButtons[i].simulateClick();
            }
        }
    }

    private function disableEdits() {

    }
}
