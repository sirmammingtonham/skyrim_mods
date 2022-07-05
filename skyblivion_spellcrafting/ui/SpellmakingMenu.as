
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

class SpellmakingMenu extends MovieClip {
    /* PRIVATE VARIABLES */
    private var available_effects:MovieClip;
    private var magnitude_slider:Slider;
    private var duration_slider:Slider;
    private var area_slider:Slider;
    private var name:TextInput;
    private var craft:Button;
    private var icon_school:MovieClip;

    // range radios
    private var range_self:MovieClip;
    private var range_touch:MovieClip;
    private var range_area:MovieClip;
    private var type_fireforget:MovieClip;
    private var type_concentration:MovieClip;

    // filter buttons for available effects
    private var filter_all:Button;
    private var filter_alt:Button;
    private var filter_ill:Button;
    private var filter_dest:Button;
    private var filter_conj:Button;
    private var filter_rest:Button;
    private var filter_checked:Button;
    private var filter_selector:MovieClip; // bar at the bottom to indicate selection

    /* INITIALIZATION */

    public function SpellmakingMenu() {
        super();
        EventDispatcher.initialize(this);
    }


    public function onLoad():Void {
        available_effects.ClearList();
        available_effects.InvalidateData();

        if (available_effects != undefined) {
            available_effects.addEventListener(EventTypes.ITEM_PRESS, this, "handleAvailablePress");
            available_effects.addEventListener("itemPressAux", this, "handleAvailableAltPress");
        } else {
            log("could not get available");
        }

        if (magnitude_slider != undefined) {
            magnitude_slider.addEventListener(EventTypes.CHANGE, this, "handleMagnitudeChange");
            magnitude_slider.thumb.addEventListener(EventTypes.PRESS, this, "handleMagnitudeDragBegin");
            magnitude_slider.thumb.addEventListener(EventTypes.CLICK, this, "handleMagnitudeDragEnd");
            magnitude_slider.thumb.addEventListener(EventTypes.RELEASE_OUTSIDE, this, "handleMagnitudeDragEnd");
        } else {
            log("could not get magnitude");
        }

        if (duration_slider != undefined) {
            duration_slider.addEventListener(EventTypes.CHANGE, this, "handleDurationChange");
            duration_slider.thumb.addEventListener(EventTypes.PRESS, this, "handleDurationDragBegin");
            duration_slider.thumb.addEventListener(EventTypes.CLICK, this, "handleDurationDragEnd");
            duration_slider.thumb.addEventListener(EventTypes.RELEASE_OUTSIDE, this, "handleDurationDragEnd");
        } else {
            log("could not get duration");
        }

        if (area_slider != undefined) {
            area_slider.addEventListener(EventTypes.CHANGE, this, "handleAreaChange");
            area_slider.thumb.addEventListener(EventTypes.PRESS, this, "handleAreaDragBegin");
            area_slider.thumb.addEventListener(EventTypes.CLICK, this, "handleAreaDragEnd");
            area_slider.thumb.addEventListener(EventTypes.RELEASE_OUTSIDE, this, "handleAreaDragEnd");
        } else {
            log("could not get area");
        }

        if (name != undefined) {
            name.addEventListener("focusIn", this, "handleTextFocus");
            name.addEventListener("focusOut", this, "handleTextUnfocus");
        } else {
            log("could not get name");
        }

        if (craft != undefined) {
            craft.addEventListener(EventTypes.PRESS, this, "handleCraftPress");
        } else {
            log("could not get craft");
        }

        if (range_self != undefined) {
            range_self.addEventListener(EventTypes.PRESS, this, "handleRangeSelfPress");
            range_self.check.gotoAndStop(2);
        } else {
            log("could not get range_self");
        }
        if (range_touch != undefined) {
            range_touch.addEventListener(EventTypes.PRESS, this, "handleRangeTouchPress");
        } else {
            log("could not get range_touch");
        }
        if (range_area != undefined) {
            range_area.addEventListener(EventTypes.PRESS, this, "handleRangeAreaPress");
        } else {
            log("could not get range_area");
        }
        if (type_fireforget != undefined) {
            type_fireforget.addEventListener(EventTypes.PRESS, this, "handleTypeFFPress");
            type_fireforget.check.gotoAndStop(2);
        } else {
            log("could not get type_fireforget");
        }
        if (type_concentration != undefined) {
            type_concentration.addEventListener(EventTypes.PRESS, this, "handleTypeConcentrationPress");
        } else {
            log("could not get type_concentration");
        }

        // setup filter buttons
        if (filter_all != undefined) {
            filter_all.addEventListener(EventTypes.PRESS, this, "handleAllPress");
            var iconColor:Color = new Color(filter_all);
            iconColor.setRGB(0xFFFFFF);
        } else {
            log("could not get all filter");
        }

        if (filter_alt != undefined) {
            filter_alt.addEventListener(EventTypes.PRESS, this, "handleAlterationPress");
        } else {
            log("could not get alteration filter");
        }

        if (filter_ill != undefined) {
            filter_ill.addEventListener(EventTypes.PRESS, this, "handleIllusionPress");
        } else {
            log("could not get illusion filter");
        }

        if (filter_dest != undefined) {
            filter_dest.addEventListener(EventTypes.PRESS, this, "handleDestructionPress");
        } else {
            log("could not get destruction filter");
        }

        if (filter_conj != undefined) {
            filter_conj.addEventListener(EventTypes.PRESS, this, "handleConjurationPress");
        } else {
            log("could not get conjuration filter");
        }

        if (filter_rest != undefined) {
            filter_rest.addEventListener(EventTypes.PRESS, this, "handleRestorationPress");
        } else {
            log("could not get restoration filter");
        }

        if (filter_checked != undefined) {
            filter_checked.addEventListener(EventTypes.PRESS, this, "handleCheckedPress");
        } else {
            log("could not get checked filter");
        }

        if (filter_selector != undefined) {
            filter_selector.gotoAndStop(1);
        } else {
            log("could not get filter selector");
        }

        log("loaded");
    }

