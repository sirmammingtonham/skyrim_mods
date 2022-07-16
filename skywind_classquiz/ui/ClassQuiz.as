import gfx.controls.Button;
import gfx.io.GameDelegate;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import Shared.GlobalFunc;
import skyui.defines.Input;
import skyui.util.Translator;

// todo: make button gray disable instead of invisible
// todo: formula for calculating class
// todo: add selector from messagebox for over/down frames
class ClassQuiz extends MovieClip {
    public var questionField:TextField;
    public var wdydField:TextField;
    public var indicator:MovieClip;
    public var forward_button:Button;
    public var backward_button:Button;
    public var choice1:Button;
    public var choice2:Button;
    public var choice3:Button;

    private var _questionIdx:Number;
    private var _answers:Array;

    private static var ys:Array = [84, 193, 306];
    public static var WARRIOR:Number = 0;
    public static var MAGE:Number = 1;
    public static var THIEF:Number = 2;

    public function ClassQuiz() {
        super();
    }

    public function onLoad():Void {
        super.onLoad();

        _questionIdx = 0;
        _answers = [null, null, null, null, null, null, null, null, null, null];

        forward_button.addEventListener("click", this, "onForward");
        backward_button.addEventListener("click", this, "onBackward");

        choice1.addEventListener("click", this, "onChoice1");
        choice2.addEventListener("click", this, "onChoice2");
        choice3.addEventListener("click", this, "onChoice3");


        wdydField.text = Translator.translate("$What do you do?");
        populateQuestions(0);
    }


    public function handleInput(details:InputDetails, pathToFocus:Array):Boolean {
        return true;
    }

    private function populateQuestions(offset:Number) {
        _questionIdx += offset;

        var prefix = "$ClassQuizQ" + _questionIdx;
        questionField.text = Translator.translate(prefix);
        prefix += "R"

        // play voiceline here
        choice1.label = Translator.translate(prefix + "Warrior");
        choice2.label = Translator.translate(prefix + "Mage");
        choice3.label = Translator.translate(prefix + "Thief");

        var temp = [choice1, choice2, choice3];
        if (_answers[_questionIdx] != null) {
            temp[_answers[_questionIdx]].gotoAndStop("down"); // todo: make sure this works
        }
        _shuffleArray(temp);

        for (var i = 0; i < 3; i++) {
            temp[i]._y = ys[i];
        }

        update();
    }

    private function update() {
        backward_button.disabled = false;
		backward_button._visible = true;

        forward_button.disabled = false;
		forward_button._visible = true;

        if (_questionIdx == 0) {
            backward_button._visible = false;
        } else if (_questionIdx == 9) { // last question or no answer for current one
            forward_button._visible = false;
        } else if (_answers[_questionIdx] == null) {
			// todo, disable button, 
		}
        indicator.gotoAndStop(_questionIdx + 1);
    }

    private function onForward() {
        populateQuestions(1);
    }

    private function onBackward() {
        populateQuestions(-1);
    }

    private function onChoice1() {
        _answers[_questionIdx] = ClassQuiz.WARRIOR;
        // todo, ungray button
    }

    private function onChoice2() {
        _answers[_questionIdx] = ClassQuiz.MAGE;
        
    }

    private function onChoice3() {
        _answers[_questionIdx] = ClassQuiz.THIEF;
        
    }

    private function _shuffleArray(array) {
        for (var i = array.length - 1; i > 0; i--) {
            var j = Math.floor(Math.random() * (i + 1));
            var temp = array[i];
            array[i] = array[j];
            array[j] = temp;
        }
    }

}
