package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		// Adding a width and height to the FlxGame allows us to zoom in, making our smaller sprites bigger.
		// This is a much better way than I was doing it before.
		addChild(new FlxGame(320, 180, MenuState));
	}
}
