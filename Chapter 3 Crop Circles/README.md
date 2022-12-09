# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 3: Crop Circle Example

This next chapter goes a little deeper into creating a game engine. The core of this chapter is about creating basic shapes, circles, squares, lines etc. This was the first real challenge so far. I had never drawn basic shapes using HaxeFlixel before. Luckily for me, and you, the creators of HaxeFlixel had us covered.

I was able to find and use the FlxSpriteUtil class which has all the functions we need to create these basic shapes. This class itself provided a bit of a challenge too. The function drawLine uses a typedef to manage the shape of the line. I had not used typedefs before and needed to learn a bit more about how to use them properly. Type defs are basically a json style grouping of variables that you define and then pass to whatever function needs them. The following is the typedef for LineStyle in HaxeFlixel:

```
typedef LineStyle =
{
	?thickness:Float,
	?color:FlxColor,
	?pixelHinting:Bool,
	?scaleMode:LineScaleMode,
	?capsStyle:CapsStyle,
	?jointStyle:JointStyle,
	?miterLimit:Float
}
```

This is how I defined what I needed to draw the lines:

```
var lineStyle:LineStyle = {color: FlxColor.YELLOW, thickness: 5};
```

Creating circles was pretty easy thanks to the FlxSpriteUtil class.

```
private function drawCropCircle(circle:FlxSprite):Void
{
    // Randomly creating a radius for the circle We want a minimum of 10 radius and a max of 50.
    var radius:Int = Std.int(Math.random() * 40) + 10;

    // Create a transparent graphic to act as the canvas for the circle
    circle.makeGraphic(radius * 2, radius * 2, FlxColor.TRANSPARENT, true);

    // Draw a circle onto the sprite with the radius we picked and positioned centered on the sprite.
    FlxSpriteUtil.drawCircle(circle, -1, -1, radius, FlxColor.YELLOW);

    // add the new circle to the game state
    add(circle);
}
```

The next big challenge was drawing the lines from one circle to the next. To do this, I had to keep track of the two most recently drawn circles. Then I needed to find their centers. We do this using a built in Sprite function.

```
drawCropLine(circle_1.getGraphicMidpoint(), circle_2.getGraphicMidpoint());
```

Next, I create a transparent graphic the size of the screen. Then, determine where within that graphic the circles lie. Finally, draw the line between the two points we found earlier. 

```
private function drawCropLine(circle1:FlxPoint, circle2:FlxPoint):Void
{
    // Create a line style, similar to CSS border styling
    var lineStyle:LineStyle = {color: FlxColor.YELLOW, thickness: 5};

    // Found a much better way to draw lines in the Unicron Dash game. So I am updating the code to draw lines here.

    // First we create a new sprite object positioned in the top left of the game window
    line = new FlxSprite(0, 0);
    // We make a transparent graphic the size of the window
    line.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
    // We draw our line from the center of circle 1 to the center of circle 2
    FlxSpriteUtil.drawLine(line, circle1.x, circle1.y, circle2.x, circle2.y, lineStyle);
    // Add the line to the game state
    add(line);
}
```

Like the Blizzard example in Chapter 2, I draw a random number of these circles and lines between them and then end. You can see the Crop Circles example at [itch.io](https://heroofdermwood.itch.io/bgp-ch-3-crop-circle).