import gfx.controls.TextInput;
import gfx.io.GameDelegate;
import skyui.util.Translator;

class ClassCreationTextInput extends TextInput {
    private var _textFormat:TextFormat; // save original text format because scaleform shit in skyrim never work as expected so i have to restore the fucking original color and remove default text manually
    private var bg:MovieClip;

    public function ClassCreationTextInput() {
        super();
        _textFormat = textField.getNewTextFormat();
        _textFormat.italic = false;
        _textFormat.color = 0xe9c785;

        if (bg != undefined) {
            bg.onRollOver = handleBGRollOver;
        }
    }

    private function changeFocus():Void {
        super.changeFocus();
        if (_focused) {
            if (textField.text == Translator.translate(defaultText)) {
                textField.setTextFormat(_textFormat);
                this.text = "";
            }
        }
    }

    private function handleBGRollOver(controllerIdx:Number):Void {
		// dispatching an event here doesnt seem to work... i hate flash
		_parent._parent.skill_art.gotoAndStop("custom");
        _parent._parent.skill_description.text = "$CUSTOM_DESC";
    }

    // override
    private function updateText():Void {
        if (_text != "") {
            if (isHtml) {
                textField.html = true;
                textField.htmlText = _text;
            } else {
                textField.html = false;
                textField.text = _text;
            }
            textField.setTextFormat(_textFormat);
        } else {
            textField.text = "";
            if (!_focused && defaultText != "") {
                textField.text = defaultText;
                textField.setTextFormat(defaultTextFormat);
            }
        }
    }
}
