package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.system.FlxSound;

/**
 * This class creates a button that pauses the music
 */
class PauseButton extends FlxSprite
{
	var switchSound:FlxSound;

	// This is a public variable to let us know if the music is paused.
	public var paused:Bool = false;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		super(X, Y);

		frames = Texture; // frames is a variable inhereted from FlxSprite

		// We initialize the sound for the button click
		switchSound = FlxG.sound.load(AssetPaths.switch__wav, 0.4);

		animation.frameName = "pause"; // We set the default image for the button

		FlxMouseEventManager.add(this, null, onUp, null, null); // We set an onup mouse action so when a player clicks on the button
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// don't need to do much here

		// if the music is stopped we turn off the pause button
		if (FlxG.sound.music == null
			|| (FlxG.sound.music != null && !FlxG.sound.music.exists)) // don't restart the music if it's already playing
		{
			animation.frameName = "pause";
		}
	}

	/**
	 * In the onUp function we switch the state of the button and the music paused
	 */
	public function onUp(_):Void
	{
		if (FlxG.sound.music != null && FlxG.sound.music.exists)
		{
			if (!paused)
			{
				paused = true; // we set out pause flag
				FlxG.sound.music.pause(); // we pause the music
				animation.frameName = "pauseact"; // We set the default image for the button
			}
			else
			{
				paused = false; // we change the pause flag
				FlxG.sound.music.resume(); // we resume the music
				animation.frameName = "pause"; // We set the default image for the button
			}
		}
	}
}
