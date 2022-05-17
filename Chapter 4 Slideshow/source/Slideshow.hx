package;

import flixel.FlxSprite;

class Slideshow extends FlxSprite
{
	private var slideTimer:Float = 0;

	public function new(X:Int, Y:Int)
	{
		// X,Y: Starting coordinates
		super(X, Y);
		// load the png in the assets folder into the sprite object on creation.
		// This sprite fills the entire screen, so its size is the size of the game window. The "true" parameter indicates that this sprite is animated.
		loadGraphic(AssetPaths.ManlyBoy__png, true, 320, 180);
		// Create an animation called "slide" which just goes through each frame at 1 frame per second, then loops.
		// animation.add("slide", [0, 1, 2, 3, 4], 1, true);
		animation.frameIndex = 0;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		slideTimer += elapsed;
		// we check the state of the timer and if it hits 5, we play the next frame
		if (slideTimer >= 5)
		{
			animation.frameIndex++;
			// if we have gone passed the number of frames, then we go back to 0
			if (animation.frameIndex > 5)
			{
				animation.frameIndex = 0;
			}
			// we reset our timer
			slideTimer = 0;
		}
	}
}
