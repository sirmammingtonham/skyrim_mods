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
// writing for classes and skills

class ClassCreationMenu extends MovieClip {
    public static var SELECT = 0;
    public static var CREATE = 1;

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
    private var blade:ClassCreationButton;
    private var block:ClassCreationButton;
    private var blunt:ClassCreationButton;
    private var hand_to_hand:ClassCreationButton;
    private var heavy_armor:ClassCreationButton;
    private var armorer:ClassCreationButton;
    // mage skills
    private var alchemy:ClassCreationButton;
    private var alteration:ClassCreationButton;
    private var conjuration:ClassCreationButton;
    private var destruction:ClassCreationButton;
    private var illusion:ClassCreationButton;
    private var mysticism:ClassCreationButton;
    private var restoration:ClassCreationButton;
    // thief skills
    private var acrobatics:ClassCreationButton;
    private var light_armor:ClassCreationButton;
    private var marksman:ClassCreationButton;
    private var mercantile:ClassCreationButton;
    private var security:ClassCreationButton;
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
    // private var select_class:ClassCreationButton;
    // private var create_class:ClassCreationButton;

    private var attribute_indicator:MovieClip;
    private var skill_indicator:MovieClip;

    private var confirm:ClassCreationButton;

    private var class_art:MovieClip;
    private var class_description:ClassCreationTextInput;

    private var skill_art:MovieClip;
    private var skill_description:TextField;

    private var custom_class_header:TextField;
    private var custom_class_name:ClassCreationTextInput;

    private var _state:Object = new Object();

    /////
    private var _mode:Number = -1;
    private var _numAttributes:Number = 0;
    private var _numSkills:Number = 0;
    private var _classButtons:Array;
    private var _specButtons:Array;
    private var _attrButtons:Array;
    private var _skillButtons:Array;
    private var _stats:Array;
    private var _prevButtonHover:ClassCreationButton;
    private var _customDescriptionStorage:String;
    private var _customSelected:Array;

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
            blade,
            block,
            blunt,
            hand_to_hand,
            heavy_armor,
            armorer,
            alchemy,
            alteration,
            conjuration,
            destruction,
            illusion,
            mysticism,
            restoration,
            acrobatics,
            light_armor,
            marksman,
            mercantile,
            security,
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

        _root.select_class.addEventListener(EventTypes.SELECT, this, "handleSelectClassPress");
        _root.create_class.addEventListener(EventTypes.SELECT, this, "handleCreateClassPress");

        confirm.addEventListener(EventTypes.CLICK, this, "handleConfirmPress");
        confirm.disabled = true;

