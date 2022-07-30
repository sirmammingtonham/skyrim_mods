import gfx.controls.TextInput;
import gfx.controls.Button;
import gfx.io.GameDelegate;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import Shared.GlobalFunc;
import skyui.defines.Input;
import skyui.util.Translator;

class NameMenu extends MovieClip {
    private var ProceedButton:Button;
    private var TextInputInstance:TextInput;
    private var _isTyping:Boolean;

    public function NameMenu() {
        super();
    }

    public function onLoad():Void {
        super.onLoad();
        _isTyping = false;
    }

    public function InitExtensions():Void {
        super.InitExtensions();

        ProceedButton.disabled = false;
        ProceedButton.visible = true;
        ProceedButton.textField.text = Translator.translate("$Accept");
        ProceedButton.addEventListener("click", this, "onAccept");
        TextInputInstance.maxChars = 26;
    }

    // public function SetPlatform(aiPlatform:Number, abPS3Switch:Boolean):Void {
    //     ProceedButton.setPlatform(aiPlatform);
    //     ProceedButton.setButtonData({text: "$Accept", controls: aiPlatform == 0 ? Input.Enter : {keyCode: 276}});
    // }

    public function handleInput(details:InputDetails, pathToFocus:Array):Boolean {
        if (GlobalFunc.IsKeyPressed(details) && details.navEquivalent == NavigationCode.ENTER) {
            onAccept();
        }
        return true;
    }

    private function GetValidName():Boolean {
        return TextInputInstance.text.length > 0;
    }

    private function onAccept(event:Object):Void {
        if (GetValidName()) {
            GameDelegate.call("OnAccept", []);
        }
    }

}
