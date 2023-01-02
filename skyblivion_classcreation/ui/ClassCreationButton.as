import gfx.controls.Button;

class ClassCreationButton extends Button {
    public var hoverTip:Boolean;
    public var texts:MovieClip;
    public var frame:MovieClip;

    private var _value:Number = 0;

    public function ClassCreationButton() {
        super();
        frame._alpha = 0;
        disableFocus = false;
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

    public function set showFrame(yes:Boolean) {
        if (yes) {
            frame._alpha = 100;
        } else {
            frame._alpha = 0;
        }
    }

    // override
    private function handleMouseRollOver(controllerIdx:Number):Void {
        if (!_disabled) {
            if ((!_focused && !_displayFocus) || focusIndicator != null) {
                setState("over"); // Otherwise it is focused, and has no focusIndicator, so do nothing.
                if (!hoverTip) {
                    frame._alpha = 100;
                }
            }
        }

        dispatchEventAndSound({type: "rollOver", controllerIdx: controllerIdx});
    }

    private function handleMouseRollOut(controllerIdx:Number):Void {
        if (!_disabled) {
            if ((!_focused && !_displayFocus) || focusIndicator != null) {
                setState("out"); // Otherwise it is focused, and has no focusIndicator, so do nothing.
                if (!hoverTip) {
                    frame._alpha = 0;
                }
            }
        }

        dispatchEventAndSound({type: "rollOut", controllerIdx: controllerIdx});
    }

    private function _update() {
        texts.valueField.text = _value.toString();
    }
}
