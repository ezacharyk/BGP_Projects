package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	// Creating a reusable text object
	private var text:FlxText;

	// creating counters for various aspects of the game
	private var flakeTime:Float = .2;
	private var totalFlakes:Int;
	private var numFlakes:Int;

	override public function create()
	{
		super.create();

		/*
			This message indicated the start of the blizzard. 
			In this, we set the text, the location, the size, and the alignment
			Then we add it to the game state.
		 */
		text = new FlxText(0, 0, 640, "The Blizzard Is Coming!");
		text.size = 16;
		text.alignment = "center";
		add(text);

		// Blizzards are unpredictable. We should not know how many flakes we get. Create a random number of them
		totalFlakes = Std.int(Math.random() * 1000);

		// A counter so that we know how many flakes we have generated
		numFlakes = 0;
	}

	override public function update(elapsed:Float)
	{
		// This function is called so that all parent processes in the game engine are called.
		super.update(elapsed);

		// Keep adding snowflakes if we are under the randomly generated total
		if (numFlakes < totalFlakes)
		{
			// this timer tracks when it is time to generate a new flake
			flakeTime -= FlxG.elapsed;

			// if we have reached 0 (or below) generate a snowflake
			if (flakeTime < 0)
			{
				// call the function that handles this for us.
				drawSnowflake();
			}
		}
		else
		{
			// The Blizzard is over. Alert the player by overwriting the text of the message.
			text.text = "The Blizzard Is Over!";
		}
	}

	private function drawSnowflake():Void
	{
		// Create a new snowflake Sprite. Set its position to a random point on the screen.
		var snowflake:Snowflake = new Snowflake(Std.int(Math.random() * 620), Std.int(Math.random() * 440) + 20);
		// Add the snowflake to the game state
		add(snowflake);
		// update the number of flakes we have.
		numFlakes++;
		// Reset the timer
		flakeTime = .2;
	}
}
