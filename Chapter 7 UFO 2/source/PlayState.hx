package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;

class PlayState extends FlxState
{
	private var texture:FlxFramesCollection;
	private var background:FlxSprite;
	private var ufo:UFO;

	override public function create()
	{
		super.create();
		FlxG.mouse.visible = false;

		// we load in our fun background
		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.background__png, false, 640, 360);
		add(background);

		// we create a texture fram collection from our sprite and the associated json file.
		texture = FlxAtlasFrames.fromTexturePackerJson(AssetPaths.ufo__png, AssetPaths.ufo__json);

		// we create our ufo
		ufo = new UFO(304, 164, texture);
		add(ufo);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