        _root.select_class.selected = true;
        _customDescriptionStorage = "";
        _customSelected = [];
    }

    public function InitExtensions():Void {
        super.InitExtensions();
    }

    public function handleInput(details:InputDetails, pathToFocus:Array):Boolean {
        return true;
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

    private function handleSelectClassPress(a_event:Object) {
        if (_mode == SELECT) {
            return;
        }
        _mode = SELECT;
        _customSelected = getSelected(true);
        _customDescriptionStorage = class_description.text;
        monk.selected = true; // select random class so we can reset if after create class (hacky but fuck you)
        acrobat.selected = true; // default

        for (var i = 0; i < _classButtons.length; i++) {
            _classButtons[i].disabled = false;
            _classButtons[i]._alpha = 100;
        }
        for (var i = 0; i < _specButtons.length; i++) {
            _specButtons[i].disabled = true;
        }
        for (var i = 0; i < _attrButtons.length; i++) {
            _attrButtons[i].disabled = true;
        }
        for (var i = 0; i < _skillButtons.length; i++) {
            _skillButtons[i].disabled = true;
        }

        custom_class_name.swapDepths(mage);
        class_description.disabled = true;
        custom_class_name.disabled = true;
        custom_class_header._alpha = 0.0;
        custom_class_name._alpha = 0.0;
        attribute_indicator._alpha = 70;
        skill_indicator._alpha = 70;
    }

    private function handleCreateClassPress(a_event:Object) {
        if (_mode == CREATE) {
            return;
        }
        _mode = CREATE;
        unselectAll();
        combat.selected = true;

        for (var i = 0; i < _classButtons.length; i++) {
            _classButtons[i].disabled = true;
            _classButtons[i]._alpha = 0.0;
        }
        for (var i = 0; i < _specButtons.length; i++) {
            _specButtons[i].disabled = false;
        }
        for (var i = 0; i < _attrButtons.length; i++) {
            _attrButtons[i].disabled = false;
        }
        for (var i = 0; i < _skillButtons.length; i++) {
            _skillButtons[i].disabled = false;
        }
        class_art.gotoAndStop("custom");
        class_description.text = _customDescriptionStorage;
        selectAll(_customSelected);

        custom_class_name.swapDepths(mage);
        class_description.disabled = false;
        custom_class_name.disabled = false;
        custom_class_header._alpha = 100;
        custom_class_name._alpha = 100;
        attribute_indicator._alpha = 100;
        skill_indicator._alpha = 100;

    }

    private function getSelected(return_names:Boolean):Array {
        var args:Array = [];
        for (var i = 0; i < _attrButtons.length; i++) {
            if (_attrButtons[i].selected) {
                if (return_names) {
                    args.push(_attrButtons[i]._name);
                } else {
                    args.push(i);
                }
            }
        }
        for (var i = 0; i < _specButtons.length; i++) {
            if (_specButtons[i].selected) {
                if (return_names) {
                    args.push(_specButtons[i]._name);
                } else {
                    args.push(i);
                }
            }
        }
        for (var i = 0; i < _skillButtons.length; i++) {
            if (_skillButtons[i].selected) {
                if (return_names) {
                    args.push(_skillButtons[i]._name);
                } else {
                    args.push(i);
                }
            }
        }
        return args;
    }

    private function handleConfirmPress(a_event:Object) {
        var args:Array = getSelected(false);
        if (_mode == SELECT) {
            for (var i = 0; i < _classButtons.length; i++) {
                if (_classButtons[i].selected) {
                    args.push(_classButtons[i]._name);
                    break;
                }
            }
            args.push(Translator.translate(class_description.textOrDefault));
        } else if (_mode == CREATE) {
            args.push(custom_class_name.textOrDefault)
            args.push(class_description.textOrDefault);
        }

        GameDelegate.call("OnConfirm", args);
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
            if (_mode == CREATE && _numAttributes == 2) {
                for (var i = 0; i < _attrButtons.length; i++) {
                    var button = _attrButtons[i];
                    if (!button.selected) {
                        button.disabled = true;
                    }
                }
            }
        } else {
            _numAttributes -= 1;
            if (_mode == CREATE && _numAttributes == 1) {
                for (var i = 0; i < _attrButtons.length; i++) {
                    _attrButtons[i].disabled = false;
                }
            }
        }

        attribute_indicator.gotoAndStop(_numAttributes + 1);
        calculateBonuses();
    }

    private function handleSkillPress(a_event:Object) {
        if (a_event.target.selected) {
            _numSkills += 1;
            if (_mode == CREATE && _numSkills == 7) {
                for (var i = 0; i < _skillButtons.length; i++) {
                    var button = _skillButtons[i];
                    if (!button.selected) {
                        button.disabled = true;
                    }
                }
            }
        } else {
            _numSkills -= 1;
            if (_mode == CREATE && _numSkills == 6) {
                for (var i = 0; i < _skillButtons.length; i++) {
                    _skillButtons[i].disabled = false;
                }
            }
        }

        skill_indicator.gotoAndStop(_numSkills + 1);
        calculateBonuses();
    }

    private function handleButtonHover(a_event:Object) {
        skill_art.gotoAndStop(a_event.target._name);
        skill_description.text = "$" + a_event.target._name.toUpperCase() + "_DESC";

        a_event.target.showFrame = true;
        if (_prevButtonHover != undefined && _prevButtonHover != a_event.target) {
            _prevButtonHover.showFrame = false;
        }
        _prevButtonHover = a_event.target;
    }

    private function setButtonText() {
        _root.select_class.texts.textField.text = "$SELECT_CLASS";
        _root.create_class.texts.textField.text = "$CREATE_CLASS";
        skill_description.text = "$SKILL_DEFAULT_DESC";

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
    }

    private function calculateBonuses() {
        var state_copy = _clone(_state);
        var confirm_counter = 0;

        // add selected buttons
        for (var i in _attrButtons) {
            if (_attrButtons[i].selected) {
                state_copy[_attrButtons[i]._name] += 10;
                confirm_counter++;
            }
        }
        for (var i in _skillButtons) {
            if (_skillButtons[i].selected) {
                state_copy[_skillButtons[i]._name] += 10;
                confirm_counter++;
            }
        }

        // add bonus from specialization
        if (combat.selected) {
            for (var i = 0; i < 7; i++) {
                state_copy[_skillButtons[i]._name] += 5;
            }
            confirm_counter++;
        } else if (magic.selected) {
            for (var i = 7; i < 14; i++) {
                state_copy[_skillButtons[i]._name] += 5;
            }
            confirm_counter++;
        } else if (stealth.selected) {
            for (var i = 14; i < 21; i++) {
                state_copy[_skillButtons[i]._name] += 5;
            }
            confirm_counter++;
        }

        // update values on menu
        confirm.disabled = (confirm_counter != 10);
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
