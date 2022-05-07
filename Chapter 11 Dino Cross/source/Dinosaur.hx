package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;

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

	/**
	 * In the update function, we only need to check if the dinos need to wrap around the screen
	 * @param elapsed 
	 */
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		screenWrap();
	}

	/**
	 * The next set of function are used to add dinosaurs that move up on the screen.
	 * We only need to set their velocity and size.
	 */
	public function setUpTriceratops()
	{
		velocity.y = -30;
		setSize(32, 64);
	}

	public function setUpStegasaurus()
	{
		velocity.y = -25;
		setSize(32, 64);
	}

	public function setUpVelociraptor()
	{
		velocity.y = -40;
		setSize(16, 32);
	}

	public function setUpTyranosaurus()
	{
		velocity.y = -45;
		setSize(32, 96);
	}

	/**
	 * These next set of functionality, we set up dinosaurs that move down on the screen
	 * We set their velocity, size and we flip their sprites.
	 */
	public function setDownStegasaurus()
	{
		velocity.y = 25;
		setSize(32, 64);
		setFacingFlip(DOWN, false, true);
		facing = DOWN;
	}

	public function setDownVelociraptor()
	{
		velocity.y = 40;
		setSize(16, 32);
		setFacingFlip(DOWN, false, true);
		facing = DOWN;
	}

	public function setDownTriceratops()
	{
		velocity.y = 30;
		setFacingFlip(DOWN, false, true);
		facing = DOWN;
		setSize(32, 64);
	}

	/**
	 * Here we take the functionality of the FlxSpriteUtil screenwrap function and put it into our class
	 * The Sprite Util class was causing the dinos to magically appear on the screen I changed it to make them reappear
	 * off screen. 
	 */
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
