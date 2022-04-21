package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionManager;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Unicorn extends FlxSprite
{
	// We define the speed of our ufo
	static inline var SPEED:Float = 200;
	static var actions:FlxActionManager;
	static var controller:FlxGamepad;

	public var lines:FlxTypedGroup<FlxSprite>;
	public var line:FlxSprite;

	private var breakPoint:FlxPoint;

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

		lines = new FlxTypedGroup();
		line = new FlxSprite();
		breakPoint = new FlxPoint(x + 6, y + 8);

		setSize(16, 16);
		if (FlxG.gamepads.numActiveGamepads > gamepadID)
		{
			controller = FlxG.gamepads.getByID(gamepadID);
			if (controller.model != XINPUT)
			{
				controller.model = XINPUT;
			}
		}

		if (player == 0)
		{
			facing = UP;
			angle = 0;
			velocity.set(SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), -90);

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
			facing = DOWN;
			angle = 180;
			velocity.set(SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), 90);

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
		if (health > 0)
		{
			drawLine();
			// we define some variables to help us track which way our ufo is moving
			var up:Bool = false;
			var down:Bool = false;
			var left:Bool = false;
			var right:Bool = false;

			// we determine which way our ufo is moving based on which keys are pressed
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

			// if we are moving in any direction we calculate the speed and angle
			if (up || down || left || right)
			{
				// we keep playing the hover animation by default
				var newAngle:Float = 0;
				if (up)
				{
					newAngle = -90;
					facing = UP;
					angle = 0;
				}
				else if (down)
				{
					newAngle = 90;
					facing = DOWN;
					angle = 180;
				}
				else if (left)
				{
					newAngle = 180;
					facing = LEFT;
					angle = 270;
				}
				else if (right)
				{
					newAngle = 0;
					facing = RIGHT;
					angle = 90;
				}

				// we determine our velocity based on angle and speed
				velocity.set(SPEED, 0);
				velocity.rotate(FlxPoint.weak(0, 0), newAngle);
			}
		}
	}

	public function stopMovement()
	{
		velocity.set(0, 0);
		health = 0;
	}

	private function drawLine()
	{
		// Create a line style, similar to CSS border styling
		var lineStyle:LineStyle = {color: FlxColor.YELLOW, thickness: 6};
		var playerLoc:FlxPoint = new FlxPoint(x + 6, y + 8);
		var minx:Int = FlxMath.minInt(Std.int(playerLoc.x), Std.int(breakPoint.x));
		var maxx:Int = FlxMath.maxInt(Std.int(playerLoc.x), Std.int(breakPoint.x));
		var miny:Int = FlxMath.minInt(Std.int(playerLoc.y), Std.int(breakPoint.y));
		var maxy:Int = FlxMath.maxInt(Std.int(playerLoc.y), Std.int(breakPoint.y));
		line = new FlxSprite(minx, miny);
		line.makeGraphic(6, maxy - miny, FlxColor.TRANSPARENT, true);
		FlxSpriteUtil.drawLine(line, 0, 0, maxx - minx, maxy - miny, lineStyle);
	}
}
