# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 13: Sound Board Example

This example wasn't in the book Beginning Game Programming. After adding sounds and music to the previous games, I wanted to play around with various options for sounds in a game like setting. So I created a sound board.

For sound effect options, we set up some buttons and toggles that play with the various sound options. First we have a SwitchButton that when flipped down mutes all sounds in the game by setting the sound volume to 0.

```
sound.volume = 0;
```

Next we have a BeepButton that continuously plays a sound if the player holds the mouse button down while on it. When the player releases the button, the sound stops.

```
public function onUp(_):Void
{
    beepSound.stop();
    animation.frameName = "buttonup";
}

/**
    * In the onDown class, we play the sound and change the button to the down frame.
    */
public function onDown(_):Void
{
    beepSound.play();
    animation.frameName = "buttondown";
}
```

Then we have a DialButton that plays with the volume and pan levels of the sound to create an effect of the sound being at different directions from the player.

```
switch (animation.frameName)
{
    case "dialup":
        if (!Reg.sfxMuted)
        {
            tickSound.volume = .5;
        }
        tickSound.pan = 1;
        animation.frameName = "dialright";
    case "dialright":
        if (!Reg.sfxMuted)
        {
            tickSound.volume = .2;
        }
        tickSound.pan = 0;
        animation.frameName = "dialdown";
    case "dialdown":
        if (!Reg.sfxMuted)
        {
            tickSound.volume = .5;
        }
        tickSound.pan = -1;
        animation.frameName = "dialleft";
    case "dialleft":
        if (!Reg.sfxMuted)
        {
            tickSound.volume = 1;
        }
        tickSound.pan = 0;
        animation.frameName = "dialup";
}
tickSound.play();
```

And finally we have a LightButton that plays and alarm after a seperate timer hits zero. Nothing super special about it. It was done to show that sound events don't need to be directly tied to play input.

Finally, we have our music controls. This consists of buttons typically seen on a media player, a PlayButton, StopButton, PauseButton, MuteButton, and a FFButton (Fast Forward, or more accurately a skip). These all do what they sound like they do.

Play:

```
FlxG.sound.playMusic(AssetPaths.amazingmazes__ogg, 0.5, true);
```

Stop:

```
FlxG.sound.music.stop();
```

Pause:

```
FlxG.sound.music.pause();
```
And when Pause is unselected:

```
FlxG.sound.music.resume();
```

Mute:

```
FlxG.sound.music.volume = 0;
```

The Fast Forward Function is different from the rest, in that it requires some variable tracking outside the normal sound variables. We need to know what song is playing, what is the next track, and then switch tracks.

```
switch (Reg.song)
{
    case "Amazing Mazes":
        FlxG.sound.playMusic(AssetPaths.dkadventure__ogg, volume, true);
        Reg.song = "DK Adventure";
    case "DK Adventure":
        FlxG.sound.playMusic(AssetPaths.spacetheme__ogg, volume, true);
        Reg.song = "Space Theme";
    case "Space Theme":
        FlxG.sound.playMusic(AssetPaths.amazingmazes__ogg, volume, true);
        Reg.song = "Amazing Mazes";
}
```

You can see the the full Sound Board Example at [itch.io](https://heroofdermwood.itch.io/bgp-sound-board).