package;

import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	private var background:FlxSprite;
	private var ufo:UFO;

	override public function create()
	{
		super.create();

		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.background__png, false, 640, 360);
		add(background);

		ufo = new UFO(304, 164);
		add(ufo);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
