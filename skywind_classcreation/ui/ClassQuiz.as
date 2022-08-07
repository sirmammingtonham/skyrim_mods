import gfx.controls.Button;
import gfx.io.GameDelegate;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import Shared.GlobalFunc;
import skyui.defines.Input;
import skyui.util.Translator;

// todo: make button gray disable instead of invisible X
// todo: formula for calculating class
// todo: add selector from messagebox for over/down frames
class ClassQuiz extends MovieClip {
    public var questionField:TextField;
    public var wdydField:TextField;
    public var indicator:MovieClip;
    public var forward_button:Button;
    public var backward_button:Button;
    public var choice1:ChoiceButton;
    public var choice2:ChoiceButton;
    public var choice3:ChoiceButton;

    private var _questionIdx:Number;
    private var _answers:Array;
	// private var _voiceLineAudio:Sound;

    private static var ys:Array = [84, 193, 306];
    public static var COMBAT:Number = 0;
    public static var MAGIC:Number = 1;
    public static var STEALTH:Number = 2;

    public function ClassQuiz() {
        super();
    }

    public function onLoad():Void {
        super.onLoad();

        _questionIdx = 0;
        _answers = [null, null, null, null, null, null, null, null, null, null];
		// _voiceLineAudio = new Sound();
		// _voiceLineAudio.setVolume(40);

        forward_button.addEventListener("click", this, "onForward");
        backward_button.addEventListener("click", this, "onBackward");

        choice1.addEventListener("click", this, "onChoice1");
        choice2.addEventListener("click", this, "onChoice2");
        choice3.addEventListener("click", this, "onChoice3");


        wdydField.text = Translator.translate("$WDYD?");
        populateQuestions(0);
    }


    public function handleInput(details:InputDetails, pathToFocus:Array):Boolean {
        return true;
    }

    private function populateQuestions(offset:Number) {
        _questionIdx += offset;
		// _voiceLineAudio.attachSound("Q"+(_questionIdx+1)+"Audio");
		// _voiceLineAudio.start();

        var prefix = "$ClassQuiz" + _questionIdx;
        questionField.text = Translator.translate(prefix + "Q");

        var temp = [choice1, choice2, choice3];
        if (_answers[_questionIdx] != null) {
            temp[_answers[_questionIdx]].simulateClick(); // todo: make sure this works
        }
        _shuffleArray(temp);

        // play voiceline here
        choice1.label = Translator.translate(prefix + "C");
        choice2.label = Translator.translate(prefix + "M");
        choice3.label = Translator.translate(prefix + "S");

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
        }
        if (_answers[_questionIdx] == null) {
            forward_button.disabled = true;
        }
        indicator.gotoAndStop(_questionIdx + 1);
    }

    private function onForward() {
		// _voiceLineAudio.stop();
        if (_questionIdx == 9) {
            var classSelection = _calculateClass();
			// var x = classSelection.specialization;
			// var y = classSelection.selection;
			// var z = ((x + y) * (x + y + 1)) / 2 + y;  // cantor pairing function, since im too lazy to redo the logic in fbmw_chargenclassbasescript
            skse.SendModEvent("SW_ClassQuizMenuClose", "", classSelection);
            skse.CloseMenu("CustomMenu");
        } else {
            populateQuestions(1);
        }
    }

    private function onBackward() {
		// _voiceLineAudio.stop();
        populateQuestions(-1);
    }

    private function onChoice1() {
        _answers[_questionIdx] = ClassQuiz.COMBAT;
        forward_button.disabled = false;
    }

    private function onChoice2() {
        _answers[_questionIdx] = ClassQuiz.MAGIC;
        forward_button.disabled = false;
    }

    private function onChoice3() {
        _answers[_questionIdx] = ClassQuiz.STEALTH;
        forward_button.disabled = false;
    }

    private function _calculateClass():Object {
        var cScore = 0; //combat
        var mScore = 0; //magic
        var sScore = 0; //ithinkyougettheidea

        for (var i = 0; i < 10; i++) {
            if (_answers[i] == 0) {
                cScore++;
            } else if (_answers[i] == 1) {
                mScore++;
            } else if (_answers[i] == 2) {
                sScore++;
            }
        }

        if (cScore == 2 && mScore == 2 && sScore == 6) {
            return 0; // Acrobat
        }
        if (cScore == 3 && mScore == 1 && sScore == 6) {
            return 1; // Agent
        }
        if (cScore == 5 && mScore == 1 && sScore == 4) {
            return 1; // Agent
        }
        if (cScore == 5 && mScore == 5 && sScore == 0) {
            return 2; // Archer
        }
        if (cScore == 5 && mScore == 4 && sScore == 1) {
            return 2; // Archer
        }
        if (cScore == 5 && mScore == 3 && sScore == 2) {
            return 2; // Archer
        }
        if (cScore == 5 && mScore == 0 && sScore == 5) {
            return 3; // Assassin
        }
        if (cScore == 1 && mScore == 3 && sScore == 6) {
            return 3; // Assassin
        }
        if (cScore == 6 && mScore == 3 && sScore == 1) {
            return 4; // Barbarian
        }
        if (cScore == 3 && mScore == 3 && sScore == 4) {
            return 5; // Bard
        }
        if (cScore == 1 && mScore == 5 && sScore == 4) {
            return 5; // Bard
        }
        if (cScore == 1 && mScore == 6 && sScore == 3) {
            return 6; // Battlemage
        }
        if (cScore == 0 && mScore == 6 && sScore == 4) {
            return 6; // Battlemage
        }
        if (cScore == 6 && mScore == 1 && sScore == 3) {
            return 7; // Crusader
        }
        if (cScore == 4 && mScore == 6 && sScore == 0) {
            return 8; // Healer
        }
        if (cScore == 3 && mScore == 6 && sScore == 1) {
            return 8; // Healer
        }
        if (cScore == 6 && mScore == 4 && sScore == 0) {
            return 9; // Knight
        }
        if (cScore == 6 && mScore == 2 && sScore == 2) {
            return 9; // Knight
        }
        if (cScore == 6 && mScore == 0 && sScore == 4) {
            return 9; // Knight
        }
        if (mScore >= 7) {
            return 10; // Mage
        }
        if (cScore == 2 && mScore == 3 && sScore == 5) {
            return 11; // Monk
        }
        if (cScore == 3 && mScore == 5 && sScore == 2) {
            return 11; // Monk
        }
        if (cScore == 1 && mScore == 4 && sScore == 5) {
            return 12; // Nightblade
        }
        if (cScore == 0 && mScore == 4 && sScore == 6) {
            return 12; // Nightblade
        }
        if (cScore == 3 && mScore == 2 && sScore == 5) {
            return 13; // Pilgrim
        }
        if (cScore == 4 && mScore <= 5) {
            return 14; // Rogue
        }
        if (cScore == 5 && mScore == 2 && sScore == 3) {
            return 15; // Scout
        }
        if (cScore == 2 && mScore == 6 && sScore == 2) {
            return 16; // Sorcerer
        }
        if (cScore == 3 && mScore == 4 && sScore == 3) {
            return 17; // Spellsword
        }
        if (cScore == 2 && mScore == 4 && sScore == 4) {
            return 17; // Spellsword
        }
        if (sScore >= 7) {
            return 18; // Thief
        }
        if (cScore >= 7) {
            return 19; // Warrior
        }
        if (cScore == 2 && mScore == 5 && sScore == 3) {
            return 20; // Witchhunter
        }
        if (cScore == 0 && mScore == 5 && sScore == 5) {
            return 20; // Witchhunter
        }

        return 15; // Scout as failsafe
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
