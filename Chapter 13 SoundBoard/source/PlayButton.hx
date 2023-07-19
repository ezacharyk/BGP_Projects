package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.sound.FlxSound;

/**
 * This class creates a play button for the music
 */
class PlayButton extends FlxSprite
{
	var switchSound:FlxSound;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		super(X, Y);

		frames = Texture; // frames is a variable inhereted from FlxSprite

		// We initialize a sound when the button is clicked.
		switchSound = FlxG.sound.load(AssetPaths.switch__wav, 0.4);

		animation.frameName = "play"; // We set the default image for the button

		FlxMouseEvent.add(this, null, onUp, null, null); // We set an onup mouse action so when a player clicks on the button we can perform actions
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// don't need to do much here

		// If the music has stopped we change the play button back
		if (FlxG.sound.music == null
			|| (FlxG.sound.music != null && !FlxG.sound.music.exists)) // don't restart the music if it's already playing
		{
			// update the frame
			animation.frameName = "play";
		}
	}

	/**
	 * In the onUp function we activate the button. Then we play the song that is active.
	 */
	public function onUp(_):Void
	{
		animation.frameName = "playact"; // We set the default image for the card to the back.

		if (FlxG.sound.music == null
			|| (FlxG.sound.music != null && !FlxG.sound.music.exists)) // don't restart the music if it's already playing
		{
			// we start playing music for the game. We only need to do it in this object. It will continue playing in other states.
			switch (Reg.song)
			{
				case "Amazing Mazes":
					FlxG.sound.playMusic(AssetPaths.amazingmazes__ogg, 0.5, true);
				case "DK Adventure":
					FlxG.sound.playMusic(AssetPaths.dkadventure__ogg, 0.5, true);
				case "Space Theme":
					FlxG.sound.playMusic(AssetPaths.spacetheme__ogg, 0.5, true);
			}
		}
	}
}
