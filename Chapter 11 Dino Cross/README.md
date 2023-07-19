# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 11: Dino Cross Game

In Dino Cross, we build upon all the skills we gained so far. Here we have game with controller and keyboard controls, collisions, score keeping, win and lose states, and more. 

The game itself is a frogger/Crossy Road clone. It is a lot of fun to play. 

I have a couple of code excerpts I would like to share. First up, I had to change up the screen wrap function we used in the Planets example. The default code caused the dinosaurs to instantly teleport from one side of the screen to the other. I had to change it so that they would teleport off screen.

```
private function screenWrap()
{
    if ((x + frameWidth / 2) <= 0)
    {
        x = FlxG.width;
    }
    else if (x >= FlxG.width)
    {
        x = 0;
    }

    if ((y + frameHeight) <= 0) // top
    {
        y = FlxG.height;
    }
    else if (y >= FlxG.height) // bottom
    {
        y = 0 - frameHeight;
    }
}
```

The other thing to note here is the use of different states. We have a MenuState, PlayState, and WinState. We can switch between these states with the following command.

```
FlxG.switchState(new PlayState());
```

We also create actual animations for the dinosaurs. We can do this very easily in a FlxSprite.

```
// we create some animations based on the frame collection
animation.add("idle", [0, 1], 1, true);
animation.add("jump", [2], 1, false);

// we play our default animation
animation.play("idle");
```

Using the above code, and a sprite sheet with sufficient frames, you can create all kinds of animations.

That is about it for the new functionality. 

You can see the the full Dino Cross game at [itch.io](https://heroofdermwood.itch.io/bgp-dino-cross).

# Project Notes and Updates
You can follow the goals, notes and updates for the overall goal of this project at  http://ezknight.net