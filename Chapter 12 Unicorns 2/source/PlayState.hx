package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxCollision;
import flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	private var background:FlxSprite;
	private var header:FlxText;

	private var lines:FlxTypedGroup<FlxSprite>;
	private var line1Temp:FlxSprite;
	private var line1:FlxSprite;
	private var line2Temp:FlxSprite;
	private var line2:FlxSprite;

	private var Unicorn1:Unicorn;
	private var Unicorn2:Unicorn;
	private var texture:FlxFramesCollection;

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

		// This group keeps track of all the lines that have been drawn on the screen.
		lines = new FlxTypedGroup();
		add(lines);

		// Our game requires a few temp lines to allow for drawing and collision detection.
		// This line is the one that will be drawn by player one as they are moving.
		line1Temp = new FlxSprite();
		line1Temp.makeGraphic(FlxG.width, FlxG.height, 0, true);
		add(line1Temp);
		// This line is the where the temp line moves to when the player changes direction and starts drawing a new line.
		line1 = new FlxSprite();
		line1.makeGraphic(FlxG.width, FlxG.height, 0, true);

		// Same as above but for player 2.
		line2Temp = new FlxSprite();
		line2Temp.makeGraphic(FlxG.width, FlxG.height, 0, true);
		add(line2Temp);
		line2 = new FlxSprite();
		line2.makeGraphic(FlxG.width, FlxG.height, 0, true);

		// we create a texture fram collection from our sprite and the associated json file.
		texture = FlxAtlasFrames.fromTexturePackerJson(AssetPaths.unicorns__png, AssetPaths.unicorns__json);
		// we create our unicorn for player 1
		Unicorn1 = new Unicorn(312, 416, 0, 0, texture);
		add(Unicorn1);
		// we create our unicorn for player 2
		Unicorn2 = new Unicorn(312, 96, 2, 1, texture);
		add(Unicorn2);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		checkCollisions();
		drawLine(1);
		drawLine(2);
	}

	/**
	 * This function checks all the collisions for the players.
	 */
	private function checkCollisions()
	{
		// we check if either player collides with any line in hte line Group.
		for (line in lines)
		{
			if (FlxCollision.pixelPerfectCheck(line, Unicorn1))
			{
				Unicorn1.stopMovement();
				FlxG.switchState(new WinState(2));
			}
			if (FlxCollision.pixelPerfectCheck(line, Unicorn2))
			{
				Unicorn2.stopMovement();
				FlxG.switchState(new WinState(1));
			}
		}
		// The next set of if statements checks if either player collides with either of the other player's temp lines.
		// We don't check if the player collides with their own temp lines
		if (FlxCollision.pixelPerfectCheck(line2, Unicorn1))
		{
			Unicorn1.stopMovement();
			FlxG.switchState(new WinState(2));
		}
		if (FlxCollision.pixelPerfectCheck(line1, Unicorn2))
		{
			Unicorn2.stopMovement();
			FlxG.switchState(new WinState(1));
		}
		if (FlxCollision.pixelPerfectCheck(line2Temp, Unicorn1))
		{
			Unicorn1.stopMovement();
			FlxG.switchState(new WinState(2));
		}
		if (FlxCollision.pixelPerfectCheck(line1Temp, Unicorn2))
		{
			Unicorn2.stopMovement();
			FlxG.switchState(new WinState(1));
		}

		// We check if either player hits the outer edge of the arena
		if (Unicorn1.y >= 432 || Unicorn1.y <= 80 || Unicorn1.x <= 16 || Unicorn1.x >= 608)
		{
			Unicorn1.stopMovement();
			FlxG.switchState(new WinState(2));
		}
		if (Unicorn2.y >= 432 || Unicorn2.y <= 80 || Unicorn2.x <= 16 || Unicorn2.x >= 608)
		{
			Unicorn2.stopMovement();
			FlxG.switchState(new WinState(1));
		}
	}

	/**
	 * This function draws the line behind each player
	 * @param player 
	 */
	private function drawLine(player:Int)
	{
		if (player == 1)
		{
			// If the player has changed directions within the last frame, we need to shuffle some lines around.
			if (Unicorn1.changeDir == true)
			{
				// set the CHangeDir variable to false so this doesn't trigger again until the player changes direction again.
				Unicorn1.changeDir = false;

				// breakPoint stores the far end of the line and we need to reset it to the last position of the player for the new line.
				Unicorn1.breakPoint.x = Unicorn1.x + Unicorn1.origin.x;
				Unicorn1.breakPoint.y = Unicorn1.y + Unicorn1.origin.y;

				// Add line1 to the game state and set it to the value of the line1Temp object
				lines.add(line1);
				line1 = line1Temp;

				// Create a new line1Temp Object
				line1Temp = new FlxSprite();
				line1Temp.makeGraphic(FlxG.width, FlxG.height, 0, true);

				// We remove the Unicorn object from the state temporaily so that the line gets added below it. Otherwise, the line would be on top of the Unicorn
				remove(Unicorn1, true);
				add(line1Temp);
				// add the unicorn back to the state.
				add(Unicorn1);
			}

			// draws a blank canvas on top of the line1Temp sprite
			FlxSpriteUtil.fill(line1Temp, 0);

			// Draws a new line onto the canvas from the end of the unicorn to the breakpoint.
			FlxSpriteUtil.drawLine(line1Temp, Unicorn1.x + Unicorn1.origin.x, Unicorn1.y + Unicorn1.origin.y, Unicorn1.breakPoint.x, Unicorn1.breakPoint.y, {
				thickness: 5,
				color: 0xFFF95FF5
			});
		}

		// Everything we did above for Player 1 we do now for player 2.
		if (player == 2)
		{
			if (Unicorn2.changeDir == true)
			{
				Unicorn2.changeDir = false;
				Unicorn2.breakPoint.x = Unicorn2.x + Unicorn2.origin.x;
				Unicorn2.breakPoint.y = Unicorn2.y + Unicorn2.origin.y;
				lines.add(line2);
				line2 = line2Temp;
				line2Temp = new FlxSprite();
				line2Temp.makeGraphic(FlxG.width, FlxG.height, 0, true);
				remove(Unicorn2, true);
				add(line2Temp);
				add(Unicorn2);
			}
			FlxSpriteUtil.fill(line2Temp, 0);

			FlxSpriteUtil.drawLine(line2Temp, Unicorn2.x + Unicorn2.origin.x, Unicorn2.y + Unicorn2.origin.y, Unicorn2.breakPoint.x, Unicorn2.breakPoint.y, {
				thickness: 5,
				color: 0xFF690A8D
			});
		}
	}
}
