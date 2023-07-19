# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 13: Dino Cross Game with Music

Just like the last couple of games, we add various sound effects to this game. But we also add music. Music is handled in a slightly different way to sound effects. Sounds are usually played once during an event and then done. But most often, music in games is played at all times and on a loop.

In this game, we start up the music in the MenuState and it keeps playing accross states. Instead of creating a sound object, we simply use the sound object already in FlxG. 

```
if (FlxG.sound.music == null) // don't restart the music if it's already playing
{
    // we start playing music for the game. We only need to do it in thsi state. It will continue playing in other states.
    FlxG.sound.playMusic(AssetPaths.dinocross__ogg, 1, true);
}
```

That is it for playing music. We will dive a little more into music and sound in the next project.

You can see the the full Dino Cross game at [itch.io](https://heroofdermwood.itch.io/bgp-dino-cross).

# Project Notes and Updates
You can follow the goals, notes and updates for the overall goal of this project at  http://ezknight.net