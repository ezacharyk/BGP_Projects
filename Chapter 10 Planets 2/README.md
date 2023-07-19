# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 10: Planets 2 Example

The Planets 2 example is much the same as the previous example, only this time we have made two changes.

The first change is that we added a new planet with a whole new behavior. This planet is Earth and it rotates around the center of the game screen. It cannot be interacted with using the mouse like the other planets. We set this rotation using a FlxTween method.

```
// For the motion of the earth, we are going to use the FlxTween class to apply a circular motion.
var options:TweenOptions = {type: LOOPING, ease: FlxEase.linear};

_tween = FlxTween.circularMotion(this, (FlxG.width * 0.5) - (this.width / 2), (FlxG.height * 0.5) - (this.height / 2), this.width, 359, true,
    DURATION, true, options);
```

This method defines the size and speed of the rotation of the object and whether that rotation loops.

The other big change is that we are now checking to see if the planets collide with eachother and having them ricochet off eachother. We do this using the FlxCollision class.

```
if (FlxCollision.pixelPerfectCheck(jupiter, neptune)
    || FlxCollision.pixelPerfectCheck(jupiter, mars)
    || FlxCollision.pixelPerfectCheck(jupiter, earth))
{
    jupiter.velocity.x *= -1;
    jupiter.velocity.y *= -1;
}
if (FlxCollision.pixelPerfectCheck(neptune, jupiter)
    || FlxCollision.pixelPerfectCheck(neptune, mars)
    || FlxCollision.pixelPerfectCheck(neptune, earth))
{
    neptune.velocity.x *= -1;
    neptune.velocity.y *= -1;
}
if (FlxCollision.pixelPerfectCheck(mars, jupiter)
    || FlxCollision.pixelPerfectCheck(mars, neptune)
    || FlxCollision.pixelPerfectCheck(mars, earth))
{
    mars.velocity.x *= -1;
    mars.velocity.y *= -1;
}
```

You can see the the full Planets 2 example at [itch.io](https://heroofdermwood.itch.io/bgp-planets-2).

# Project Notes and Updates
You can follow the goals, notes and updates for the overall goal of this project at  http://ezknight.net