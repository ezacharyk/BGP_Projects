# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 12: Unicorn Dash 2 With Sound

This project is a direct copy of the previous Unicorn Dash game, with one major difference. We now play sound effects. Here we play a sound when the Unicorn turns and when it crashes. 

To use sounds, we put a .wav file in the assets folder. Then we load it into a FlxSound object.

```
var turnSound:FlxSound;

turnSound = FlxG.sound.load(AssetPaths.unicorn_turn__wav, 0.4);
```

And to play the sound, we simply call the play function.

```
turnSound.play();
```

You can see the the full Unicorn Dash game at [itch.io](https://heroofdermwood.itch.io/bgp-unicorn-dash).

# Project Notes and Updates
You can follow the goals, notes and updates for the overall goal of this project at  http://ezknight.net