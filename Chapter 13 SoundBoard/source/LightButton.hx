package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;

/**
 * This is our lightup button class. It creates a timer and a beep when the timer hits 0
 */
class LightButton extends FlxSprite
{
	var tickSound:FlxSound;
	var timerSound:FlxSound;

	var timer:Float = 0;
	var startTimer:Bool = false;

	var startBuzz:Bool = false;
	var buzzTimer:Float = 0;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		super(X, Y);

		frames = Texture; // frames is a variable inhereted from FlxSprite
		animation.frameName = "lightup"; // We set the default image for the button

		// We initialize two sounds for our button. A click and a timer alarm.
		tickSound = FlxG.sound.load(AssetPaths.tick__wav, 0.4);
		timerSound = FlxG.sound.load(AssetPaths.timer__wav, 0.4, true);

		FlxMouseEvent.add(this, onDown, onUp, null, null); // We set an onup mouse action so when a player clicks on the button
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// we check the state of the timer and if it hits 0, we play the buzzer
		if (startTimer)
		{
			timer -= elapsed;
			if (timer <= 0)
			{
				startBuzzing();
			}
		}

		// we play the buzzer for a short amount of time and stop it when its timer hits 0.
		if (startBuzz)
		{
			buzzTimer -= elapsed;
			if (buzzTimer <= 0)
			{
				stopBuzzing();
			}
		}
	}

	/**
	 * In the onUp function we stop the buzzer if it is playing. Then we update the timer.
	 */
	public function onUp(_):Void
	{
		tickSound.play();
		if (startBuzz)
		{
			stopBuzzing();
		}
		startTimer = true;
		timer += 1;
		animation.frameName = "lightup";
	}

	/**
	 * In the onUp function we change the state of the button to show it pressed
	 */
	public function onDown(_):Void
	{
		animation.frameName = "lightdown";
	}

	/**
	 * In the function to play the buzzer and set a few other actions.
	 */
	public function startBuzzing()
	{
		timerSound.play();
		startTimer = false;
		buzzTimer = 2;
		startBuzz = true;
		animation.frameName = "lighthover";
	}

	/**
	 * In the function, we stop the buzzing and change the animation
	 */
	public function stopBuzzing()
	{
		timerSound.stop();
		startBuzz = false;
		animation.frameName = "lightup";
	}

	/**
	 * This is a public function for other areas of the game to get the remaining time.
	 * @return Int
	 */
	public function getTime():Int
	{
		return (Std.int(timer));
	}
}
