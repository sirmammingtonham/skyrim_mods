import gfx.io.GameDelegate;
import gfx.controls.TextInput;
import skyui.components.MappedButton;
import skyui.defines.Input;

class NameMenu extends MovieClip {
    // private var AcceptButton:MappedButton;
    // private var CancelButton:CrossPlatformButtons;
    private var TextInputInstance:TextInput;
    private var iPlatform:Number;

    public function NameMenu() {
        super();
    }

	public function onLoad():Void {
        // _root.title_header.text = "Wheheeeheheheh";

        // AcceptButton.visible = true;
		// AcceptButton.setButtonData({text: "$Accept", controls: Input.Accept});
		// AcceptButton.addEventListener("click", this, "onAccept");
        // // CancelButton.addEventListener(EventTypes.CLICK, this, "onCancel");
		// TextInputInstance.addEventListener("focusIn", this, "handleTextFocus");
        // TextInputInstance.addEventListener("focusOut", this, "handleTextUnfocus");
        // TextInputInstance.maxChars = 26;
		GameDelegate.call("Log", ["loaded"]);
	}

	public function InitExtensions():Void {

	}

    public function SetPlatform(aiPlatform:Number, abPS3Switch:Boolean):Void {
		GameDelegate.call("Log", ["in this shid"]);
        iPlatform = aiPlatform;
        // AcceptButton.setPlatform(aiPlatform, abPS3Switch);
    }

    private function GetValidName():Boolean {
        return TextInputInstance.text.length > 0;
    }

	private function handleTextFocus(a_event:Object):Void {
        GameDelegate.call("OnTextFocus", []);
    }

    private function handleTextUnfocus(a_event:Object):Void {
        // GameDelegate.call("OnTextUnfocus", []);
    }

    private function onAccept():Void {
        if (GetValidName()) {
			GameDelegate.call("OnAccept", []);
        }
    }

    // private function onCancel():Void {
	// 	GameDelegate.call("OnCancel", []);
    // }

}
