package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	private var text:FlxText;

	// creating counters and sprites for various aspects of the game
	private var circleTime:Float = 2;
	private var totalCircles:Int;
	private var numCircles:Int;
	private var circle_1:FlxSprite;
	private var circle_2:FlxSprite;
	private var line:FlxSprite;

	override public function create()
	{
		super.create();
		FlxG.cameras.bgColor = FlxColor.fromRGBFloat(64, 64, 0, 0);
		/*
			This message indicated the start of the crop circles. 
			In this, we set the text, the location, the size, and the alignment
			Then we add it to the game state.
		 */
		text = new FlxText(0, 0, 640, "Who Created These Crop Circles?");
		text.size = 16;
		text.alignment = "center";
		add(text);

		// Crop Circles are unpredictable. We should not know how many crop circles we get. Create a random number of them
		totalCircles = Std.int(Math.random() * 20) + 10;

		// A counter so that we know how many circles we have generated
		numCircles = 0;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Keep adding crop circles if we are under the randomly generated total
		if (numCircles < totalCircles)
		{
			// this timer tracks when it is time to generate a new circle
			circleTime -= FlxG.elapsed;

			// if we have reached 0 (or below) generate a cicle
			if (circleTime < 0)
			{
				// Checks if this is the first circle
				if (numCircles == 0)
				{
					// if this is the first circle, we don't need to draw a line. We only need to initialize the first circle variable.
					circle_1 = new FlxSprite(Std.int(Math.random() * 620), Std.int(Math.random() * 440) + 20);

					// Pass the first circle variable and draw the first circle onto it.
					drawCropCircle(circle_1);
				}
				else
				{
					// Creates a new sprte and assigns it to the second circle sprite.
					circle_2 = new FlxSprite(Std.int(Math.random() * 620), Std.int(Math.random() * 440) + 20);

					// Pass the new circle sprite to the drawCropCircle function
					drawCropCircle(circle_2);

					// Pass the center cooridinates of both circles to the draCropLine function
					drawCropLine(circle_1.getGraphicMidpoint(), circle_2.getGraphicMidpoint());

					// Assign the value of the second circle to the first circle variable in preperation for the next circle to draw.
					circle_1 = circle_2;
				}
				// increment the circle counter so we don't exceed the randomly selected number of circles
				numCircles++;

				// Reset the timer
				circleTime = 2;
			}
		}
	}

	/**
	 * Draws a circle onto the provided sprite
	 *
	 * @param   FlxSprite   The sprite you want a circle drawn on
	 *                  
	 * @return  Void 		This function doesn't return anything
	 */
	private function drawCropCircle(circle:FlxSprite):Void
	{
		// Randomly creating a radius for the circle We want a minimum of 10 radius and a max of 50.
		var radius:Int = Std.int(Math.random() * 40) + 10;

		// Create a transparent graphic to act as the canvas for the circle
		circle.makeGraphic(radius * 2, radius * 2, FlxColor.TRANSPARENT, true);

		// Draw a circle onto the sprite with the radius we picked and positioned centered on the sprite.
		FlxSpriteUtil.drawCircle(circle, -1, -1, radius, FlxColor.YELLOW);

		// add the new circle to the game state
		add(circle);
	}

	/**
	 * Creates a line sprite and draws a line onto it between two circles
	 *
	 * @param   FlxPoint    The center point in the first circle
	 * @param	FlxPoint	The center point in the second circle
	 *                  
	 * @return  Void 		This function doesn't return anything
	 */
	private function drawCropLine(circle1:FlxPoint, circle2:FlxPoint):Void
	{
		// Create a line style, similar to CSS border styling
		var lineStyle:LineStyle = {color: FlxColor.YELLOW, thickness: 5};

		// Found a much better way to draw lines in the Unicron Dash game. So I am updating the code to draw lines here.

		// First we create a new sprite object positioned in the top left of the game window
		line = new FlxSprite(0, 0);
		// We make a transparent graphic the size of the window
		line.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		// We draw our line from the center of circle 1 to the center of circle 2
		FlxSpriteUtil.drawLine(line, circle1.x, circle1.y, circle2.x, circle2.y, lineStyle);
		// Add the line to the game state
		add(line);
	}
}
