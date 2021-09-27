package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class UFO extends FlxSprite
{
	// We define the speed of our ufo
	static inline var SPEED:Float = 200;

	public function new(X:Int, Y:Int)
	{
		// X,Y: Starting coordinates
		super(X, Y);

		// load the png in the assets folder into the sprite object on creation.
		loadGraphic(AssetPaths.ufo__png, false, 32, 32);

		// we define the drag of our ufo so that it stops when we stop pushing keys
		drag.x = drag.y = 1600;
		setSize(8, 8);
	}

	override function update(elapsed:Float)
	{
		// we define a movement function and call it from here to keep the update function clean and easy to read
		updateMovement();
		super.update(elapsed);
	}

	function updateMovement()
	{
		// we define some variables to help us track which way our ufo is moving
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		// we determine which way our ufo is moving based on which keys are pressed
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		// we cancel out when opposite keys are pressed
		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		// if we are moving in any direction we calculate the speed and angle
		if (up || down || left || right)
		{
			var newAngle:Float = 0;
			if (up)
			{
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;
				facing = UP;
			}
			else if (down)
			{
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;
				facing = DOWN;
			}
			else if (left)
			{
				newAngle = 180;
				facing = LEFT;
			}
			else if (right)
			{
				newAngle = 0;
				facing = RIGHT;
			}

			// we determine our velocity based on angle and speed
			velocity.set(SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), newAngle);
		}
	}
}
