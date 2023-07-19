# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 12: Memory 2 With Sound

This project is a direct copy of the previous Memory game, with one major difference. We now play sound effects. We have added sound effects to the card flips, and seperate sounds for a match and a mismatch. 

To use sounds, we put a .wav file in the assets folder. Then we load it into a FlxSound object.

```
var matchSound:FlxSound;

matchSound = FlxG.sound.load(AssetPaths.card_matched__wav, 0.4);
```

And to play the sound, we simply call the play function.

```
matchSound.play();
```

You can see the the full Memory game at [itch.io](https://heroofdermwood.itch.io/bgp-memory-example).

# Project Notes and Updates
You can follow the goals, notes and updates for the overall goal of this project at  http://ezknight.net