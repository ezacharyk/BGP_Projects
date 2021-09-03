package;

import flixel.FlxSprite;

class Snowflake extends FlxSprite
{
	public function new(X:Int, Y:Int)
	{
		// X,Y: Starting coordinates
		super(X, Y);
		// load the png in the assets folder into the sprite object on creation.
		loadGraphic(AssetPaths.snowflake__png, false, 18, 18);
	}
}
