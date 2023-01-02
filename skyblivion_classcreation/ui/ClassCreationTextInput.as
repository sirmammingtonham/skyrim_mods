import gfx.controls.TextInput;
import gfx.io.GameDelegate;
import skyui.util.Translator;

class ClassCreationTextInput extends TextInput {
    private var _textFormat:TextFormat; // save original text format because scaleform shit in skyrim never work as expected so i have to restore the fucking original color and remove default text manually

    public function ClassCreationTextInput() {
        super();
        _textFormat = textField.getNewTextFormat();
        _textFormat.italic = false;
        _textFormat.color = 0xE2CEAA;
    }

    public function get textOrDefault() {
        if (text == "") {
            return defaultText;
        }
        return text;
    }

    private function changeFocus():Void {
        super.changeFocus();
        if (_focused) {
            if (textField.text == Translator.translate(defaultText)) {
                text = "";
            }
        }
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
        } else {
            textField.text = "";
            if (!_focused && defaultText != "") {
                textField.text = defaultText;
            }
        }

        if (textField.text == Translator.translate(defaultText)) {
            textField.setTextFormat(defaultTextFormat);
        } else { // idk why this doesnt update until focus is lost... did i mention i hate flash?
            textField.setTextFormat(_textFormat);
        }
    }
}
