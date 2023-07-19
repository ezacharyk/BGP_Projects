# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 7: Gamepad Input and UFO Example

This example is identical to the earlier UFO example, except in the way we manage player input. Since we are now using controllers, the way we handled input in the earlier example no longer works. So, to capture player input, we are switching to the use of FlxAction, a helper class that functions much the same way as the FlxMouseEvent class we used in the Memory example.

So we first define some FlxActionDigital objects for each player action we want to define. In this case, we want to move in the 4 cardinal directions, and warp. Here is how we define the up action.

```
_up = new FlxActionDigital().addGamepad(DPAD_UP, PRESSED)
        .addGamepad(LEFT_STICK_DIGITAL_UP, PRESSED)
        .addKey(UP, PRESSED)
        .addKey(W, PRESSED);
```

In this, we call the addGamepad method to add the controller inputs. For this game, we will control the movement of the UFO with both the left analog stick and the dpad. We also define alternative keyboard inputs. We have similar called for the rest of the inputs. 

To see if an action should be performed, we simply watch for input in our update function.

```
up = _up.triggered;

if (up)
{
    newAngle = -90;
    if (left)
        newAngle -= 45;
    else if (right)
        newAngle += 45;
    facing = UP;
    // if we are moving up, we want to play the thrust animation.
    animation.play("thrust");
    stopThrust = .1;
}
```

So that is it for the changes. You can define as many inputs as you need for your game using this method.

You can see the the full UFO 2 example at [itch.io](https://heroofdermwood.itch.io/bgp-ufo2-example).

# Project Notes and Updates
You can follow the goals, notes and updates for the overall goal of this project at  http://ezknight.net