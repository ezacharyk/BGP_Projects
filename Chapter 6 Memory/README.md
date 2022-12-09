# HaxeFlixel Conversions: Beginning Game Programming
## Chapter 6: Mouse Input and Memory Game

I will be straight with you. I made this example way more feature rich than it needed to be, if my goal was to duplicate the memory example in Beginning Game Programming. In that example, the game had no frills. It was just cards on the screen that flipped instantly when clicked. When the game was over, a popup showed you your score with a button to reset the game. As I started programming this, I felt the need to add some flourishes, that perhaps are more advanced than this stage in the book was ready for.

The most advanced code I use is the FlxTween to animate flipping the cards and moving matches to a scoring area. I won't go into too much detail here, as a later chapter will explore various animation techniques. So for now, I will explain the mouse input and game reset code.

The first change you may notice in this game is the inclusion of a new file called Reg.hx. This file is used to manage data that you want to maintain between states in the game. It can be used to define constants and variables that will be used in the game. In our Reg file, we list the frame names of all the cards we use, the score variables, the number of card sets we are playing with, and other variables for managing the current state of play.

Next up, we set up a Card.hx object that we use to create all the cards in the game. You will notice that this class has two new parameters when creating a new card object.

```
new(X:Int, Y:Int, Texture:FlxFramesCollection, frameN:String)
```

The first new parameter is the Texture. This takes in a FlxFramesCollection object to be used to define the frames of animation. The frames collection is a single image with all possible animation frames on it, and a partner json file that defines the locations and dimensions, as well as a name, for each frame. We pass this into the card, along with another String parameter that defines what frame we are using for this card. 

```
frames = Texture; // frames is a variable inhereted from FlxSprite
animation.frameName = "back"; // We set the default image for the card to the back.
cardName = frameN; // We store the name of the frmae for the front of the card for use later
```

The next major method for the Card class is the input. We use FlxMouseEvent to track what mouse events we want to watch and what function we call when an event happens. In this, we watch for a mouse up event on the card (the use clicks on a card and releases the left mouse button). Then we call the onUp funtion.

```
FlxMouseEvent.add(this, null, onUp, null, null);
```

After that, we check some state values and flip the card over if the right conditions exist. The other null values in the event call are for the mouse down, mouse, ove3r, and mouse out. There are other parameters that you can add, but these are all we need at the moment.

When the game is over, all matches have been made, we call a function to congratulate the player on matching them all and povide a button to reset the game.

```
playAgain = new FlxButton(120, 120, "Play Again?", resetGame);
add(playAgain);
```

FlxButton is a built in class that creates a plain gray button with whatever text you provide on it. When a player clicks on the button, it triggers the function you pass it (resetGame). In that function, we simply reset all the Reg variables and reloads the PlayState.

```
private function resetGame()
{
    Reg.cardFaces = [
        "knight", "wizard", "archer", "assassin", "merchant", "bat", "crab", "fire", "spider", "zombie", "chest", "heart", "potion", "grave", "key",
        "gargoyle", "bow", "swords", "shield", "scroll", "axe",
    ];
    Reg.card1 = "";
    Reg.card2 = "";
    Reg.cardObject1 = null;
    Reg.cardObject2 = null;

    Reg.click = 0;
    Reg.checking = false;
    Reg.matchMade = false;

    Reg.matches = 0;
    Reg.sets = 15;
    Reg.tries = 0;
    FlxG.switchState(new PlayState());
}
```

Like I said at the beginning, this game does a whole lot more than it needed to do to be a proper mouse input example. I have commented the code so that you can see what each line and/or block is doing. I just wanted to highlight these specific sections. 

You can see the the full Memory game at [itch.io](https://heroofdermwood.itch.io/bgp-memory-example).