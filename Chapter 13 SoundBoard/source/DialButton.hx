package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;

/**
 * This is our dial class. This one just ticks on a one second timer. No interaction.
 */
class DialButton extends FlxSprite
{
	var tickSound:FlxSound;

	var tickTimer:Float = 1;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		super(X, Y);

		frames = Texture; // frames is a variable inhereted from FlxSprite
		animation.frameName = "dialup"; // We set the default image for the button

		// We initialize the sound for the button
		tickSound = FlxG.sound.load(AssetPaths.tick__wav, 0.4);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// when the timer hits 0, play a tick, reset the timer, change the frame.
		tickTimer -= elapsed;
		if (tickTimer <= 0)
		{
			tickSound.play();
			tickTimer = 1;

			switch (animation.frameName)
			{
				case "dialup":
					animation.frameName = "dialright";
				case "dialright":
					animation.frameName = "dialdown";
				case "dialdown":
					animation.frameName = "dialleft";
				case "dialleft":
					animation.frameName = "dialup";
			}
		}
	}
}
