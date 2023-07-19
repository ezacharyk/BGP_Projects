package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.sound.FlxSound;

/**
 * This class creates a button to mute the music.
 */
class MuteButton extends FlxSprite
{
	var switchSound:FlxSound;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		super(X, Y);

		frames = Texture; // frames is a variable inhereted from FlxSprite

		// We initialize the sound for the button
		switchSound = FlxG.sound.load(AssetPaths.switch__wav, 0.4);

		animation.frameName = "mute"; // We set the default image for the button

		FlxMouseEvent.add(this, null, onUp, null, null); // We set an onup mouse action so when a player clicks on the button
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// If the music has stopped, we reset the button
		if (FlxG.sound.music == null || (FlxG.sound.music != null && !FlxG.sound.music.exists))
		{
			animation.frameName = "mute";
		}
	}

	/**
	 * In the onUp function we check the volume of the music and change the setting depending on it.
	 */
	public function onUp(_):Void
	{
		if (FlxG.sound.music != null && FlxG.sound.music.exists)
		{
			if (FlxG.sound.music.volume == 0)
			{
				// if the volume is muted, unmute it.
				animation.frameName = "mute";
				FlxG.sound.music.volume = 0.5;
			}
			else
			{
				// if music is playing, set it to 0 to mute it.
				animation.frameName = "muteact";
				FlxG.sound.music.volume = 0;
			}
		}
	}
}
