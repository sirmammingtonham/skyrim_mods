import gfx.controls.TextInput;
import gfx.io.GameDelegate;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import Shared.GlobalFunc;
import skyui.defines.Input;
import skyui.util.Translator;
import skyui.components.MappedButton;

class NameMenu extends MovieClip {
    private var AcceptButton:MappedButton;
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

        AcceptButton.disabled = false;
        AcceptButton.visible = true;
        AcceptButton.textField.text = Translator.translate("$Accept");
        AcceptButton.addEventListener("click", this, "onAccept");
        TextInputInstance.maxChars = 26;
    }

    public function SetPlatform(aiPlatform:Number, abPS3Switch:Boolean):Void {
        AcceptButton.setPlatform(aiPlatform);
        AcceptButton.setButtonData({text: "$Accept", controls: aiPlatform == 0 ? Input.Enter : {keyCode: 276}});
    }

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
