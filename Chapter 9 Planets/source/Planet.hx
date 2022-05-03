package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.util.FlxSpriteUtil;

class Planet extends FlxSprite
{
	private var name:String;
	private var dragging:Bool = false;

	public function new(X:Int, Y:Int, n:String)
	{
		// X,Y: Starting coordinates
		super(X, Y);

		name = n;

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
		else
		{
			// load the png in the assets folder into the sprite object on creation.
			loadGraphic(AssetPaths.mars__png, false, 64, 96);
		}

		// Setup the mouse events
		FlxMouseEventManager.add(this, onDown, onUp, null, null);

		generateVelocity();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (dragging)
		{
			x = FlxG.mouse.x - width / 2;
			y = FlxG.mouse.y - height / 2;
		}
		if (name == "Jupiter")
		{
			FlxSpriteUtil.screenWrap(this);
		}

		if (name == "Neptune")
		{
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
			if (x >= FlxG.width - 64 || y >= FlxG.height - 64 || x <= 0 || y <= 0)
			{
				velocity.x = 0;
				velocity.y = 0;
			}
		}
	}

	function onDown(_)
	{
		dragging = true;
	}

	function onUp(_)
	{
		dragging = false;
		generateVelocity();
	}

	private function generateVelocity()
	{
		var initial_velocity:Int = 200;

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
	}
}
