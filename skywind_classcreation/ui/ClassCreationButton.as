import gfx.controls.Button;

class ClassCreationButton extends Button {
    public var bgType:String;
    public var bg:MovieClip;
    public var texts:MovieClip;

    private var _value:Number = 0;

    public function ClassCreationButton() {
        super();
        disableFocus = true;
        bg.gotoAndStop(bgType);
        _update();
    }

    public function get value() {
        return _value;
    }

    public function set value(value:Number) {
        _value = value;
        _update();
    }

    // public function simulateClick() {
    //     // handleMousePress();
    //     // handleMouseRelease();
    //     selected = true;
    // }

    private function _update() {
        texts.valueField.text = _value.toString();
    }
}
