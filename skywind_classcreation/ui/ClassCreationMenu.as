import gfx.controls.Button;
import gfx.controls.TextInput;
import gfx.controls.TextArea;
import gfx.io.GameDelegate;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import Shared.GlobalFunc;
import skyui.defines.Input;
import skyui.util.Translator;

import gfx.events.EventDispatcher;
import gfx.events.EventTypes;

// last todo:
// add remaining art once finished
// writing for classes and skills

class ClassCreationMenu extends MovieClip {
    public static var QUIZ = 0;
    public static var LIST = 1;
    public static var CUSTOM = 2;

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

    // specialization
    private var combat:ClassCreationButton;
    private var magic:ClassCreationButton;
    private var stealth:ClassCreationButton;

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

    // stats
    private var health:MovieClip;
    private var magicka:MovieClip;
    private var stamina:MovieClip;
    private var health_regen:MovieClip;
    private var magicka_regen:MovieClip;
    private var stamina_regen:MovieClip;
    private var carry_weight:MovieClip;

    // other stuff
    private var title:MovieClip;
    private var attributes_si:MovieClip;
    private var skills_si:MovieClip;

    private var proceed:ClassCreationButton;
    private var back:ClassCreationButton;

    private var class_art:MovieClip;
    private var class_description:ClassCreationTextInput;
    private var custom:ClassCreationTextInput;

    private var skill_art:MovieClip;
    private var skill_description:TextField;

    private var _state:Object = new Object();

    /////
    private var _mode:Number = 2;
    private var _numAttributes:Number = 0;
    private var _numSkills:Number = 0;
    private var _classButtons:Array;
    private var _specButtons:Array;
    private var _attrButtons:Array;
    private var _skillButtons:Array;
    private var _stats:Array;

    /////

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
        _specButtons = [combat, magic, stealth];
        _attrButtons = [agility,
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
        _stats = [health,
            magicka,
            stamina,
            health_regen,
            magicka_regen,
            stamina_regen,
            carry_weight];
    }

