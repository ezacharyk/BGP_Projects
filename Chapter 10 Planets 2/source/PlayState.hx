package;

import flixel.FlxState;
import flixel.addons.display.FlxStarField.FlxStarField2D;
import flixel.util.FlxCollision;

class PlayState extends FlxState
{
	public var jupiter:Planet;
	public var neptune:Planet;
	public var mars:Planet;
	public var earth:Planet;

	override public function create()
	{
		super.create();

		// Create a starfield
		// This is a fun class that generates a field of dots the fly across the screen to give the illusion of movement.
		add(new FlxStarField2D());

		// generate some planets.
		jupiter = new Planet(Std.int(Math.random() * 428 - 210) + 210, Std.int(Math.random() * 320 - 160) + 160, "Jupiter");
		add(jupiter);
		neptune = new Planet(Std.int(Math.random() * 428 - 210) + 210, Std.int(Math.random() * 320 - 160) + 160, "Neptune");
		add(neptune);
		mars = new Planet(Std.int(Math.random() * 428 - 274) + 274, Std.int(Math.random() * 320 - 224) + 224, "Mars");
		add(mars);
		earth = new Planet(320 - 32, 120, "Earth");
		add(earth);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Here we check for collisions between the different planets. We don't do anythign super fancy, just reverse their current velocity.
		// This isn't perfect. Planets can get into infinite loops of reveral if they end up overlapped (This especially happens since earth doesn't reverse)
		if (FlxCollision.pixelPerfectCheck(jupiter, neptune)
			|| FlxCollision.pixelPerfectCheck(jupiter, mars)
			|| FlxCollision.pixelPerfectCheck(jupiter, earth))
		{
			jupiter.velocity.x *= -1;
			jupiter.velocity.y *= -1;
		}
		if (FlxCollision.pixelPerfectCheck(neptune, jupiter)
			|| FlxCollision.pixelPerfectCheck(neptune, mars)
			|| FlxCollision.pixelPerfectCheck(neptune, earth))
		{
			neptune.velocity.x *= -1;
			neptune.velocity.y *= -1;
		}
		if (FlxCollision.pixelPerfectCheck(mars, jupiter)
			|| FlxCollision.pixelPerfectCheck(mars, neptune)
			|| FlxCollision.pixelPerfectCheck(mars, earth))
		{
			mars.velocity.x *= -1;
			mars.velocity.y *= -1;
		}
	}
}
