package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.system.FlxSound;

/**
 * This is our Switch class
 */
class SwitchButton extends FlxSprite
{
	var switchSound:FlxSound;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		super(X, Y);

		frames = Texture; // frames is a variable inhereted from FlxSprite
		animation.frameName = "switchup"; // We set the default image for the switch

		// We initialize the sound for the flick of the switch
		switchSound = FlxG.sound.load(AssetPaths.switch__wav, 0.4);

		FlxMouseEvent.add(this, null, onUp, null, null); // We set an onup mouse action so when a player clicks on the switch
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// don't need to do much here
	}

	/**
	 * In the onUp function we check the switch state and then mute the music or turn it back on depending on the state
	 */
	public function onUp(_):Void
	{
		switch (animation.frameName)
		{
			case "switchup":
				animation.frameName = "switchdown";
				Reg.sfxMuted = true;
				switchSound.play();

				// if we flick the switch down, we loop through our sounds and turn the volume to 0
				for (sound in FlxG.sound.list.members)
				{
					if (sound != null && sound.exists && sound != FlxG.sound.music)
					{
						sound.volume = 0;
					}
				}
			case "switchdown":
				animation.frameName = "switchup";
				Reg.sfxMuted = false;

				// if we flick the switch up, we loop through the sounds and turn their volume up.
				for (sound in FlxG.sound.list.members)
				{
					if (sound != null && sound.exists && sound != FlxG.sound.music)
					{
						sound.volume = .4;
					}
				}
		}
	}
}
