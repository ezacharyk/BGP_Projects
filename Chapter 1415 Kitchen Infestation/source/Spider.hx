package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.math.FlxPoint;
import flixel.sound.FlxSound;

class Spider extends FlxSprite
{
	private var startX:Int;
	private var startY:Int;
	private var running:Bool = false;

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
		animation.addByNames("idle", ["spider1", "spider2"], 4, true);
		animation.play("idle");

		//we set directions which will be used for which way our spiders face by default
		setFacingFlip(UP, false, true);
		setFacingFlip(DOWN, false, false);

		//We use the origin property to set the point on which the spider rotates
		origin = FlxPoint.get(16, 16);

		FlxMouseEvent.add(this, null, onUp, null, null); // We set an onup mouse action so when a player clicks on the bug to add points.

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
			if (facing == DOWN)
			{
				//When the spider reaches the end of its path, we change its angle. 
				//We incriment the angle so it rotates.
				if (y > startY + 48 && !running)
				{
					velocity.y = 0;
					angle += 1;
					//when the spider finishes rotatings, we set a variable to help use know it is running away.
					if (angle == 180)
					{
						running = true;
					}
				}
				else if (running && y < startY)
				{
					//if the bug manages to run away, we incriment the miss value, play the sound, kill the spider and reset variables.
					Reg.misses++;
					missSound.play();
					kill();
					x = startX;
					y = startY;
					angle = 0;
					facing = DOWN;
					running = false;
				}
				else
				{
					//we set the speed of the spider based on if it is running.
					if (running)
					{
						velocity.y = -32;
					}
					else
					{
						velocity.y = 32;
					}
				}
			}
			else
			{
				//we do all the above, but for the other direction
				if (y < startY - 48 && !running)
				{
					velocity.y = 0;
					angle += 1;
					if (angle == 180)
					{
						running = true;
					}
				}
				else if (running && y > startY)
				{
					Reg.misses++;
					missSound.play();
					kill();
					x = startX;
					y = startY;
					angle = 0;
					facing = UP;
					running = false;
				}
				else
				{
					if (running)
					{
						velocity.y = 32;
					}
					else
					{
						velocity.y = -32;
					}
				}
			}
		}
	}

	/**
	 * In the onUp function we add the value of the bug to the score. Then we play a sound, kill the sprite and reset values.
	 */
	public function onUp(_):Void
	{
		// update score, kill sprite
		Reg.hits += 15;
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
		angle = 0;
		running = false;
	}
}
