# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 8: Unicorn Dash Game

To briefly describe the game we are making here, we are making a clone of the Light Cycles game from the movie Tron. In that game, you controler a motorcycle that draws a line behind it with the goal of making the other player crash into it or the edge of the game area. We are doing pretty much the same, but with a unicorn theme. Like the previous UFO 2 example, this game will be using gamepads to control the unicorns. 

And just like we did before, we will define our player input via the FlxAction class. However, this time, we need to take into account two players. So in our Unicorn.hx class, we will have a new variable indicating which player we are controlling and which controller they are using, and defining the inputs based on that.

```
// Player 0 is actually player 1
if (player == 0)
{
    // We define out player inputs.
    _up = new FlxActionDigital().addGamepad(DPAD_UP, PRESSED, gamepadID)
        .addGamepad(LEFT_STICK_DIGITAL_UP, PRESSED, gamepadID)
        .addKey(W, PRESSED);

    _down = new FlxActionDigital().addGamepad(DPAD_DOWN, PRESSED, gamepadID)
        .addGamepad(LEFT_STICK_DIGITAL_DOWN, PRESSED, gamepadID)
        .addKey(S, PRESSED);

    _left = new FlxActionDigital().addGamepad(DPAD_LEFT, PRESSED, gamepadID)
        .addGamepad(LEFT_STICK_DIGITAL_LEFT, PRESSED, gamepadID)
        .addKey(A, PRESSED);

    _right = new FlxActionDigital().addGamepad(DPAD_RIGHT, PRESSED, gamepadID)
        .addGamepad(LEFT_STICK_DIGITAL_RIGHT, PRESSED, gamepadID)
        .addKey(D, PRESSED);
}
else
{
    _up = new FlxActionDigital().addGamepad(DPAD_UP, PRESSED, gamepadID)
        .addGamepad(LEFT_STICK_DIGITAL_UP, PRESSED, gamepadID)
        .addKey(UP, PRESSED);

    _down = new FlxActionDigital().addGamepad(DPAD_DOWN, PRESSED, gamepadID)
        .addGamepad(LEFT_STICK_DIGITAL_DOWN, PRESSED, gamepadID)
        .addKey(DOWN, PRESSED);

    _left = new FlxActionDigital().addGamepad(DPAD_LEFT, PRESSED, gamepadID)
        .addGamepad(LEFT_STICK_DIGITAL_LEFT, PRESSED, gamepadID)
        .addKey(LEFT, PRESSED);

    _right = new FlxActionDigital().addGamepad(DPAD_RIGHT, PRESSED, gamepadID)
        .addGamepad(LEFT_STICK_DIGITAL_RIGHT, PRESSED, gamepadID)
        .addKey(RIGHT, PRESSED);
}
```

You will notice that in the addGamepad method, we are passing in the gamepadID. This tells the game to only watch for inputs from that gamepad. We also split the keyboard inputs between players. If we were making a gamepad only game, we could get by without the player if statement when defining these inputs, since all we would need is the gamepadID. 

Everything else about input in the game functions mostly the same as the UFO 2 example. I will let you explore the rest of the code and see how the game itself functions. 

So that is it for the changes. You can define as many inputs as you need for your game using this method.

You can see the the full Unicorn Dash at [itch.io](https://heroofdermwood.itch.io/bgp-unicorn-dash).

# Project Notes and Updates
You can follow the goals, notes and updates for the overall goal of this project at  http://ezknight.net