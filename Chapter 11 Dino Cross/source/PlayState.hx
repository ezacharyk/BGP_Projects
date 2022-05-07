package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.text.FlxText;
import flixel.util.FlxCollision;

class PlayState extends FlxState
{
	private var texture:FlxFramesCollection;
	private var background:FlxSprite;
	private var compy:Compy;
	private var score:Int = 0;
	private var scoreboard:FlxText;
	private var resetTimer:Float = 1;
	private var dinosaurs:FlxTypedGroup<Dinosaur>;
	private var triceratops:Dinosaur;
	private var stegasaurus:Dinosaur;
	private var velociraptor:Dinosaur;
	private var tyranosaurus:Dinosaur;
	private var lives:FlxTypedGroup<FlxSprite>;
	private var life:FlxSprite;
	private var gameOver:Bool = false;
	private var header:FlxText;
	private var start:FlxText;
	private var wins:Int = 0;

	static var controller:FlxGamepad;

	override public function create()
	{
		super.create();
		// we don't need the mouse for this game
		FlxG.mouse.visible = false;

		// Create a nice background
		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.trails__png, false, 320, 180);
		add(background);

		// we create our ufo
		compy = new Compy(32, 80, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.compy__png, AssetPaths.compy__json));
		add(compy);
		updateLives();

		addDinos();

		// Set up a game title
		scoreboard = new FlxText(0, 164, 48, "0");
		scoreboard.size = 8;
		scoreboard.alignment = "right";
		scoreboard.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(scoreboard);

		if (FlxG.gamepads.numActiveGamepads > 0)
		{
			controller = FlxG.gamepads.getByID(0);
			if (controller.model != XINPUT)
			{
				controller.model = XINPUT;
			}
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (!gameOver)
		{
			checkCollisions();
			if (compy.x >= 256 || compy.health == 0)
			{
				resetTimer -= elapsed;
			}
			if (resetTimer <= 0)
			{
				resetTimer = 1;
				if (compy.health > 0)
				{
					wins += 1;
					score += 10 * wins;
					scoreboard.text = Std.string(score);
				}
				else
				{
					compy.health = 1;
					remove(lives);
					updateLives();
				}
				compy.x = 32;
				compy.y = 80;
			}
		}
		else
		{
			if (resetTimer <= 0)
			{
				goToGameOver();
			}
			else
			{
				resetTimer -= elapsed;
			}
		}
	}

	private function checkCollisions()
	{
		// we check if either player collides with any line in hte line Group.
		for (dino in dinosaurs)
		{
			if (compy.health > 0)
			{
				if (FlxCollision.pixelPerfectCheck(dino, compy))
				{
					compy.health = 0;
					compy.lives -= 1;
					if (compy.lives == 0)
					{
						gameOver = true;
					}
				}
			}
		}
	}

	private function addDinos()
	{
		dinosaurs = new FlxTypedGroup();
		add(dinosaurs);
		// we create our ufo
		triceratops = new Dinosaur(48, 164, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.triceratops__png, AssetPaths.triceratops__json));
		triceratops.setUpTriceratops();
		dinosaurs.add(triceratops);
		// we create our ufo
		triceratops = new Dinosaur(80, 16, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.triceratops__png, AssetPaths.triceratops__json));
		triceratops.setDownTriceratops();
		dinosaurs.add(triceratops);
		// we create our ufo
		stegasaurus = new Dinosaur(112, 32, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.stegasaurus__png, AssetPaths.stegasaurus__json));
		stegasaurus.setUpStegasaurus();
		dinosaurs.add(stegasaurus);
		// we create our ufo
		stegasaurus = new Dinosaur(112, 128, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.stegasaurus__png, AssetPaths.stegasaurus__json));
		stegasaurus.setUpStegasaurus();
		dinosaurs.add(stegasaurus);
		// we create our ufo
		velociraptor = new Dinosaur(160, 0, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.velociraptor__png, AssetPaths.velociraptor__json));
		velociraptor.setDownVelociraptor();
		dinosaurs.add(velociraptor);
		// we create our ufo
		velociraptor = new Dinosaur(176, 64, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.velociraptor__png, AssetPaths.velociraptor__json));
		velociraptor.setDownVelociraptor();
		dinosaurs.add(velociraptor);
		// we create our ufo
		velociraptor = new Dinosaur(160, 128, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.velociraptor__png, AssetPaths.velociraptor__json));
		velociraptor.setDownVelociraptor();
		dinosaurs.add(velociraptor);

		// we create our ufo
		tyranosaurus = new Dinosaur(192, 128, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.tyranosaurus__png, AssetPaths.tyranosaurus__json));
		tyranosaurus.setUpTyranosaurus();
		dinosaurs.add(tyranosaurus);

		// we create our ufo
		velociraptor = new Dinosaur(240, 20, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.velociraptor__png, AssetPaths.velociraptor__json));
		velociraptor.setDownVelociraptor();
		dinosaurs.add(velociraptor);
		// we create our ufo
		velociraptor = new Dinosaur(224, 84, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.velociraptor__png, AssetPaths.velociraptor__json));
		velociraptor.setDownVelociraptor();
		dinosaurs.add(velociraptor);
		// we create our ufo
		velociraptor = new Dinosaur(240, 148, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.velociraptor__png, AssetPaths.velociraptor__json));
		velociraptor.setDownVelociraptor();
		dinosaurs.add(velociraptor);
	}

	private function updateLives()
	{
		lives = new FlxTypedGroup();
		add(lives);

		for (i in 0...compy.lives)
		{
			life = new FlxSprite(8 * i, 8);
			life.loadGraphic(AssetPaths.life__png, false, 8, 8);
			lives.add(life);
		}
	}

	private function goToGameOver()
	{
		FlxG.switchState(new GameOverState());
	}
}
