package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxStarField.FlxStarField2D;

class PlayState extends FlxState
{
	public var jupiter:Planet;
	public var neptune:Planet;
	public var mars:Planet;

	override public function create()
	{
		super.create();

		// Create a starfield
		// This is a fun class that generates a field of dots the fly across the screen to give the illusion of movement.
		add(new FlxStarField2D());

		// generate some planets.
		jupiter = new Planet(FlxG.random.int(0,428), FlxG.random.int(0,320), "Jupiter");
		add(jupiter);
		neptune = new Planet(FlxG.random.int(0,428), FlxG.random.int(0,320), "Neptune");
		add(neptune);
		mars = new Planet(FlxG.random.int(0,428), FlxG.random.int(0,320), "Mars");
		add(mars);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
