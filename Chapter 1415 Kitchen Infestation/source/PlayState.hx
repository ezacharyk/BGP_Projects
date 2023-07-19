package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.system.FlxSound;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	private var background:FlxSprite;
	private var scoreboard:FlxSprite;
	private var target:FlxSprite;

	private var scoreTxt:FlxText;
	private var missText:FlxText;

	var splat1Sound:FlxSound;
	var splat2Sound:FlxSound;
	var splat3Sound:FlxSound;

	var roach1:Roach;
	var roach2:Roach;
	var ant1:Ant;
	var ant2:Ant;
	var fly1:Fly;
	var fly2:Fly;
	var spider1:Spider;
	var spider2:Spider;

	override public function create()
	{
		super.create();
		// use the load function to change the mouse cursor to our custom one. We also need to offset it by 16 pixels to center it.
		FlxG.mouse.visible = false;

		// Add our back drop sprite to the game.
		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.kitchen__png, false, 320, 180);
		add(background);

		// we generate our sounds for the splats around. We have 3 and will randomize which one plays.
		splat1Sound = FlxG.sound.load(AssetPaths.splat1__wav, 0.2);
		splat2Sound = FlxG.sound.load(AssetPaths.splat2__wav, 0.2);
		splat3Sound = FlxG.sound.load(AssetPaths.splat3__wav, 0.2);

		addBugs();

		// Add our back drop sprite to the game.
		scoreboard = new FlxSprite(0, 164);
		scoreboard.loadGraphic(AssetPaths.score__png, false, 12, 12);
		add(scoreboard);
		// Set up a scoreboard in the bottom left of the screen
		scoreTxt = new FlxText(0, 164, 48, "0");
		scoreTxt.size = 8;
		scoreTxt.alignment = "right";
		scoreTxt.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(scoreTxt);

		// Add our back drop sprite to the game.
		scoreboard = new FlxSprite(80, 164);
		scoreboard.loadGraphic(AssetPaths.miss__png, false, 12, 12);
		add(scoreboard);
		// Set up a scoreboard in the bottom left of the screen
		missText = new FlxText(80, 164, 48, "0");
		missText.size = 8;
		missText.alignment = "right";
		missText.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(missText);

		target = new FlxSprite(0, 0);
		target.loadGraphic(AssetPaths.target__png, false, 32, 32);
		target.x = FlxG.mouse.x - 8;
		target.y = FlxG.mouse.y - 8;
		add(target);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		target.x = FlxG.mouse.x - 8;
		target.y = FlxG.mouse.y - 8;
		scoreTxt.text = Std.string(Reg.hits);
		missText.text = Std.string(Reg.misses);
	}

	private function addBugs()
	{
		ant1 = new Ant(0, 0, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		ant1.facing = LEFT;
		add(ant1);
		ant2 = new Ant(288, 80, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		add(ant2);

		roach1 = new Roach(96, 48, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		roach1.facing = LEFT;
		add(roach1);
		roach2 = new Roach(176, 96, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		add(roach2);

		fly1 = new Fly(0, 96, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		fly1.facing = LEFT;
		add(fly1);
		fly2 = new Fly(304, 128, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		add(fly2);

		spider1 = new Spider(24, 128, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		spider1.facing = UP;
		add(spider1);
		spider2 = new Spider(272, 0, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		spider2.facing = DOWN;
		add(spider2);
	}
}
