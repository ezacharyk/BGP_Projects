package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.util.FlxSpriteUtil;

class Dinosaur extends FlxSprite
{
	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		// X,Y: Starting coordinates
		super(X, Y);

		// we load in the frames collection and use it as the base sprite.
		frames = Texture; // frames is a variable inhereted from FlxSprite
		// just like we did in the slideshow, we create some animations based on the frame collection
		animation.add("walk", [0, 1], 4, true);
		// we play our default animation
		animation.play("walk");
		setSize(32, 64);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		screenWrap();
	}

	public function setUpTriceratops()
	{
		// Setup the mouse events
		velocity.y = -30;
		setSize(32, 64);
	}

	public function setUpStegasaurus()
	{
		// Setup the mouse events
		velocity.y = -25;
		setSize(32, 64);
	}

	public function setUpVelociraptor()
	{
		// Setup the mouse events
		velocity.y = -40;
		setSize(16, 32);
	}

	public function setUpTyranosaurus()
	{
		// Setup the mouse events
		velocity.y = -45;
		setSize(32, 96);
	}

	public function setDownStegasaurus()
	{
		// Setup the mouse events
		velocity.y = 25;
		setSize(32, 64);
		setFacingFlip(DOWN, false, true);
		facing = DOWN;
	}

	public function setDownVelociraptor()
	{
		// Setup the mouse events
		velocity.y = 40;
		setSize(16, 32);
		setFacingFlip(DOWN, false, true);
		facing = DOWN;
	}

	public function setDownTriceratops()
	{
		// Setup the mouse events
		velocity.y = 30;
		setFacingFlip(DOWN, false, true);
		facing = DOWN;
		setSize(32, 64);
	}

	private function screenWrap()
	{
		if ((x + frameWidth / 2) <= 0)
		{
			x = FlxG.width;
		}
		else if (x >= FlxG.width)
		{
			x = 0;
		}

		if ((y + frameHeight) <= 0) // top
		{
			y = FlxG.height;
		}
		else if (y >= FlxG.height) // bottom
		{
			y = 0 - frameHeight;
		}
	}
}