    public function handleInput(details:InputDetails, pathToFocus:Array):Boolean {
        var nextClip = pathToFocus.shift();

        if (nextClip.handleInput(details, pathToFocus)) {
            return true;
        }

        if (GlobalFunc.IsKeyPressed(details) && (details.navEquivalent == NavigationCode.TAB || details.navEquivalent == NavigationCode.SHIFT_TAB)) {
            GameDelegate.call("CloseMenu", []);
        }
        return true;
    }

    /* PRIVATE FUNCTIONS */
    private function handleCancelPress(a_event:Object):Void {
        GameDelegate.call("OnCancelPress", []);
    }

    private function handleRangeChange(a_event:Object):Void {
        GameDelegate.call("OnRangeChange", []);
    }

    private function handleTextFocus(a_event:Object):Void {
        GameDelegate.call("OnTextFocus", []);
    }

    private function handleTextUnfocus(a_event:Object):Void {
        GameDelegate.call("OnTextUnfocus", []);
    }

    private function handleAvailablePress(a_event:Object):Void {
        available_effects.entryList[a_event.index].selected = true;
        available_effects.InvalidateData();

        GameDelegate.call("OnAvailablePress", [a_event.entry.effectName, false]);
    }

    private function handleAvailableAltPress(a_event:Object):Void {
        available_effects.entryList[a_event.index].selected = false;
        available_effects.InvalidateData();

        GameDelegate.call("OnAvailablePress", [a_event.entry.effectName, true]);
    }

    private function handleMagnitudeChange(a_event:Object):Void {
        GameDelegate.call("OnMagnitudeChange", []);
    }


    private function handleMagnitudeDragBegin(a_event:Object):Void {
        GameDelegate.call("OnMagnitudeDragBegin", []);
    }


    private function handleMagnitudeDragEnd(a_event:Object):Void {
        GameDelegate.call("OnMagnitudeDragEnd", []);
    }


