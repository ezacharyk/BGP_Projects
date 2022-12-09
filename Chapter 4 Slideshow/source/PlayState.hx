package;

import flixel.FlxState;

class PlayState extends FlxState
{
	private var slideshow:Slideshow;

	override public function create()
	{
		super.create();

		// Create a new variable using our slideshow class.
		slideshow = new Slideshow(0, 0);
		// add that variable to the Play State
		add(slideshow);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
