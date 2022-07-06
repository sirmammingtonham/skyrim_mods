/**
 * button, had to override so i could set it to a clicked state with code
*/

import gfx.io.GameDelegate;
import gfx.controls.Button;
// import gfx.events.EventTypes;

class BirthsignButton extends gfx.controls.Button {
    /**
     * The constructor is called when a Button or a sub-class of Button is instantiated on stage or by using {@code attachMovie()} in ActionScript. This component can <b>not</b> be instantiated using {@code new} syntax. When creating new components that extend Button, ensure that a {@code super()} call is made first in the constructor.
     */
    public function Button() {
        super();
    }

    /* PUBLIC FUNCTIONS */
	// had to override just to add this stupid function
    public function simulateClick() {
        handleMousePress();
        handleMouseRelease();
        // dispatchEvent({type: "click"});
    }

}
