import skyui.util.Debug;
import skyui.util.Translator;
import skyui.defines.Actor;

import Shared.GlobalFunc;
import gfx.controls.ScrollBar;
import gfx.io.GameDelegate;

class AvailableEffectsList extends Shared.BSScrollingList {

    var scrollbar:ScrollBar;

    public function AvailableEffectsList() {
        super();
        scrollbar.focusTarget = this;
    }

    // modified to allow for spacing between list elements
    public function UpdateList():Void {
        var iFirstItemy:Number = GetClipByIndex(0)._y;
        var iItemHeightSum:Number = 0;
        var iLastItemShownIndex:Number = 0;
        while (iLastItemShownIndex < iScrollPosition) {
            EntriesA[iLastItemShownIndex].clipIndex = undefined;
            ++iLastItemShownIndex;
        }
        iListItemsShown = 0;
        iLastItemShownIndex = iScrollPosition;
        var iOffset:Number = 0;
        while (iLastItemShownIndex < EntriesA.length && iListItemsShown < iMaxItemsShown && iItemHeightSum <= fListHeight) {
            var item:MovieClip = GetClipByIndex(iListItemsShown);
            SetEntry(item, EntriesA[iLastItemShownIndex]);
            EntriesA[iLastItemShownIndex].clipIndex = iListItemsShown;
            item.itemIndex = iLastItemShownIndex;

            item._y = iFirstItemy + iOffset;

            item._visible = true;

            iItemHeightSum += item._height;
            iOffset += item._height + 5; // bruteforced this value... it just works

            if (iItemHeightSum <= fListHeight && iListItemsShown < iMaxItemsShown)
                ++iListItemsShown;
            ++iLastItemShownIndex;
        }
        var iLastItemIndex:Number = iListItemsShown;
        while (iLastItemIndex < iMaxItemsShown) {
            GetClipByIndex(iLastItemIndex)._visible = false;
            ++iLastItemIndex;
        }
        if (ScrollUp != undefined)
            ScrollUp._visible = scrollPosition > 0;
        if (ScrollDown != undefined)
            ScrollDown._visible = scrollPosition < iMaxScrollPosition;
    }

    private function getIconLabel(a_entryObject:Object):Void {
        switch (a_entryObject.school) {
			case Actor.AV_ALTERATION:
				a_entryObject.iconLabel = "Alt";
				return;

			case Actor.AV_CONJURATION:
				a_entryObject.iconLabel = "Con";
				return;

			case Actor.AV_DESTRUCTION:
				a_entryObject.iconLabel = "Des";
				return;

			case Actor.AV_ILLUSION:
				a_entryObject.iconLabel = "Ill";
				return;

			case Actor.AV_RESTORATION:
				a_entryObject.iconLabel = "Res";
				return;
            default:
                a_entryObject.iconLabel = "All";
                return;
        }
    }

    public function SetEntry(aEntryClip:MovieClip, aEntryObject:Object):Void {
        if (aEntryClip != undefined) {
            getIconLabel(aEntryObject);
            aEntryClip.effectIcon.gotoAndStop(aEntryObject.iconLabel);

            if (aEntryObject == selectedEntry) {
                aEntryClip.gotoAndStop("Hover");
                (new Color(aEntryClip.effectIcon)).setRGB(0xFFFFFF);
                (new Color(aEntryClip.check)).setRGB(0xFFFFFF);
                aEntryClip.textField.textColor = 0xFFFFFF;
            } else {
                aEntryClip.gotoAndStop("Normal");
                (new Color(aEntryClip.effectIcon)).setRGB(0xF9EDD5);
                (new Color(aEntryClip.check)).setRGB(0xF9EDD5);
                aEntryClip.textField.textColor = 0xF9EDD5;
            }
            if (aEntryObject.selected) {
                aEntryClip.check.gotoAndStop(2);
                aEntryClip.select._visible = true;
            } else {
                aEntryClip.check.gotoAndStop(1);
                aEntryClip.select._visible = false;
            }
            SetEntryText(aEntryClip, aEntryObject);
        }
    }

    public function SetEntryText(aEntryClip:MovieClip, aEntryObject:Object):Void {
        if (aEntryClip.textField != undefined) {
            if (textOption == Shared.BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT)
                aEntryClip.textField.textAutoSize = "shrink";
            else if (textOption == Shared.BSScrollingList.TEXT_OPTION_MULTILINE)
                aEntryClip.textField.verticalAutoSize = "top";
            if (aEntryObject.effectName == undefined)
                aEntryClip.textField.text = " ";
            else
                aEntryClip.textField.text = aEntryObject.effectName;
            if (aEntryObject.enabled != undefined)
                aEntryClip.textField.textColor = aEntryObject.enabled == false ? 0x998D7D : 0xF9EDD5;
            if (aEntryObject.disabled != undefined)
                aEntryClip.textField.textColor = aEntryObject.disabled == true ? 0x998D7D : 0xF9EDD5;
        }
    }

    public function set dataProvider(elements:Array):Void {
        this.ClearList();
        this.scrollPosition = 0;
        this.selectedIndex = -1;
        for (var i:Number = 0; i < elements.length; i++) {
            // this.entryList.push({text: elements[i]});
            this.entryList.push(elements[i]);
        }
        this.InvalidateData();
    }

}
