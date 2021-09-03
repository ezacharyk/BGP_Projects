package;

import flixel.FlxGame;
import openfl.display.Sprite;

/*
	This project is the first in my HaxeFlixel recreation of the projects and tutorials in
	Beginning Game Programming
	by Michael Morrison

	This project is the Blizzard example from Chapter 2: Creating an Engine for Games
 */
class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState));
	}
}
