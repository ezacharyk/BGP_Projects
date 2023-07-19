package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.sound.FlxSound;
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
	var stompSound:FlxSound;
	var roarSound:FlxSound;
	var winSound:FlxSound;

	override public function create()
	{
		super.create();
		// we don't need the mouse for this game
		FlxG.mouse.visible = false;

		// Create a nice background
		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.trails__png, false, 320, 180);
		add(background);

		// we create our player compy
		compy = new Compy(32, 80, FlxAtlasFrames.fromTexturePackerJson(AssetPaths.compy__png, AssetPaths.compy__json));
		add(compy);
		// this function draws the number of lives left
		updateLives();

		// add all th other dinos to the game
		addDinos();

		// We generate our sounds for the play state.
		stompSound = FlxG.sound.load(AssetPaths.dino_stomp__wav, 0.4);
		roarSound = FlxG.sound.load(AssetPaths.dino_roar__wav, 0.4);
		winSound = FlxG.sound.load(AssetPaths.compy_win__wav, 0.4);

		// Set up a scoreboard in the bottom left of the screen
		scoreboard = new FlxText(0, 164, 48, "0");
		scoreboard.size = 8;
		scoreboard.alignment = "right";
		scoreboard.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(scoreboard);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// if we aren't in a game over state, then manage the gameplay
		if (!gameOver)
		{
			// first we call out check collisions function
			checkCollisions();
			// if the player is dead or at the goal, we cycle our delay timer
			if (compy.x >= 256 || compy.health == 0)
			{
				// We only need to play the win sound once and only if we are in a win state.
				if (resetTimer == 1 && compy.x >= 256)
				{
					winSound.play();
				}
				resetTimer -= elapsed;
			}
			// if the delay timer is hit, we need to do some other things
			if (resetTimer <= 0)
			{
				// reset the delay timer
				resetTimer = 1;
				// if the compy is not dead, then we are in a win condition
				if (compy.health > 0)
				{
					// for a littel fun, we keep track of the number of times the player makes it accross and multiply the score by it.
					wins += 1;
					score += 10 * wins;
					scoreboard.text = Std.string(score);
				}
				else // the compy is dead so we need to deal with that.
				{
					// reset their health, update the number of lives left
					compy.health = 1;
					remove(lives);
					updateLives();
				}
				// either way, the compy goes back to start
				compy.x = 32;
				compy.y = 80;
			}
		}
		else // the game is over
		{
			// once the delay timer is done, go to game over
			if (resetTimer <= 0)
			{
				goToGameOver();
			}
			else // cycle the delay timer
			{
				resetTimer -= elapsed;
			}
		}
	}

	private function checkCollisions()
	{
		// we check if either player collides with any dino in the dino Group.
		for (dino in dinosaurs)
		{
			// we don't need to do anything if we have already determined the player is dead
			if (compy.health > 0)
			{
				// see if any pixel of the player has collided with any pixel of the other dinos
				if (FlxCollision.pixelPerfectCheck(dino, compy))
				{
					// if the player has hit a dino, then kill it, reduce their lives, and if their lives are 0 flag a game over.
					compy.health = 0;
					compy.lives -= 1;
					if (compy.lives == 0)
					{
						gameOver = true;
					}
					// we generate a random number to determine which of our death sounds we play.
					var stomp:Float = FlxG.random.float() * 2;
					if (stomp >= 1)
					{
						roarSound.play();
					}
					else
					{
						stompSound.play();
					}
				}
			}
		}
	}

	/**
	 * In this function we just create a whole lot of dinos and add them to the dinosaurs group. 
	 * I set them up in the order they appear on screen from left to right. Each typeof dino has a different behavior.
	 */
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

	/**
	 * This function sees how many lives the player has left and draws them to the screen.
	 */
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

	/**
	 * If the game is over, go to the game over state.
	 */
	private function goToGameOver()
	{
		FlxG.switchState(new GameOverState());
	}
}
