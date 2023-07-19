# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 2: Blizzard Example

This chapter was not too challenging. In the book, this chapter had the reader create a basic game engine in C++. Since we are working with HaxeFlixel, I didn’t need to worry about that. But you do need to know how HaxeFlixel structures its projects. In a barebones HaxeFlixel project you have an assets folder (where all the game’s sprites, sounds, etc live), a source folder (where all your source code goes), and a project xml file. The source file starts off with the AssetPaths, Main, and PlayState Haxe files.

```
Game Project Folder
->assets
-->images
->source
-->AssetPaths.hx
-->Main.hx
-->PlayState.hx
```

The AssetPaths file is a class that scans the assets directory and creates pointer objects that you can use for your games. The Main file Loads in your game and sends the player to the PlayState. The PlayState file is where the core of your game is going to run from. In this file you have the create function, which is where you do all your initialization for your game, and the update function which is where all your game’s core logic will execute from.

In the Blizzard example, I also created a SnowFlake class file which is a basic class file that extends the HaxeFlixel FlxSprite class. All this class does is call the FlxSprite loadGraphics function. This pulls an image from the AssetPaths and assigns it to the class.

```
loadGraphic(AssetPaths.snowflake__png, false, 18, 18);
```

This “game” doesn’t have a lot happening. First we display some text on the screen using the FlxText class.

```
text = new FlxText(0, 0, 640, "The Blizzard Is Coming!");
text.size = 16;
text.alignment = "center";
add(text);
```

Finally, a timer and counter that controls how many and when to add snowflakes to the game screen. We use the built in Math class to randomize the max number of snowflakes and start our counter.

```
totalFlakes = Std.int(Math.random() * 1000);

numFlakes = 0;
```

In the update function we check if our snowflake counter is less than the total number. If we are still under our max and the timer has elapsed to 0, we add a snowflake.

```
private function drawSnowflake():Void
{
    // Create a new snowflake Sprite. Set its position to a random point on the screen.
    var snowflake:FlxSprite = new FlxSprite(Std.int(Math.random() * 620), Std.int(Math.random() * 440) + 20);
    // load the png in the assets folder into the sprite object on creation.
    snowflake.loadGraphic(AssetPaths.snowflake__png, false, 18, 18);
    // Add the snowflake to the game state
    add(snowflake);
    // update the number of flakes we have.
    numFlakes++;
    // Reset the timer
    flakeTime = .2;
}
```

Once we reach our limit, we change the text we set up earlier.

```
text.text = "The Blizzard Is Over!";
```

You can see the Blizzard example in action over at [itch.io](https://heroofdermwood.itch.io/bgp-ch-2-blizzard).

# Project Notes and Updates
You can follow the goals, notes and updates for the overall goal of this project at  http://ezknight.net

