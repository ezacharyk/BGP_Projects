package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * Basic Menu State. Just asks for the player to press start to start the game
 */
class GameOverState extends FlxState
{

	private var background:FlxSprite;
	private var header:FlxText;
	private var start:FlxText;
	private var playButton:FlxButton;
	private var scoreboard:FlxSprite;
	private var target:FlxSprite;

	private var scoreTxt:FlxText;
	private var missText:FlxText;

	override public function create()
	{
		super.create();
		// we don't need the mouse for this game
		FlxG.mouse.visible = false;

		// Add our back drop sprite to the game.
		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.kitchen__png, false, 320, 180);
		add(background);

		// Set up a game over text
		header = new FlxText(0, 16, 320, "Game Over");
		header.size = 36;
		header.alignment = "center";
		header.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(header);

		// Set up a game start over text
		start = new FlxText(0, 100, 320, "You missed too many bugs!");
		start.size = 16;
		start.alignment = "center";
		start.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(start);

		//We create a FlxButton object which when clicked will start the game.
		playButton = new FlxButton(0, 0, "Play Again", onButtonClicked);
		playButton.screenCenter();
		playButton.y = 150;
		add(playButton);

		// Add our back drop sprite to the game.
		scoreboard = new FlxSprite(0, 164);
		scoreboard.loadGraphic(AssetPaths.score__png, false, 12, 12);
		add(scoreboard);
		// Set up a scoreboard in the bottom left of the screen
		scoreTxt = new FlxText(0, 164, 48, Std.string(Reg.hits));
		scoreTxt.size = 8;
		scoreTxt.alignment = "right";
		scoreTxt.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(scoreTxt);

		// Add our back drop sprite to the game.
		scoreboard = new FlxSprite(80, 164);
		scoreboard.loadGraphic(AssetPaths.miss__png, false, 12, 12);
		add(scoreboard);
		// Set up a scoreboard in the bottom left of the screen
		missText = new FlxText(80, 164, 48, Std.string(Reg.misses));
		missText.size = 8;
		missText.alignment = "right";
		missText.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(missText);

		// We create a target sprite and set its position to that of the sprite, with an offset.
		target = new FlxSprite(0, 0);
		target.loadGraphic(AssetPaths.target__png, false, 32, 32);
		target.x = FlxG.mouse.x - 16;
		target.y = FlxG.mouse.y - 16;
		add(target);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		//Our Target needs to follow the sprite.
		target.x = FlxG.mouse.x - 16;
		target.y = FlxG.mouse.y - 16;
	}

	public function onButtonClicked()
	{
		//we reset our score and miss counters
		Reg.hits = 0;
		Reg.misses = 0;
		//we use the switchstate function to change to our playstate.
		FlxG.switchState(new PlayState());
	}
}
