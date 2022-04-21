package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	private var background:FlxSprite;
	private var header:FlxText;
	private var Unicorn1:Unicorn;
	private var Unicorn2:Unicorn;
	private var texture:FlxFramesCollection;

	override public function create()
	{
		super.create();
		FlxG.mouse.visible = false;

		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.background__png, false, 640, 360);
		add(background);

		// Set up a scoreboard
		header = new FlxText(0, 10, 630, "Unicorn Dash!");
		header.size = 36;
		header.alignment = "center";
		header.color = 0xFF7585FF;
		// header.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(header);

		// we create a texture fram collection from our sprite and the associated json file.
		texture = FlxAtlasFrames.fromTexturePackerJson(AssetPaths.unicorns__png, AssetPaths.unicorns__json);

		// we create our unicorn for player 1
		Unicorn1 = new Unicorn(312, 416, 0, 0, texture);
		add(Unicorn1);
		//add(Unicorn1.line);
		// we create our unicorn for player 2
		Unicorn2 = new Unicorn(312, 96, 2, 1, texture);
		add(Unicorn2);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Unicorn1.y >= 432 || Unicorn1.y <= 80 || Unicorn1.x <= 16 || Unicorn1.x >= 608)
		{
			Unicorn1.stopMovement();
		}
		if (Unicorn2.y >= 432 || Unicorn2.y <= 80 || Unicorn2.x <= 16 || Unicorn2.x >= 608)
		{
			Unicorn2.stopMovement();
		}
	}
}
