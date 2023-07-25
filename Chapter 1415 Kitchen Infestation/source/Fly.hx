package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.sound.FlxSound;
import flixel.tweens.FlxEase.EaseFunction;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween.TweenOptions;
import flixel.tweens.FlxTween;

class Fly extends FlxSprite
{
	var _tween:FlxTween;
	private var startX:Int;
	private var startY:Int;
	private var flying:Bool = false;

	var splat1Sound:FlxSound;
	var splat2Sound:FlxSound;
	var splat3Sound:FlxSound;
	var missSound:FlxSound;

	var tween:FlxTween;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		// X,Y: Starting coordinates
		super(X, Y);

		startX = X;
		startY = Y;

		// we load in the frames collection and use it as the base sprite.
		frames = Texture; // frames is a variable inhereted from FlxSprite

		//we create our animation
		animation.addByNames("idle", ["fly1", "fly2"], 4, true);
		animation.play("idle");

		//we set directions which will be used for which way our spiders face by default
		setFacingFlip(RIGHT, false, false);
		setFacingFlip(LEFT, true, false);

		FlxMouseEvent.add(this, null, onUp, null, null); // We set an onup mouse action so when a player clicks on the card we can perform actions

		// we generate our sounds for the splats around. We have 3 and will randomize which one plays.
		splat1Sound = FlxG.sound.load(AssetPaths.splat1__wav, 0.5);
		splat2Sound = FlxG.sound.load(AssetPaths.splat2__wav, 0.5);
		splat3Sound = FlxG.sound.load(AssetPaths.splat3__wav, 0.5);
		//we also have a sound that plays when the bug escapes
		missSound = FlxG.sound.load(AssetPaths.miss__wav, 0.5);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function setTween()
	{
		//For the flies, we are creating a tween animation. This makes the fly move in a bit of a loop and then then head back to start
		var options:TweenOptions = {type: PINGPONG, ease: FlxEase.sineInOut, onComplete: onComplete};
		if (facing == LEFT)
		{
			tween = FlxTween.quadMotion(this, startX, startY, 0, 20, startX + 120, startY, 3, true, options);
		}
		else 
		{
			tween = FlxTween.quadMotion(this, startX, startY, 120, 20, startX - 120, startY, 3, true, options);
		}
	}

	public function onComplete(_):Void
	{
		// update score, kill sprite
		if (flying)
		{
			Reg.misses++;
			missSound.play();
			tween.cancel();
			kill();
			flying = false;
			x = startX;
			y = startY;
		}
		flying = true;
	}

	/**
	 * In the onUp function we check to see if the card has been matched, or if it is already revealed and skips the actions if so.
	 * We also check if we have already selected two cards, if so, we ignore the action.
	 * If we haven't already selected two cards, and if this card hasn't already been acted upon, we reveal the card.
	 */
	public function onUp(_):Void
	{
		// update score, kill sprite
		Reg.hits += 25;
		switch(FlxG.random.int(0,2))
		{
			case(0):
				splat1Sound.play();
			case(1):
				splat2Sound.play();
			case(2):
				splat3Sound.play();
		}
		kill();
		tween.cancel();
		x = startX;
		y = startY;
		flying = false;
	}
}
