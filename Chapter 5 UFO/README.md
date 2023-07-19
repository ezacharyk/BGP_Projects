# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 5: Keyboard Input and UFO Example

In this chapter, we learn how to caputer and act upon basic input via the keyboard. When developing games for the PC, keyboard input is the primary means in which games are played. So to show how this is done, we create a UFO that flies around a night sky based on what keys the player pushes. 

Before we get to the keyboard inputs, let's look at a few things we have done as we set up the game project. First up, not only are we creting a UFO, we are also putting a background on the screen. We do this by creating a sprite, loading a graphic and placing it on the game window.

```
background = new FlxSprite(0, 0);
background.loadGraphic(AssetPaths.background__png, false, 640, 360);
add(background);
```

Then to set up movement for our UFO, we have to define the speed at which our UFO flies, 

```
static inline var SPEED:Float = 200;
```

and the drag, which determines how it stops.

```
drag.x = drag.y = 1600;
```

Finally, we create a function that captures the player input (WASD or arrows) and moves the UFO in the direction indicated. For this example, we use the anyPressed method to see if any of the keys we are watching are pressed and then using that to flag which direction we should move. 

```
function updateMovement()
{
    // we define some variables to help us track which way our ufo is moving
    var up:Bool = false;
    var down:Bool = false;
    var left:Bool = false;
    var right:Bool = false;

    // we determine which way our ufo is moving based on which keys are pressed
    up = FlxG.keys.anyPressed([UP, W]);
    down = FlxG.keys.anyPressed([DOWN, S]);
    left = FlxG.keys.anyPressed([LEFT, A]);
    right = FlxG.keys.anyPressed([RIGHT, D]);

    // we cancel out when opposite keys are pressed
    if (up && down)
        up = down = false;
    if (left && right)
        left = right = false;

    // if we are moving in any direction we calculate the speed and angle
    if (up || down || left || right)
    {
        var newAngle:Float = 0;
        if (up)
        {
            newAngle = -90;
            if (left)
                newAngle -= 45;
            else if (right)
                newAngle += 45;
            facing = UP;
        }
        else if (down)
        {
            newAngle = 90;
            if (left)
                newAngle += 45;
            else if (right)
                newAngle -= 45;
            facing = DOWN;
        }
        else if (left)
        {
            newAngle = 180;
            facing = LEFT;
        }
        else if (right)
        {
            newAngle = 0;
            facing = RIGHT;
        }

        // we determine our velocity based on angle and speed
		velocity.setPolarDegrees(SPEED, newAngle);
    }
}
```

This method of player input is great for something as simple as this. But HaxeFlixel has some better ways to handle more complicated and varied input methods. We will be exploring those in the next few chapters. 

You can see the UFO example at [itch.io](https://heroofdermwood.itch.io/bgp-ufo-example).

# Project Notes and Updates
You can follow the goals, notes and updates for the overall goal of this project at  http://ezknight.net