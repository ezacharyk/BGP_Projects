package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;

class Spider extends FlxSprite
{
	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		// X,Y: Starting coordinates
		super(X, Y);

		// we load in the frames collection and use it as the base sprite.
		frames = Texture; // frames is a variable inhereted from FlxSprite

		animation.addByNames("idle", ["spider1", "spider2"], 4, true);
		animation.play("idle");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
