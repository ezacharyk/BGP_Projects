package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionManager;
import flixel.math.FlxPoint;

class UFO extends FlxSprite
{
	// We define the speed of our ufo
	static inline var SPEED:Float = 200;
	static var actions:FlxActionManager;

	private var stopThrust:Float = 1;

	// these are our new input watchers.
	var _up:FlxActionDigital;
	var _down:FlxActionDigital;
	var _left:FlxActionDigital;
	var _right:FlxActionDigital;
	var _warp:FlxActionDigital;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		// X,Y: Starting coordinates
		super(X, Y);

		// we load in the frames collection and use it as the base sprite.
		frames = Texture; // frames is a variable inhereted from FlxSprite
		// just like we did in the slideshow, we create some animations based on the frame collection
		animation.add("hover", [0], 1, true);
		animation.add("thrust", [1], 1, true);

		// we play our default animation
		animation.play("hover");
		// we define the drag of our ufo so that it stops when we stop pushing keys
		drag.x = drag.y = 1600;
		setSize(8, 8);

		// in the following lines, we create event watchers. They will look at specific button presses and let us know when it is triggered.
		_up = new FlxActionDigital().addGamepad(DPAD_UP, PRESSED)
			.addGamepad(LEFT_STICK_DIGITAL_UP, PRESSED)
			.addKey(UP, PRESSED)
			.addKey(W, PRESSED);

		_down = new FlxActionDigital().addGamepad(DPAD_DOWN, PRESSED)
			.addGamepad(LEFT_STICK_DIGITAL_DOWN, PRESSED)
			.addKey(DOWN, PRESSED)
			.addKey(S, PRESSED);

		_left = new FlxActionDigital().addGamepad(DPAD_LEFT, PRESSED)
			.addGamepad(LEFT_STICK_DIGITAL_LEFT, PRESSED)
			.addKey(LEFT, PRESSED)
			.addKey(A, PRESSED);

		_right = new FlxActionDigital().addGamepad(DPAD_RIGHT, PRESSED)
			.addGamepad(LEFT_STICK_DIGITAL_RIGHT, PRESSED)
			.addKey(RIGHT, PRESSED)
			.addKey(D, PRESSED);

		_warp = new FlxActionDigital().addGamepad(A, JUST_PRESSED).addKey(SPACE, JUST_PRESSED);

		// here, we add the defined action watchers to the game itself.
		if (actions == null)
			actions = FlxG.inputs.add(new FlxActionManager());
		actions.addActions([_up, _down, _left, _right, _warp]);
	}

	override function update(elapsed:Float)
	{
		// we define a movement function and call it from here to keep the update function clean and easy to read
		updateMovement(elapsed);
		super.update(elapsed);
	}

	function updateMovement(elapsed:Float)
	{
		// we define some variables to help us track which way our ufo is moving
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		// we determine which way our ufo is moving based on which keys are pressed
		// We also added controller input for each movement direction.
		up = _up.triggered;
		down = _down.triggered;
		left = _left.triggered;
		right = _right.triggered;

		// we cancel out when opposite keys are pressed
		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		// if we are moving in any direction we calculate the speed and angle
		if (up || down || left || right)
		{
			// we keep playing the hover animation by default
			animation.play("hover");
			var newAngle:Float = 0;
			if (up)
			{
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;
				facing = UP;
				// if we are moving up, we want to play the thrust animation.
				animation.play("thrust");
				stopThrust = .1;
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
		else
		{
			// if we are no longer moving, we want to shut off the thrust animation if it is playing.
			stopThrust -= elapsed;
			if (stopThrust < 0)
			{
				stopThrust = .1;
				animation.play("hover");
			}
		}

		// This is just for fun. If the player presses the A button on the controller, we warp the UFO to a random position on the screen.
		if (_warp.triggered)
		{
			x = Std.int(Math.random() * (640 - width));
			y = Std.int(Math.random() * (360 - height));
		}
	}
}
