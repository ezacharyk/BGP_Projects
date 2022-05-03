package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.tweens.FlxEase.EaseFunction;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween.TweenOptions;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;

class Planet extends FlxSprite
{
	static inline var DURATION:Float = 5;

	private var name:String;
	private var dragging:Bool = false;
	var _tween:FlxTween;
	// We set a velocity
	var initial_velocity:Int = 200;

	public function new(X:Int, Y:Int, n:String)
	{
		// X,Y: Starting coordinates
		super(X, Y);

		name = n;

		// call out function to generate a random velocity
		generateVelocity();

		if (name == "Jupiter")
		{
			// load the png in the assets folder into the sprite object on creation.
			loadGraphic(AssetPaths.jupiter__png, false, 128, 128);
		}
		else if (name == "Neptune")
		{
			// load the png in the assets folder into the sprite object on creation.
			loadGraphic(AssetPaths.neptune__png, false, 96, 96);
		}
		else if (name == "Mars")
		{
			// load the png in the assets folder into the sprite object on creation.
			loadGraphic(AssetPaths.mars__png, false, 64, 96);
		}
		else
		{
			// load the png in the assets folder into the sprite object on creation.
			loadGraphic(AssetPaths.earth__png, false, 64, 96);

			// With earth, we are doing something a bit different. We want Earth to revolve around the center of the game screen.
			velocity.x = 0;
			velocity.y = 0;

			// For the motion of the earth, we are going to use the FlxTween class to apply a circular motion.
			var options:TweenOptions = {type: LOOPING, ease: FlxEase.linear};

			_tween = FlxTween.circularMotion(this, (FlxG.width * 0.5) - (this.width / 2), (FlxG.height * 0.5) - (this.height / 2), this.width, 359, true,
				DURATION, true, options);
		}

		// Setup the mouse events
		FlxMouseEventManager.add(this, onDown, onUp, null, null);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// if we are dragging the sprite, set its location to the mouse (minus the object's width/height)
		if (dragging)
		{
			x = FlxG.mouse.x - width / 2;
			y = FlxG.mouse.y - height / 2;
		}

		/* 
			The next few statemes perform different actions based on which planet we are acting on.
		 */
		if (name == "Jupiter")
		{
			// This function allows the sprite to wrap to the oposite side of the screen when it hits a border.
			FlxSpriteUtil.screenWrap(this);
		}

		if (name == "Neptune")
		{
			// This block just causes the sprite to ricochet when it hits the border.
			if (y >= FlxG.height - 96 || y <= 0)
			{
				velocity.y *= -1;
			}
			if (x >= FlxG.width - 96 || x <= 0)
			{
				velocity.x *= -1;
			}
		}

		if (name == "Mars")
		{
			// This one causes the sprite to stop moving when it hits the border.
			if (x >= FlxG.width - 64 || y >= FlxG.height - 64 || x <= 0 || y <= 0)
			{
				velocity.x = 0;
				velocity.y = 0;
			}
		}
	}

	function onDown(_)
	{
		// when the sprite is clicked and held by the mouse, turn on the dragging behavior
		if (name != "Earth")
		{
			dragging = true;
		}
	}

	function onUp(_)
	{
		// when we release the mouse, we turn off the dragging behavior and generate a new velocity
		dragging = false;
		if (name != "Earth")
		{
			generateVelocity();
		}
	}

	private function generateVelocity()
	{
		// We use some fancy randomization to set the direction the planet is moving.
		if (FlxG.random.float() < 0.5)
		{
			if (FlxG.random.float() < 0.5)
			{
				velocity.x = initial_velocity / 2 + FlxG.random.float() * initial_velocity;
			}
			else
			{
				velocity.x = -initial_velocity / 2 - FlxG.random.float() * initial_velocity;
			}

			velocity.y = FlxG.random.float() * initial_velocity * 2 - initial_velocity;
		}
		else
		{
			if (FlxG.random.float() < 0.5)
			{
				velocity.y = initial_velocity / 2 + FlxG.random.float() * initial_velocity;
			}
			else
			{
				velocity.y = -initial_velocity / 2 + FlxG.random.float() * initial_velocity;
			}

			velocity.x = FlxG.random.float() * initial_velocity * 2 - initial_velocity;
		}

		// for a little added fun, we start rotating the planet based on the velocity we generated.
		angularVelocity = (Math.abs(velocity.x) + Math.abs(velocity.y));
	}
}
