import skyui.util.Debug;
import skyui.util.Translator;
import skyui.defines.Actor;

import Shared.GlobalFunc;
import gfx.io.GameDelegate;

class EffectsList extends Shared.BSScrollingList {

    public function EffectsList() {
        super();
    }

    public function set scrollBar(dummy:Object):Void {

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
            iOffset += item._height + 10; // bruteforced this value... it just works

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

    public function SetEntryText(aEntryClip:MovieClip, aEntryObject:Object):Void {
        // for (var id:String in aEntryObject) {
        //     var value:Object = aEntryObject[id];
        //     GameDelegate.call("Log", [id + " = " + value]);
        // }

        if (aEntryClip.textField != undefined) {
            aEntryClip.textField.autoSize = "left";
            aEntryClip.textField.wordWrap = true;
            aEntryClip.icon.gotoAndStop(aEntryObject["icon"]);
            var type = Translator.translate(aEntryObject["type"]);
            var name = Translator.translate("$" + aEntryObject["sign"] + "_AB" + aEntryObject["idx"] + "_NAME");
            var desc = Translator.translate("$" + aEntryObject["sign"] + "_AB" + aEntryObject["idx"] + "_DESC");
            aEntryClip.textField.text = type + ": " + name + " - " + desc;
        }
    }

    public function set dataProvider(data:Object):Void {
        this.ClearList();
        this.scrollPosition = 0;
        this.selectedIndex = -1;


        var sign = data.sign;
        var abilities = data.abilities;

        for (var i:Number = 0; i < abilities.length; i++) {
            this.entryList.push({sign: sign, idx: i, icon: abilities[i]["icon"], type: abilities[i]["type"]});
        }
        this.InvalidateData();
    }

}
