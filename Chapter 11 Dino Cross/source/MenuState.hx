package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.gamepad.FlxGamepad;
import flixel.text.FlxText;

/**
 * Basic Menu State. Just asks for the player to press start to start the game
 */
class MenuState extends FlxState
{
	static var controller:FlxGamepad;

	private var background:FlxSprite;
	private var header:FlxText;
	private var start:FlxText;

	override public function create()
	{
		super.create();
		// we don't need the mouse for this game
		FlxG.mouse.visible = false;

		// Add our back drop sprite to the game.
		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.trails__png, false, 320, 180);
		add(background);

		// Set up a game title
		header = new FlxText(0, 16, 320, "Dino Cross");
		header.size = 36;
		header.alignment = "center";
		header.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(header);

		// Set up a game start text
		start = new FlxText(0, 100, 320, "Press Start");
		start.size = 24;
		start.alignment = "center";
		start.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(start);

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

		// wait for the player to hit start
		if (FlxG.gamepads.numActiveGamepads > 0)
		{
			if (controller.justPressed.START)
			{
				FlxG.switchState(new PlayState());
			}
		}
		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.switchState(new PlayState());
		}
	}
}
