package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. 
 * 
 * We use this class to manage data that we need to have access from in multple states and classes. 
 */
class Reg
{
	// These are the names of the sprite frames we use in our deck of cards
	public static var cardFaces:Array<String> = [
		"knight", "wizard", "archer", "assassin", "merchant", "bat", "crab", "fire", "spider", "zombie", "chest", "heart", "potion", "grave", "key",
		"gargoyle", "bow", "swords", "shield", "scroll", "axe",
	];

	// We use these variables to track what cards are picked and compare them.
	public static var card1:String;
	public static var card2:String;
	public static var cardObject1:Card = null;
	public static var cardObject2:Card = null;

	// We use these to manage the turns and actions in the game.
	public static var click:Int = 0;
	public static var checking:Bool = false;
	public static var matchMade:Bool = false;

	// these are variables to track the scores and such.
	public static var matches:Int = 0;
	public static var sets:Int = 15;
	public static var tries:Int = 0;
}
