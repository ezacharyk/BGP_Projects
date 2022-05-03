package;

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
		add(new FlxStarField2D());

		jupiter = new Planet(Std.int(Math.random() * 428 - 210) + 210, Std.int(Math.random() * 320 - 160) + 160, "Jupiter");
		add(jupiter);
		neptune = new Planet(Std.int(Math.random() * 428 - 210) + 210, Std.int(Math.random() * 320 - 160) + 160, "Neptune");
		add(neptune);
		mars = new Planet(Std.int(Math.random() * 428 - 274) + 274, Std.int(Math.random() * 320 - 224) + 224, "Mars");
		add(mars);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
