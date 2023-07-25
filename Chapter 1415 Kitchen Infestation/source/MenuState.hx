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
	private var target:FlxSprite;

	override public function create()
	{
		super.create();
		// use the load function to change the mouse cursor to our custom one. We also need to offset it by 16 pixels to center it.
		FlxG.mouse.visible = false;

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
			FlxG.sound.playMusic(AssetPaths.galacticfunk__wav, .25, true);
		}

		//We create a FlxButton object which when clicked will start the game.
		playButton = new FlxButton(0, 0, "Play", onButtonClicked);
		playButton.screenCenter();
		playButton.y = 150;
		add(playButton);

		// We create a target sprite and set its position to that of the sprite, with an offset.
		target = new FlxSprite(0, 0);
		target.loadGraphic(AssetPaths.target__png, false, 32, 32);
		target.x = FlxG.mouse.x - 16;
		target.y = FlxG.mouse.y - 16;
		add(target);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		//Our Target needs to follow the sprite.
		target.x = FlxG.mouse.x - 16;
		target.y = FlxG.mouse.y - 16;
	}

	public function onButtonClicked()
	{
		//we use the switchstate function to change to our playstate.
		FlxG.switchState(new PlayState());
	}
}
