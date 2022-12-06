package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionManager;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Unicorn extends FlxSprite
{
	// We define the speed of our ufo
	static inline var SPEED:Float = 200;
	static var actions:FlxActionManager;
	static var controller:FlxGamepad;

	public var breakPoint:FlxPoint;
	public var changeDir:Bool = false;

	var _up:FlxActionDigital;
	var _down:FlxActionDigital;
	var _left:FlxActionDigital;
	var _right:FlxActionDigital;

	public function new(X:Int, Y:Int, player:Int, gamepadID:Int, Texture:FlxFramesCollection)
	{
		// X,Y: Starting coordinates
		super(X, Y);

		frames = Texture; // frames is a variable inhereted from FlxSprite
		// just like we did in the slideshow, we create some animations based on the frame collection
		animation.add("run", [0 + player, 1 + player], 4, true);

		// we play our default animation
		animation.play("run");

		// sets the size of the prite's hit box
		setSize(16, 16);

		// If we have gamepads connected, do some modifying of their model
		if (FlxG.gamepads.numActiveGamepads > gamepadID)
		{
			controller = FlxG.gamepads.getByID(gamepadID);
			if (controller.model != XINPUT)
			{
				controller.model = XINPUT;
			}
		}

		// Player 0 is actually player 1
		if (player == 0)
		{
			// Set the default values of a few variables
			// player 1 starts at the bottom of the screen and moves up
			facing = UP; // the current direction the player is facing
			angle = 0; // the current angle they are moving in (straight up)
			velocity.set(SPEED, 0); // Start the player moving
			velocity.pivotDegrees(FlxPoint.weak(0, 0), 90); // Rotate the sprite to the correct direction.

			// Set the breakpoint of the end of the line to the player's current position
			breakPoint = new FlxPoint(x + origin.x, y + origin.y + 16);

			// We define out player inputs.
			_up = new FlxActionDigital().addGamepad(DPAD_UP, PRESSED, gamepadID).addGamepad(LEFT_STICK_DIGITAL_UP, PRESSED, gamepadID).addKey(W, PRESSED);

			_down = new FlxActionDigital().addGamepad(DPAD_DOWN, PRESSED, gamepadID)
				.addGamepad(LEFT_STICK_DIGITAL_DOWN, PRESSED, gamepadID)
				.addKey(S, PRESSED);

			_left = new FlxActionDigital().addGamepad(DPAD_LEFT, PRESSED, gamepadID)
				.addGamepad(LEFT_STICK_DIGITAL_LEFT, PRESSED, gamepadID)
				.addKey(A, PRESSED);

			_right = new FlxActionDigital().addGamepad(DPAD_RIGHT, PRESSED, gamepadID)
				.addGamepad(LEFT_STICK_DIGITAL_RIGHT, PRESSED, gamepadID)
				.addKey(D, PRESSED);
		}
		else
		{
			// Player 2 starts at the top of the screen and faces and moves down down
			facing = DOWN;
			angle = 180;
			velocity.set(SPEED, 0);
			velocity.pivotDegrees(FlxPoint.weak(0, 0), -90);

			breakPoint = new FlxPoint(x + origin.x, y + origin.y - 16);

			_up = new FlxActionDigital().addGamepad(DPAD_UP, PRESSED, gamepadID).addGamepad(LEFT_STICK_DIGITAL_UP, PRESSED, gamepadID).addKey(UP, PRESSED);

			_down = new FlxActionDigital().addGamepad(DPAD_DOWN, PRESSED, gamepadID)
				.addGamepad(LEFT_STICK_DIGITAL_DOWN, PRESSED, gamepadID)
				.addKey(DOWN, PRESSED);

			_left = new FlxActionDigital().addGamepad(DPAD_LEFT, PRESSED, gamepadID)
				.addGamepad(LEFT_STICK_DIGITAL_LEFT, PRESSED, gamepadID)
				.addKey(LEFT, PRESSED);

			_right = new FlxActionDigital().addGamepad(DPAD_RIGHT, PRESSED, gamepadID)
				.addGamepad(LEFT_STICK_DIGITAL_RIGHT, PRESSED, gamepadID)
				.addKey(RIGHT, PRESSED);
		}

		// Add the inputs to the actiosn object
		if (actions == null)
			actions = FlxG.inputs.add(new FlxActionManager());
		actions.addActions([_up, _down, _left, _right]);
	}

	override function update(elapsed:Float)
	{
		// we define a movement function and call it from here to keep the update function clean and easy to read
		updateMovement(elapsed);
		super.update(elapsed);
	}

	function updateMovement(elapsed:Float)
	{
		// only move if the player has health
		if (health > 0)
		{
			// we define some variables to help us track which way our unicorn is moving
			var up:Bool = false;
			var down:Bool = false;
			var left:Bool = false;
			var right:Bool = false;

			// we determine which way our unicorn is moving based on which keys are pressed
			// We also added controller input above for each movement direction.
			up = _up.triggered;
			down = _down.triggered;
			left = _left.triggered;
			right = _right.triggered;

			// we cancel out when opposite keys are pressed
			if (up && down)
				up = down = false;
			if (left && right)
				left = right = false;
			// We cancel movement for trying to move in the exact oposite way we are facing.
			if (up && facing == DOWN)
				up = false;
			if (down && facing == UP)
				down = false;
			if (left && facing == RIGHT)
				left = false;
			if (right && facing == LEFT)
				right = false;

			// if the player is changing direction we flag that for the draw line function in the PlayState
			if ((facing == UP || facing == DOWN) && (left == true || right == true))
			{
				changeDir = true;
			}
			if ((facing == LEFT || facing == RIGHT) && (up == true || down == true))
			{
				changeDir = true;
			}

			// if we are moving in any direction we calculate the speed and angle
			if (up || down || left || right)
			{
				// we keep playing the hover animation by default
				var newAngle:Float = 0;
				if (up)
				{
					newAngle = 90;
					facing = UP;
					angle = 0;
				}
				else if (down)
				{
					newAngle = -90;
					facing = DOWN;
					angle = 180;
				}
				else if (left)
				{
					newAngle = 0;
					facing = LEFT;
					angle = 270;
				}
				else if (right)
				{
					newAngle = 180;
					facing = RIGHT;
					angle = 90;
				}

				// we determine our velocity based on angle and speed
				velocity.set(SPEED, 0);
				velocity.pivotDegrees(FlxPoint.weak(0, 0), newAngle);
			}
		}
	}

	public function stopMovement()
	{
		// We stop the player from moving and set its healh to 0 to prevent the updateMovement function from triggering
		velocity.set(0, 0);
		health = 0;
	}
}
