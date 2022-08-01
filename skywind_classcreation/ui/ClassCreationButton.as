import gfx.controls.Button;

class ClassCreationButton extends Button {
	public var bgType:String;
	public var bg: MovieClip;
	public var texts: MovieClip;

    public function ClassCreationButton() {
        super();
		bg.gotoAndStop(bgType);
    }

	public function simulateClick() {
        handleMousePress();
        handleMouseRelease();
    }
}
