package;

import flixel.FlxSprite;

class Slideshow extends FlxSprite
{
	public function new(X:Int, Y:Int)
	{
		// X,Y: Starting coordinates
		super(X, Y);
		// load the png in the assets folder into the sprite object on creation.
		// This sprite fills the entire screen, so its size is the size of the game window. The "true" parameter indicates that this sprite is animated.
		loadGraphic(AssetPaths.ManlyBoy__png, true, 320, 180);
		// Create an animation called "slide" which just goes through each frame at 1 frame per second, then loops.
		animation.add("slide", [0, 1, 2, 3, 4], 1, true);
	}
}
