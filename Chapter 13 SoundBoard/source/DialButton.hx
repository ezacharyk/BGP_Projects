package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.sound.FlxSound;
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
		// In this, we also play with the panning and volume a bit as the dial rotates.
		tickTimer -= elapsed;
		if (tickTimer <= 0)
		{
			switch (animation.frameName)
			{
				case "dialup":
					if (!Reg.sfxMuted)
					{
						tickSound.volume = .5;
					}
					tickSound.pan = 1;
					animation.frameName = "dialright";
				case "dialright":
					if (!Reg.sfxMuted)
					{
						tickSound.volume = .2;
					}
					tickSound.pan = 0;
					animation.frameName = "dialdown";
				case "dialdown":
					if (!Reg.sfxMuted)
					{
						tickSound.volume = .5;
					}
					tickSound.pan = -1;
					animation.frameName = "dialleft";
				case "dialleft":
					if (!Reg.sfxMuted)
					{
						tickSound.volume = 1;
					}
					tickSound.pan = 0;
					animation.frameName = "dialup";
			}
			tickSound.play();
			tickTimer = 1;
		}
	}
}
