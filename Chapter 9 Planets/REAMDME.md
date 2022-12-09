# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 9: Planets Example

This code example gives us the chance to play with a few sprite behaviors we have only touched upon before. I would like to share a few new things as we go.

First up, this example uses a different method to create a background. Before we were simply creating a sprite and adding it to the state before everything else. In this one, we using a new built in Flixel class, FlxStarField. This class has several sub classes for drawinging backgrounds that look like the night sky. In this case, we are using FlxStarField2d. 

```
add(new FlxStarField2D());
```

Next we are creating several planets that each behave differently when they hit the edge of the game screen. We handle these behaviors in the update function of the Planet.hx class.

```
if (name == "Jupiter")
{
    // This function allows the sprite to wrap to the oposite side of the screen when it hits a border.
    FlxSpriteUtil.screenWrap(this);
}

if (name == "Neptune")
{
    // This block just causes the sprite to ricochet when it hits the border.
    if (y >= FlxG.height - 96 || y <= 0)
    {
        velocity.y *= -1;
    }
    if (x >= FlxG.width - 96 || x <= 0)
    {
        velocity.x *= -1;
    }
}

if (name == "Mars")
{
    // This one causes the sprite to stop moving when it hits the border.
    if (x >= FlxG.width - 64 || y >= FlxG.height - 64 || x <= 0 || y <= 0)
    {
        velocity.x = 0;
        velocity.y = 0;
    }
}
```

For the planet Jupiter, we are using the screenWrap utility to simply wrap the planet around to the opposite side of the screen. When Neptune hits the edge of the screen, we reverse its velocity causing it to ricoche around the screen. Mars simply stops when it hits the edge. 

We also add a mouse event manager to the planets that allow them to be dragged aroudn the screen. When they are let go, the game generates a new velocity and direction for them. 

```
FlxMouseEvent.add(this, onDown, onUp, null, null);

function onDown(_)
{
    // when the sprite is clicked and held by the mouse, turn on the dragging behavior
    dragging = true;
}

function onUp(_)
{
    // when we release the mouse, we turn off the dragging behavior and generate a new velocity
    dragging = false;
    generateVelocity();
}
```

While the player is dragging the sprite object we simply change the position of the planet to match the mouse position.

```
if (dragging)
{
    x = FlxG.mouse.x - width / 2;
    y = FlxG.mouse.y - height / 2;
}
```

You can see the the full Planets example at [itch.io](https://heroofdermwood.itch.io/bgp-planets).