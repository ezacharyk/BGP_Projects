# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 4: Slideshow Example

This chapter taught new game developers about bitmaps and how to use them in their games. Since HaxeFlixel handles all those details, I didn’t need to write up a class to read and display them. So I jumped right to the example at the end, A Slideshow.

For this, I used it as an introduction to HaxeFlixel’s sprite animation functionality. The FlxSprite class has some built in animation functionality that you can use to to create a slideshow effect. 

Inside of the Slideshow class, we load a sprite that has multiple frames which are each the size of the game window. 

```
loadGraphic(AssetPaths.ManlyBoy__png, true, 320, 180);
```

Then we loop through these frames based on a timer in the update method.

```
slideTimer += elapsed;
// we check the state of the timer and if it hits 5, we play the next frame
if (slideTimer >= 5)
{
    animation.frameIndex++;
    // if we have gone passed the number of frames, then we go back to 0
    if (animation.frameIndex > 5)
    {
        animation.frameIndex = 0;
    }
    // we reset our timer
    slideTimer = 0;
}
```

This gives us a basic look at changing the appearence of a sprite based on animation frames. This is not how we will typically make animated sprites, which we will get into in a later chapter, but it is one way of changing static sprites without loading a new graphic every time.

You can see the Slideshow example at [itch.io](https://heroofdermwood.itch.io/bgp-slideshow-examplebgp-ch-4-slideshow).

# Project Notes and Updates
You can follow the goals, notes and updates for the overall goal of this project at  http://ezknight.net