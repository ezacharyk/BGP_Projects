# HaxeFlixel Conversions: Beginning Game Programming
## Chapters 14 and 15: Kitchen Infestation

In chapter 14 of Beginning Game Programming, we are challenged to make a gallery style shooter. The game in the book is an office battle game, but I didn't feel that such a setting was appropriate for us. So I changed the theme to a game about killing bugs in a kitchen.

In Chapter 15, the book teaches us about animating sprites. Since we already used animated sprites in previous games, I combined the two chapters. But I also decided to use something we touched earlier in the Memory game, tweens. This tween is different from the ones we used in Memory. This one causes the sprite to loop around the kitchen. 

```
var options:TweenOptions = {type: PINGPONG, ease: FlxEase.sineInOut, onComplete: onComplete};
if (facing == LEFT)
{
    tween = FlxTween.quadMotion(this, startX, startY, 0, 20, startX + 120, startY, 3, true, options);
}
else 
{
    tween = FlxTween.quadMotion(this, startX, startY, 120, 20, startX - 120, startY, 3, true, options);
}
```

We also have some various sprite manipulating we use for this game. One of these is the FlxSprite property of facing. By setting the facing flip, we can change which direction the default sprite faces. So we can get away with using a single sprite and change which direction it faces programatically.  

```
setFacingFlip(RIGHT, false, false);
setFacingFlip(LEFT, true, false);
setFacingFlip(UP, false, true);
setFacingFlip(DOWN, false, false);
```

We also have a sprite that rotates on an axis. We can manipulate the axis of the sprite using the origin property.

```
origin = FlxPoint.get(16, 16);
```

We can then rotate the sprite by updating the angle property in the update function.

```
angle += 1;
```

You can see the the full Kitchen Infestation game at [itch.io](https://heroofdermwood.itch.io/bgp-kitchen-infestation).

# Project Notes and Updates
You can follow the goals, notes and updates for the overall goal of this project at  http://ezknight.net

# Credits
Music is [Galactic Funk](https://nicolemariet.itch.io/free-chiptune-song-galactik-funk) by [Nicole Marie T](https://techhub.social/@musicvsartstuff)