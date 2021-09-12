package;

import flixel.FlxState;

class PlayState extends FlxState
{
	private var slideshow:Slideshow;

	override public function create()
	{
		super.create();

		slideshow = new Slideshow(0, 0);
		add(slideshow);
		slideshow.animation.play("slide");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
