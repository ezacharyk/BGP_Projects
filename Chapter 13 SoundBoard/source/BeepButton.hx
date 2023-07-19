package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.sound.FlxSound;

/**
 * This is our Beep button class.
 */
class BeepButton extends FlxSprite
{
	var beepSound:FlxSound;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		super(X, Y);

		frames = Texture; // frames is a variable inhereted from FlxSprite
		animation.frameName = "buttonup"; // We set the default image for the button

		// We initialize the sound for the button
		beepSound = FlxG.sound.load(AssetPaths.beep__wav, 0.4, true);

		FlxMouseEvent.add(this, onDown, onUp, null, null); // We set an onup mouse action so when a player clicks and holds the button
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// don't need to do much here
	}

	/**
	 * In the onUp function we stop playing the sound and change the animation frame back.
	 */
	public function onUp(_):Void
	{
		beepSound.stop();
		animation.frameName = "buttonup";
	}

	/**
	 * In the onDown class, we play the sound and change the button to the down frame.
	 */
	public function onDown(_):Void
	{
		beepSound.play();
		animation.frameName = "buttondown";
	}
}
