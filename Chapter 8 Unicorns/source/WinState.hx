package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.gamepad.FlxGamepad;
import flixel.text.FlxText;

/**
 * Basic Win State. Receives the winning player number as a parameter. Displays which player won. Asks the players to press start to play again.
 */
class WinState extends FlxState
{
	static var controller:FlxGamepad;

	private var background:FlxSprite;
	private var header:FlxText;
	private var win:FlxText;
	private var start:FlxText;

	private var winner:Int;

	public function new(i:Int)
	{
		super();
		winner = i;
	}

	override public function create()
	{
		super.create();
		// we don't need the mouse for this game
		FlxG.mouse.visible = false;

		// Add our back drop sprite to the game.
		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.background__png, false, 640, 360);
		add(background);

		// Set up a game title
		header = new FlxText(0, 10, 630, "Unicorn Dash!");
		header.size = 36;
		header.alignment = "center";
		header.color = 0xFF7585FF;
		// header.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(header);

		// Set up a game title
		win = new FlxText(0, 150, 630, "Unicorn " + winner + " Wins!");
		win.size = 48;
		win.alignment = "center";
		win.color = 0xFF7585FF;
		// header.setBorderStyle(OUTLINE, 0xFF897A89, 2);
		add(win);

		// Set up a game title
		start = new FlxText(0, 300, 630, "Press Start to Play Again");
		start.size = 36;
		start.alignment = "center";
		start.color = 0xFF7585FF;
		// header.setBorderStyle(OUTLINE, 0xFF897A89, 2);
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
