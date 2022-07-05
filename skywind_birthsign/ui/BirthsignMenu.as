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

class BirthsignMenu extends MovieClip {
    /* PRIVATE VARIABLES */
    // birthsign selection buttons
    private var apprentice:Button;
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
    private var buff_desc1:MovieClip;
    private var buff_desc2:MovieClip;
    private var buff_desc3:MovieClip;

    /* INITIALIZATION */
    public function BirthsignMenu() {
        super();
        EventDispatcher.initialize(this);
    }

    public function onLoad():Void {
        if (apprentice != undefined) {
            apprentice.addEventListener(EventTypes.CLICK, this, "handleApprenticePress");
        } else {
            log("could not get apprentice");
        }
        if (atronach != undefined) {
            atronach.addEventListener(EventTypes.CLICK, this, "handleAtronachPress");
        } else {
            log("could not get atronach");
        }
        if (ritual != undefined) {
            ritual.addEventListener(EventTypes.CLICK, this, "handleRitualPress");
        } else {
            log("could not get ritual");
        }
        if (mage != undefined) {
            mage.addEventListener(EventTypes.CLICK, this, "handleMagePress");
        } else {
            log("could not get mage");
        }
        if (lady != undefined) {
            lady.addEventListener(EventTypes.CLICK, this, "handleLadyPress");
        } else {
            log("could not get lady");
        }
        if (lord != undefined) {
            lord.addEventListener(EventTypes.CLICK, this, "handleLordPress");
        } else {
            log("could not get lord");
        }
        if (steed != undefined) {
            steed.addEventListener(EventTypes.CLICK, this, "handleSteedPress");
        } else {
            log("could not get steed");
        }
        if (warrior != undefined) {
            warrior.addEventListener(EventTypes.CLICK, this, "handleWarriorPress");
        } else {
            log("could not get warrior");
        }
        if (serpent != undefined) {
            serpent.addEventListener(EventTypes.CLICK, this, "handleSerpentPress");
        } else {
            log("could not get serpent");
        }
        if (lover != undefined) {
            lover.addEventListener(EventTypes.CLICK, this, "handleLoverPress");
        } else {
            log("could not get lover");
        }
        if (shadow != undefined) {
            shadow.addEventListener(EventTypes.CLICK, this, "handleShadowPress");
        } else {
            log("could not get shadow");
        }
        if (tower != undefined) {
            tower.addEventListener(EventTypes.CLICK, this, "handleTowerPress");
        } else {
            log("could not get tower");
        }
        if (thief != undefined) {
            thief.addEventListener(EventTypes.CLICK, this, "handleThiefPress");
        } else {
            log("could not get thief");
        }
        if (tip_button != undefined) {
            tip_button.addEventListener(EventTypes.CLICK, this, "handleTipPress");
        } else {
            log("could not get tip button");
        }
        if (proceed_button != undefined) {
            proceed_button.addEventListener(EventTypes.CLICK, this, "handleProceedPress");
        } else {
            log("could not get proceed button");
        }

        if (buff_desc1 != undefined) {
            buff_desc1.gotoAndStop("disabled");
        }
        if (buff_desc2 != undefined) {
            buff_desc2.gotoAndStop("disabled");
        }
        if (buff_desc3 != undefined) {
            buff_desc3.gotoAndStop("disabled");
        }

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
    private function handleApprenticePress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [0]);
    }
    private function handleAtronachPress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [1]);
    }
    private function handleRitualPress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [2]);
    }
    private function handleMagePress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [3]);
    }
    private function handleLadyPress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [4]);
    }
    private function handleLordPress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [5]);
    }
    private function handleSteedPress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [6]);
    }
    private function handleWarriorPress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [7]);
    }
    private function handleSerpentPress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [8]);
    }
    private function handleLoverPress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [9]);
    }
    private function handleShadowPress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [10]);
    }
    private function handleTowerPress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [11]);
    }
    private function handleThiefPress(a_event:Object):Void {
        GameDelegate.call("OnBirthsignPress", [12]);
    }
    private function handleTipPress(a_event:Object):Void {
        // GameDelegate.call("OnBirthsignPress", [11]);
    }
    private function handleProceedPress(a_event:Object):Void {
        GameDelegate.call("ConfirmSelection", []);
    }
    
    public function log(a_message:String):Void {
        GameDelegate.call("Log", [a_message]);
    }
}


