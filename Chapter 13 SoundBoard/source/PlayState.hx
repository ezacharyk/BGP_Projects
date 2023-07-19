package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var background:FlxSprite;
	private var soundMute:FlxText;
	private var soundText:FlxText;
	private var musicText:FlxText;
	private var timer:FlxText;

	private var controlsTexture:FlxFramesCollection;
	private var switchTexture:FlxFramesCollection;
	private var musicTexture:FlxFramesCollection;

	private var beepbutton:BeepButton;
	private var lightbutton:LightButton;
	private var dialbutton:DialButton;
	private var soundswitch:SwitchButton;
	private var playbutton:PlayButton;
	private var pausebutton:PauseButton;
	private var stopbutton:StopButton;
	private var ffbutton:FFButton;
	private var mutebutton:MuteButton;

	override public function create()
	{
		super.create();

		// Add our back drop sprite to the game.
		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.board__png, false, 320, 180);
		add(background);

		// this text is for a fun timer we use
		timer = new FlxText(114, 4, 40, "0");
		timer.size = 8;
		timer.alignment = "right";
		add(timer);

		// this is a label for the mute switch
		soundText = new FlxText(0, 0, 32, "SFX");
		soundText.size = 8;
		soundText.color = FlxColor.BLACK;
		soundText.alignment = "center";
		add(soundText);

		// this is the second label for the mute switch
		soundMute = new FlxText(0, 40, 32, "Mute");
		soundMute.size = 8;
		soundMute.color = FlxColor.BLACK;
		soundMute.alignment = "center";
		add(soundMute);

		// we add our mute switch to the game.
		switchTexture = FlxAtlasFrames.fromTexturePackerJson(AssetPaths.switch__png, AssetPaths.switch__json);
		soundswitch = new SwitchButton(8, 12, switchTexture);
		add(soundswitch);

		// Generate a Texture atlas for the next set of controls
		controlsTexture = FlxAtlasFrames.fromTexturePackerJson(AssetPaths.controls__png, AssetPaths.controls__json);

		// we have three objects that use the above texture.
		// This one plays a constant beep when pressed
		beepbutton = new BeepButton(32, 16, controlsTexture);
		add(beepbutton);
		// This one just ticks and spins. No action required
		dialbutton = new DialButton(72, 16, controlsTexture);
		add(dialbutton);
		// This one increases a timer and beeps when it reaches 0
		lightbutton = new LightButton(120, 20, controlsTexture);
		add(lightbutton);

		// a display for the track we are playing
		musicText = new FlxText(6, 52, 148, "No Music");
		musicText.size = 8;
		musicText.alignment = "center";
		add(musicText);

		// This texture atlas is for the musica controls
		musicTexture = FlxAtlasFrames.fromTexturePackerJson(AssetPaths.music_controls__png, AssetPaths.music_controls__json);
		// these next ones are what they say they are
		playbutton = new PlayButton(40, 72, musicTexture);
		add(playbutton);
		pausebutton = new PauseButton(56, 72, musicTexture);
		add(pausebutton);
		stopbutton = new StopButton(72, 72, musicTexture);
		add(stopbutton);
		ffbutton = new FFButton(88, 72, musicTexture);
		add(ffbutton);
		mutebutton = new MuteButton(104, 72, musicTexture);
		add(mutebutton);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// we update the timer text.
		timer.text = Std.string(lightbutton.getTime());

		// We update the music text based on the music state.
		if (pausebutton.paused)
		{
			musicText.text = "Paused: " + Reg.song;
		}
		else if (FlxG.sound.music == null || (FlxG.sound.music != null && !FlxG.sound.music.exists))
		{
			musicText.text = "No Music";
		}
		else if (FlxG.sound.music != null && FlxG.sound.music.exists)
		{
			musicText.text = "Playing: " + Reg.song;
		}
	}
}
