package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionManager;
import flixel.system.FlxSound;

enum MoveDirection
{
	UP;
	DOWN;
	LEFT;
	RIGHT;
}

class Compy extends FlxSprite
{
	/**
	 * How big the tiles of the tilemap are.
	 */
	static inline var TILE_SIZE:Int = 8;

	/**
	 * How many pixels to move each frame. Has to be a divider of TILE_SIZE
	 * to work as expected (move one block at a time), because we use the
	 * modulo-operator to check whether the next block has been reached.
	 */
	static inline var MOVEMENT_SPEED:Int = 2;

	/**
	 * Flag used to check if char is moving.
	 */
	public var moveToNextTile:Bool;

	/**
	 * Var used to hold moving direction.
	 */
	var moveDirection:MoveDirection;

	// We define the speed of our ufo
	static var actions:FlxActionManager;

	// these are our new input watchers.
	var _up:FlxActionDigital;
	var _down:FlxActionDigital;
	var _left:FlxActionDigital;
	var _right:FlxActionDigital;

	var stepSound:FlxSound;

	public var lives:Int = 3;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		// X,Y: Starting coordinates
		super(X, Y);

		// we load in the frames collection and use it as the base sprite.
		frames = Texture; // frames is a variable inhereted from FlxSprite
		// just like we did in the slideshow, we create some animations based on the frame collection
		animation.add("idle", [0, 1], 1, true);
		animation.add("jump", [2], 1, false);

		// we play our default animation
		animation.play("idle");

		setFacingFlip(RIGHT, false, false);
		setFacingFlip(LEFT, true, false);

		// we generate our sound for the compy movement.
		stepSound = FlxG.sound.load(AssetPaths.compy_jump__wav, 0.4);

		// we define the drag of our compy so that it stops when we stop pushing keys
		setSize(16, 16);

		// in the following lines, we create event watchers. They will look at specific button presses and let us know when it is triggered.
		_up = new FlxActionDigital().addGamepad(DPAD_UP, JUST_RELEASED)
			.addGamepad(LEFT_STICK_DIGITAL_UP, JUST_RELEASED)
			.addKey(UP, JUST_RELEASED)
			.addKey(W, JUST_RELEASED);

		_down = new FlxActionDigital().addGamepad(DPAD_DOWN, JUST_RELEASED)
			.addGamepad(LEFT_STICK_DIGITAL_DOWN, JUST_RELEASED)
			.addKey(DOWN, JUST_RELEASED)
			.addKey(S, JUST_RELEASED);

		_left = new FlxActionDigital().addGamepad(DPAD_LEFT, JUST_RELEASED)
			.addGamepad(LEFT_STICK_DIGITAL_LEFT, JUST_RELEASED)
			.addKey(LEFT, JUST_RELEASED)
			.addKey(A, JUST_RELEASED);

		_right = new FlxActionDigital().addGamepad(DPAD_RIGHT, JUST_RELEASED)
			.addGamepad(LEFT_STICK_DIGITAL_RIGHT, JUST_RELEASED)
			.addKey(RIGHT, JUST_RELEASED)
			.addKey(D, JUST_RELEASED);

		// here, we add the defined action watchers to the game itself.
		if (actions == null)
			actions = FlxG.inputs.add(new FlxActionManager());
		actions.addActions([_up, _down, _left, _right]);
	}

	override function update(elapsed:Float)
	{
		// Move the player to the next block
		if (moveToNextTile)
		{
			switch (moveDirection)
			{
				case UP:
					y -= MOVEMENT_SPEED;
				case DOWN:
					y += MOVEMENT_SPEED;
				case LEFT:
					x -= MOVEMENT_SPEED;
				case RIGHT:
					x += MOVEMENT_SPEED;
			}
		}

		// Check if the player has now reached the next block
		if ((x % TILE_SIZE == 0) && (y % TILE_SIZE == 0))
		{
			moveToNextTile = false;
			animation.play("idle");
		}
		// we define a movement function and call it from here to keep the update function clean and easy to read
		updateMovement(elapsed);
		super.update(elapsed);
	}

	function updateMovement(elapsed:Float)
	{
		// we define some variables to help us track which way our compy is moving
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		// we determine which way our compy is moving based on which keys are pressed
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
		// we only need to move if we are alive and if we are not at the end
		if ((up || down || left || right) && x < 256 && health > 0)
		{
			// we keep playing the jump animation by default
			animation.play("jump");
			// when the player moves, we want to play the compy movement sound
			stepSound.play();
			if (up)
			{
				if (y > 16)
				{
					moveTo(MoveDirection.UP);
				}
			}
			else if (down)
			{
				if (y < 148)
				{
					moveTo(MoveDirection.DOWN);
				}
			}
			else if (left)
			{
				facing = LEFT;
				if (x > 16)
				{
					moveTo(MoveDirection.LEFT);
				}
			}
			else if (right)
			{
				facing = RIGHT;
				if (x < 256)
				{
					moveTo(MoveDirection.RIGHT);
				}
			}
		}
	}

	public function moveTo(Direction:MoveDirection):Void
	{
		// Only change direction if not already moving
		if (!moveToNextTile)
		{
			if (Direction == LEFT)
			{
				facing = LEFT;
			}
			else if (Direction == LEFT)
			{
				facing = RIGHT;
			}
			moveDirection = Direction;
			moveToNextTile = true;
		}
	}
}