    public function onLoad():Void {
        super.onLoad();
        GameDelegate.addCallBack("SetInfo", this, "SetInfo");
        GameDelegate.addCallBack("SetMode", this, "SetMode");

        // SetMode(QUIZ);
        // SetMode(-1);
        // SetMode(-2);

        this.setButtonText();

        for (var i = 0; i < _classButtons.length; i++) {
            _classButtons[i].addEventListener(EventTypes.SELECT, this, "handleClassPress");
        }

        for (var i = 0; i < _specButtons.length; i++) {
            _specButtons[i].addEventListener(EventTypes.SELECT, this, "handleSpecializationPress");
                // _specButtons[i].addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        }

        for (var i = 0; i < _attrButtons.length; i++) {
            _attrButtons[i].addEventListener(EventTypes.SELECT, this, "handleAttributePress");
            _attrButtons[i].addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        }

        for (var i = 0; i < _skillButtons.length; i++) {
            _skillButtons[i].addEventListener(EventTypes.SELECT, this, "handleSkillPress");
            _skillButtons[i].addEventListener(EventTypes.ROLL_OVER, this, "handleButtonHover");
        }

        ///
        proceed.addEventListener(EventTypes.CLICK, this, "handleProceedPress");
        back.addEventListener(EventTypes.CLICK, this, "handleBackPress");

        proceed.disabled = true;
    }

    public function InitExtensions():Void {
        super.InitExtensions();
    }

    public function handleInput(details:InputDetails, pathToFocus:Array):Boolean {
        return true;
    }

    public function SetMode(x:Number) {
        if (x == -2) {
            _mode = CUSTOM;
        } else if (x == -1) {
            _mode = LIST;
            acrobat.selected = true; // default value
        } else {
            _mode = QUIZ;
            _classButtons[x].selected = true;
        }
        setTitle(x);

        for (var i = 0; i < _classButtons.length; i++) {
            _classButtons[i].disabled = (_mode != LIST);
        }
        for (var i = 0; i < _specButtons.length; i++) {
            _specButtons[i].disabled = (_mode != CUSTOM);
        }
        for (var i = 0; i < _attrButtons.length; i++) {
            _attrButtons[i].disabled = (_mode != CUSTOM);
        }
        for (var i = 0; i < _skillButtons.length; i++) {
            _skillButtons[i].disabled = (_mode != CUSTOM);
        }

        // allow text editing and set class button visibility
        if (_mode == CUSTOM) {
            for (var i = 0; i < _classButtons.length; i++) {
                _classButtons[i]._alpha = 0.0;
            }
            class_art.gotoAndStop("custom");
        } else {
            class_description.disabled = true;
            custom.swapDepths(acrobat);
            custom.disabled = true;
            custom._alpha = 0.0;
            attributes_si._alpha = 70;
            skills_si._alpha = 70;
        }
    }

    private function SetInfo(statsArg:Object, attrArg:Object, skillArg:Object) {
        // sets the initial info
        for (var i = 0; i < _stats.length; i++) {
            _state[_stats[i]._name] = Math.round(statsArg[_stats[i]._name]);
            if (i >= 3 && i <= 5) {
                _state[_stats[i]._name] += "/s"
            }
        }
        for (var i = 0; i < _attrButtons.length; i++) {
            _state[_attrButtons[i]._name] = attrArg[_attrButtons[i]._name];
        }
        for (var i = 0; i < _skillButtons.length; i++) {
            _state[_skillButtons[i]._name] = skillArg[_skillButtons[i]._name];
        }

        calculateBonuses();
    }

    private function handleProceedPress(a_event:Object) {
        if (_mode == QUIZ) {
            GameDelegate.call("OnProceedQuiz", []);
            return;
        }

        if (_mode == LIST) {
            for (var i = 0; i < _classButtons.length; i++) {
                if (_classButtons[i].selected) {
                    GameDelegate.call("OnProceedList", [i]);
                    return;
                }
            }
        }

        if (_mode == CUSTOM) {
            var args:Array = [];
            for (var i = 0; i < _attrButtons.length; i++) {
                if (_attrButtons[i].selected) {
                    args.push(i);
                }
            }
            for (var i = 0; i < _specButtons.length; i++) {
                if (_specButtons[i].selected) {
                    args.push(i);
                }
            }
            for (var i = 0; i < _skillButtons.length; i++) {
                if (_skillButtons[i].selected) {
                    args.push(i);
                }
            }
            args.push(custom.textOrDefault)
            args.push(class_description.textOrDefault)

            GameDelegate.call("OnProceedCustom", args);
            return;
        }
    }

    private function handleBackPress(a_event:Object) {
        GameDelegate.call("OnBack", []);
    }

    private function handleClassPress(a_event:Object) {
        unselectAll();
        selectAll(ClassMenuPresets[a_event.target._name]);

        class_art.gotoAndStop(a_event.target._name);
        class_description.text = "$" + a_event.target._name.toUpperCase() + "_DESC";
    }

    private function handleSpecializationPress(a_event:Object) {
        calculateBonuses();
    }

    private function handleAttributePress(a_event:Object) {
        if (a_event.target.selected) {
            _numAttributes += 1;
            if (_mode == CUSTOM && _numAttributes == 2) {
                for (var i = 0; i < _attrButtons.length; i++) {
                    var button = _attrButtons[i];
                    if (!button.selected) {
                        button.disabled = true;
                    }
                }
            }
        } else {
            _numAttributes -= 1;
            if (_mode == CUSTOM && _numAttributes == 1) {
                for (var i = 0; i < _attrButtons.length; i++) {
                    _attrButtons[i].disabled = false;
                }
            }
        }

        attributes_si.gotoAndStop(_numAttributes + 1);
        calculateBonuses();
    }

    private function handleSkillPress(a_event:Object) {
        if (a_event.target.selected) {
            _numSkills += 1;
            if (_mode == CUSTOM && _numSkills == 9) {
                for (var i = 0; i < _skillButtons.length; i++) {
                    var button = _skillButtons[i];
                    if (!button.selected) {
                        button.disabled = true;
                    }
                }
            }
        } else {
            _numSkills -= 1;
            if (_mode == CUSTOM && _numSkills == 8) {
                for (var i = 0; i < _skillButtons.length; i++) {
                    _skillButtons[i].disabled = false;
                }
            }
        }

        skills_si.gotoAndStop(_numSkills + 1);
        calculateBonuses();
    }

    private function handleButtonHover(a_event:Object) {
        skill_art.gotoAndStop(a_event.target._name);
        skill_description.text = "$" + a_event.target._name.toUpperCase() + "_DESC";
    }

    private function setButtonText() {
        skill_description.text = ""; // todo: change to default

        for (var i = 0; i < _classButtons.length; i++) {
            _classButtons[i].texts.textField.text = "$" + _classButtons[i]._name.toUpperCase();
        }

        for (var i = 0; i < _attrButtons.length; i++) {
            _attrButtons[i].texts.textField.text = toTitleCase(Translator.translate("$" + _attrButtons[i]._name.toUpperCase()));
        }

        for (var i = 0; i < _specButtons.length; i++) {
            _specButtons[i].texts.textField.text = toTitleCase(Translator.translate("$" + _specButtons[i]._name.toUpperCase()));
            _specButtons[i].texts.textField.autoSize = "center";
        }


        for (var i = 0; i < _skillButtons.length; i++) {
            _skillButtons[i].texts.textField.text = "$" + _skillButtons[i]._name.toUpperCase();
        }

        for (var i = 0; i < _stats.length; i++) {
            _stats[i].textField.text = toTitleCase(Translator.translate("$" + _stats[i]._name.toUpperCase()));
        }

        back.texts.textField.text = "$BACK";
        proceed.texts.textField.text = "$PROCEED";
    }

    private function setTitle(quizClass:Number) {
        if (_mode == QUIZ) {
            title.gotoAndStop("quiz");
            title.textField.text = Translator.translate("$CLASS_QUIZ_TITLE") + " " + Translator.translate(_classButtons[quizClass]._name).toUpperCase();
        } else if (_mode == LIST) {
            title.gotoAndStop("list");
            title.textField.text = "$CLASS_LIST_TITLE";
        } else if (_mode == CUSTOM) {
            title.gotoAndStop("custom");
            title.textField.text = "$CLASS_CUSTOM_TITLE";
        }
    }

    private function calculateBonuses() {
        var state_copy = _clone(_state);
        var proceed_counter = 0;

        // add selected buttons
        for (var i in _attrButtons) {
            if (_attrButtons[i].selected) {
                state_copy[_attrButtons[i]._name] += 10;
                proceed_counter++;
            }
        }
        for (var i in _skillButtons) {
            if (_skillButtons[i].selected) {
                state_copy[_skillButtons[i]._name] += 10;
                proceed_counter++;
            }
        }

        // add bonus from specialization
        if (combat.selected) {
            for (var i = 0; i < 9; i++) {
                state_copy[_skillButtons[i]._name] += 5;
            }
            proceed_counter++;
        } else if (magic.selected) {
            for (var i = 9; i < 18; i++) {
                state_copy[_skillButtons[i]._name] += 5;
            }
            proceed_counter++;
        } else if (stealth.selected) {
            for (var i = 18; i < 27; i++) {
                state_copy[_skillButtons[i]._name] += 5;
            }
            proceed_counter++;
        }

        // update values on menu
        proceed.disabled = (proceed_counter != 12);
        for (var name in state_copy) {
            this[name].value = state_copy[name];
        }
        for (var i in _stats) {
            var name = _stats[i]._name;
            this[name].valueField.text = state_copy[name];
        }
    }

    private function selectAll(buttons:Array) {
        for (var i = 0; i < buttons.length; i++) {
            this[buttons[i]].selected = true;
        }
    }

    private function unselectAll() {
        // might be a more efficient way but fuck it :)
        for (var i = 0; i < _attrButtons.length; i++) {
            if (_attrButtons[i].selected) {
                _attrButtons[i].selected = false;
            }
        }
        for (var i = 0; i < _skillButtons.length; i++) {
            if (_skillButtons[i].selected) {
                _skillButtons[i].selected = false;
            }
        }
    }


    private function toTitleCase(str:String):String {
        var arr = str.split(" ");
        for (var i = 0; i < arr.length; i++) {
            arr[i] = arr[i].substr(0, 1).toUpperCase() + arr[i].substr(1).toLowerCase();
        }
        return arr.join(" ");
    }

    private function _clone(obj:Object) {
        if (obj instanceof Array) {
            var t = [];
            for (var i = 0; i < obj.length; i++) {
                t[i] = (typeof(obj[i]) == "object") ? _clone(obj[i]) : obj[i];
            }
        } else if (obj instanceof Date) {
            var t = new Date(obj.getTime());
        } else if (obj instanceof XML || obj instanceof MovieClip) {
            // can't clone obj so return null
            var t = null;
            trace("Object.clone won't work on MovieClip or XML");
        } else {
            var t = {};
            for (var i in obj) {
                t[i] = (typeof(obj[i]) == "object") ? _clone(obj[i]) : obj[i];
            }
        }
        return (t);
    }
}
