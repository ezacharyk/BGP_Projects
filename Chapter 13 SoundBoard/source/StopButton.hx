package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.system.FlxSound;

/**
 * This class creates a stop button for stopping the music
 */
class StopButton extends FlxSprite
{
	var switchSound:FlxSound;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		super(X, Y);

		frames = Texture; // frames is a variable inhereted from FlxSprite

		// We initialize this sound
		switchSound = FlxG.sound.load(AssetPaths.switch__wav, 0.4);

		animation.frameName = "stop"; // We set the default image for the button

		FlxMouseEvent.add(this, onDown, onUp, null, null); // We set an onup mouse action so when a player clicks on the button
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// don't need to do much here
	}

	/**
	 * In the onUp function we check if music is actually playing. Then we stop it if it is.
	 */
	public function onUp(_):Void
	{
		animation.frameName = "stop"; // We set the default image for the card to the back.
		if (FlxG.sound.music != null && FlxG.sound.music.exists)
		{
			// autoDestroy tells Flixel to kill the object and not just stop playing the music.
			// Not sure why, but this is the only way I could figure out how to let other areas of the game know music has stopped
			FlxG.sound.music.autoDestroy = true;
			FlxG.sound.music.stop();
		}
	}

	public function onDown(_):Void
	{
		animation.frameName = "stopact"; // We set the image of the button
	}
}
