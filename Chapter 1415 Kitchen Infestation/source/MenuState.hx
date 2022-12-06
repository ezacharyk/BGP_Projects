package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	private var background:FlxSprite;
	private var title:FlxSprite;
	private var playButton:FlxButton;

	override public function create()
	{
		super.create();
		// use the load function to change the mouse cursor to our custom one. We also need to offset it by 16 pixels to center it.
		FlxG.mouse.load(AssetPaths.target__png, 1, -16, -16);

		// Add our back drop sprite to the game.
		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.kitchen__png, false, 320, 180);
		add(background);

		// Add our back drop sprite to the game.
		title = new FlxSprite(0, 0);
		title.loadGraphic(AssetPaths.title__png, false, 205, 80);
		title.screenCenter();
		add(title);

		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			// we start playing music for the game. We only need to do it in thsi state. It will continue playing in other states.
			FlxG.sound.playMusic(AssetPaths.HoliznaCC0RedSkies__ogg, .25, true);
		}

		playButton = new FlxButton(0, 0, "Play", onButtonClicked);
		playButton.screenCenter();
		playButton.y = 150;
		add(playButton);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function onButtonClicked()
	{
		FlxG.switchState(new PlayState());
	}
}