    private function handleDurationChange(a_event:Object):Void {
        GameDelegate.call("OnDurationChange", []);
    }


    private function handleDurationDragBegin(a_event:Object):Void {
        GameDelegate.call("OnDurationDragBegin", []);
    }


    private function handleDurationDragEnd(a_event:Object):Void {
        GameDelegate.call("OnDurationDragEnd", []);
    }


    private function handleAreaChange(a_event:Object):Void {
        GameDelegate.call("OnAreaChange", []);
    }


    private function handleAreaDragBegin(a_event:Object):Void {
        GameDelegate.call("OnAreaDragBegin", []);
    }


    private function handleAreaDragEnd(a_event:Object):Void {
        GameDelegate.call("OnAreaDragEnd", []);
    }


    private function handleCraftPress(a_event:Object):Void {
        GameDelegate.call("CraftSpell", []);
    }

    private function adjustFilterColors(a_idx:Number):Void {
        var filterClips:Array = [filter_all,
            filter_alt,
            filter_ill,
            filter_dest,
            filter_conj,
            filter_rest,
            filter_checked];

        for (var i:Number = 0; i <= 6; ++i) {
            if (i == a_idx) {
                var iconColor:Color = new Color(filterClips[i]);
                iconColor.setRGB(0xFFFFFF);
            } else {
                var iconColor:Color = new Color(filterClips[i]);
                iconColor.setRGB(0xE2CEAA);
            }
        }

        filter_selector.gotoAndStop(a_idx+1);
    }

    private function handleAllPress(a_event:Object):Void {
        adjustFilterColors(0);
        GameDelegate.call("OnFilterPress", [0]);
    }

    private function handleAlterationPress(a_event:Object):Void {
        adjustFilterColors(1);
        GameDelegate.call("OnFilterPress", [1]);
    }

    private function handleIllusionPress(a_event:Object):Void {
        adjustFilterColors(2);
        GameDelegate.call("OnFilterPress", [2]);
    }

    private function handleDestructionPress(a_event:Object):Void {
        adjustFilterColors(3);
        GameDelegate.call("OnFilterPress", [3]);
    }

    private function handleConjurationPress(a_event:Object):Void {
        adjustFilterColors(4);
        GameDelegate.call("OnFilterPress", [4]);
    }

    private function handleRestorationPress(a_event:Object):Void {
        adjustFilterColors(5);
        GameDelegate.call("OnFilterPress", [5]);
    }

    private function handleCheckedPress(a_event:Object):Void {
        adjustFilterColors(6);
        GameDelegate.call("OnFilterPress", [6]);
    }

    private function handleRangeSelfPress(a_event:Object):Void {
        range_self.check.gotoAndStop(2);
        range_touch.check.gotoAndStop(1);
        range_area.check.gotoAndStop(1);
        GameDelegate.call("OnRangePress", [0]);
    }

    private function handleRangeTouchPress(a_event:Object):Void {
        range_self.check.gotoAndStop(1);
        range_touch.check.gotoAndStop(2);
        range_area.check.gotoAndStop(1);
        GameDelegate.call("OnRangePress", [1]);
    }

    private function handleRangeAreaPress(a_event:Object):Void {
        range_self.check.gotoAndStop(1);
        range_touch.check.gotoAndStop(1);
        range_area.check.gotoAndStop(2);
        GameDelegate.call("OnRangePress", [2]);
    }

    private function handleTypeFFPress(a_event:Object):Void {
        type_fireforget.check.gotoAndStop(2);
        type_concentration.check.gotoAndStop(1);
        GameDelegate.call("OnTypePress", [0]);
    }

    private function handleTypeConcentrationPress(a_event:Object):Void {
        type_fireforget.check.gotoAndStop(1);
        type_concentration.check.gotoAndStop(2);
        GameDelegate.call("OnTypePress", [1]);
    }

    public function log(a_message:String):Void {
        GameDelegate.call("Log", [a_message]);
    }
}
