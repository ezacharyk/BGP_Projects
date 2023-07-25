package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.sound.FlxSound;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	private var background:FlxSprite;
	private var scoreboard:FlxSprite;
	private var target:FlxSprite;

	private var scoreTxt:FlxText;
	private var missText:FlxText;

	var roach1:Roach;
	var roach2:Roach;
	var ant1:Ant;
	var ant2:Ant;
	var fly1:Fly;
	var fly2:Fly;
	var spider1:Spider;
	var spider2:Spider;

	var timer:Float = 0;
	var trigger:Float = 2;

	override public function create()
	{
		super.create();
		//We turn the default mouse cursor off.
		FlxG.mouse.visible = false;

		// Add our back drop sprite to the game.
		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.kitchen__png, false, 320, 180);
		add(background);

		//We call our funct to add bugs. This is defined below.
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

		// We create a target sprite and set its position to that of the sprite, with an offset.
		target = new FlxSprite(0, 0);
		target.loadGraphic(AssetPaths.target__png, false, 32, 32);
		target.x = FlxG.mouse.x - 8;
		target.y = FlxG.mouse.y - 8;
		add(target);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		//Our Target needs to follow the sprite.
		target.x = FlxG.mouse.x - 8;
		target.y = FlxG.mouse.y - 8;

		//Keep our score and miss values display updated.
		scoreTxt.text = Std.string(Reg.hits);
		missText.text = Std.string(Reg.misses);

		if(Reg.misses >= 10)
		{
			FlxG.switchState(new GameOverState());
		}

		//We use a timer to spawn in bugs It starts at every 2 seconds.
		timer += elapsed;
		if(timer >= trigger)
		{
			timer = 0; //reset our timer
			trigger -= .01; //make our trigger shorter each time a bug is spawned.
			switch(FlxG.random.int(0,7))
			{
				case(0):
					if(!ant1.alive) //we only spawn in a bug if it is not currently alive
					{
						ant1.facing = LEFT;//For the ant, we need to rest what direction it is facing
						ant1.revive();
					}
				case(1):
					if(!ant2.alive)
					{
						ant2.facing = RIGHT;
						ant2.revive();
					}
				case(2):
					if(!roach1.alive)
					{
						roach1.revive();
					}
				case(3):
					if(!roach2.alive)
					{
						roach2.revive();
					}
				case(4):
					if(!spider1.alive)
					{
						spider1.revive();
					}
				case(5):
					if(!spider2.alive)
					{
						spider2.revive();
					}
				case(6):
					if(!fly1.alive)
					{
						fly1.revive();
						fly1.setTween();//For the fly, we need to start its tween
					}
				case(7):
					if(!fly2.alive)
					{
						fly2.revive();
						fly2.setTween();
					}
			}
		}

	}

	private function addBugs()
	{
		//In this function, we create our bugs. We set some default values, add them to the state, then kill them off until we spawn them above.
		ant1 = new Ant(0, 0, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		ant1.facing = LEFT;
		add(ant1);
		ant1.kill();
		ant2 = new Ant(288, 80, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		add(ant2);
		ant2.kill();

		roach1 = new Roach(96, 48, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		roach1.facing = LEFT;
		add(roach1);
		roach1.kill();
		roach2 = new Roach(176, 96, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		add(roach2);
		roach2.kill();

		fly1 = new Fly(-16, 96, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		fly1.facing = LEFT;
		add(fly1);
		fly1.kill();
		fly2 = new Fly(320, 128, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		add(fly2);
		fly2.kill();

		spider1 = new Spider(24, 128, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		spider1.facing = UP;
		add(spider1);
		spider1.kill();
		spider2 = new Spider(272, 0, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.bugs__png, AssetPaths.bugs__json));
		spider2.facing = DOWN;
		add(spider2);
		spider2.kill();
	}
}
