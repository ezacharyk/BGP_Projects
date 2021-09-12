package;

import flixel.FlxSprite;

class Slideshow extends FlxSprite
{
	public function new(X:Int, Y:Int)
	{
		// X,Y: Starting coordinates
		super(X, Y);
		// load the png in the assets folder into the sprite object on creation.
		loadGraphic(AssetPaths.ManlyBoy__png, true, 320, 180);
		animation.add("slide", [0, 1, 2, 3, 4], 1, true);
	}
}
