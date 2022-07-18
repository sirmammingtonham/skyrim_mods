/**
 * button, had to override so i could set it to a clicked state with code
*/

import gfx.io.GameDelegate;
import gfx.controls.Button;

class ChoiceButton extends gfx.controls.Button {
    /* PUBLIC FUNCTIONS */
	// had to override just to add this stupid function
    public function simulateClick() {
        handleMousePress();
        handleMouseRelease();
    }
}
