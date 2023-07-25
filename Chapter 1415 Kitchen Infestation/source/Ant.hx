package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.sound.FlxSound;

class Ant extends FlxSprite
{
	private var startX:Int;
	private var startY:Int;

	var splat1Sound:FlxSound;
	var splat2Sound:FlxSound;
	var splat3Sound:FlxSound;
	var missSound:FlxSound;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		// X,Y: Starting coordinates
		super(X, Y);

		startX = X;
		startY = Y;

		// we load in the frames collection and use it as the base sprite.
		frames = Texture; // frames is a variable inhereted from FlxSprite

		//we create our animation
		animation.addByNames("idle", ["ant1", "ant2"], 4, true);
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

		if(alive)
		{
			if (facing == LEFT)
			{
				//ants move in one direction, and when they hit the end of their path, they turn around and leave
				velocity.x = 48;
				if (x > startX + 96)
				{
					facing = RIGHT;
				}
			}
			else
			{
				velocity.x = -48;
				if (x < startX - 96)
				{
					facing = LEFT;
				}
			}
			//if the ants get back to their start position, we increment the miss count and reset values
			if ((y == 0 && x < startX) || (y == 80 && x > startX))
			{
				Reg.misses++;
				missSound.play();
				kill();
				x = startX;
				y = startY;
			}
		}
	}

	/**
	 * In the onUp function we add the value of the bug to the score. Then we play a sound, kill the sprite and reset values.
	 */
	public function onUp(_):Void
	{
		// update score, kill sprite
		Reg.hits += 5;
		//We play one of three splat sounds to make the game interesting.
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
		x = startX;
		y = startY;
	}
}
