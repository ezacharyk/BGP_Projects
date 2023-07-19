package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.sound.FlxSound;

/**
 * This is called the FastForward class, but it is actually a skip to next track button
 */
class FFButton extends FlxSprite
{
	var switchSound:FlxSound;
	var volume:Float = 0.5; // we have a default volume because we need to know if the music is muted when we skip.

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		super(X, Y);

		frames = Texture; // frames is a variable inhereted from FlxSprite

		// We initialize the sound for the button
		switchSound = FlxG.sound.load(AssetPaths.switch__wav, 0.4);

		animation.frameName = "ff"; // We set the default image for the button

		FlxMouseEvent.add(this, onDown, onUp, null, null); // We set an onup mouse action so when a player clicks on the button
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// don't need to do much here
	}

	/**
	 * In the onUp function we check if music is actually playing (no need to skip if not)
	 * Then we check the volume of the music and then play the next song in the track list.
	 */
	public function onUp(_):Void
	{
		animation.frameName = "ff"; // We set the default image for the card to the back.
		if (FlxG.sound.music != null && FlxG.sound.music.exists) // if music isn't already playing, we can't skip.
		{
			if (FlxG.sound.music.volume == 0)
			{
				volume = 0;
			}
			else
			{
				volume = 0.5;
			}
			// we start playing the next track.
			switch (Reg.song)
			{
				case "Amazing Mazes":
					FlxG.sound.playMusic(AssetPaths.dkadventure__ogg, volume, true);
					Reg.song = "DK Adventure";
				case "DK Adventure":
					FlxG.sound.playMusic(AssetPaths.spacetheme__ogg, volume, true);
					Reg.song = "Space Theme";
				case "Space Theme":
					FlxG.sound.playMusic(AssetPaths.amazingmazes__ogg, volume, true);
					Reg.song = "Amazing Mazes";
			}
		}
	}

	public function onDown(_):Void
	{
		animation.frameName = "ffact"; // We set the default image for the button
	}
}
