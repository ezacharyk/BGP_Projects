package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;

/**
 * This PlayState does way more than any PlayState that we have done before.
 */
class PlayState extends FlxState
{
	private var texture:FlxFramesCollection;
	private var card:Card;
	private var background:FlxSprite;
	private var cards:Array<String>;
	private var actionDelay:Float = 1;
	private var hide:Bool = false;
	private var moving:Bool = false;
	private var triesHeader:FlxText;
	private var triesText:FlxText;
	private var matchesHeader:FlxText;
	private var matchesText:FlxText;
	private var stackX:Int = 248;
	private var stackY:Int = 10;
	private var winText:FlxText;
	private var playAgain:FlxButton;
	var matchSound:FlxSound;
	var mismatchSound:FlxSound;

	override public function create()
	{
		super.create();

		// Create a nice background
		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.background__png, false, 320, 180);
		add(background);

		// Set up a scoreboard
		triesHeader = new FlxText(0, 10, 80, "Tries:");
		triesHeader.size = 16;
		triesHeader.alignment = "center";
		add(triesHeader);

		triesText = new FlxText(0, 30, 80, "0");
		triesText.size = 16;
		triesText.alignment = "center";
		add(triesText);

		matchesHeader = new FlxText(0, 90, 80, "Sets:");
		matchesHeader.size = 16;
		matchesHeader.alignment = "center";
		add(matchesHeader);

		matchesText = new FlxText(0, 110, 80, "0");
		matchesText.size = 16;
		matchesText.alignment = "center";
		add(matchesText);

		// We initialize the sounds we are using on this state. A fun sound when the player gets a match and a not fun sound when it is mismatched.
		matchSound = FlxG.sound.load(AssetPaths.card_matched__wav, 0.4);
		mismatchSound = FlxG.sound.load(AssetPaths.card_mismatch__wav, 0.4);

		// Generate a Texture atlas that we can use to give our sprites their images
		texture = FlxAtlasFrames.fromTexturePackerJson(AssetPaths.cards__png, AssetPaths.cards__json);
		// place our cards on the game board
		placeCards();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// As long as we haven't matched all the cards, keep playing the game.
		if (Reg.matches != 15)
		{
			// If we are currently checking cards, and we have revealed the second one and we are not in the process of hiding cards, let's check to see if they are match.
			if (Reg.checking == true && Reg.click == 2 && !hide)
			{
				// we increment the tries counter and update the scoreboard
				Reg.tries++;
				triesText.text = Std.string(Reg.tries);
				if (Reg.card1 == Reg.card2)
				{
					// we play our match sound
					matchSound.play();
					// If the two cards we picked match, then we flag that we set a flag to move the matched cards
					moving = true;
					Reg.checking = false;
				}
				else
				{
					// we play our mismatch sound
					mismatchSound.play();
					// If they don't match we need to rehide them
					hide = true;
					Reg.checking = false;
				}
			}
			if (moving)
			{
				actionDelay -= elapsed;
				if (actionDelay < 0)
				{
					Reg.click = 0;
					Reg.cardObject1.matched = true;
					Reg.cardObject2.matched = true;
					moving = false;
					actionDelay = 1;

					var tween = FlxTween.linearMotion(Reg.cardObject1, Reg.cardObject1.x, Reg.cardObject1.y, stackX, stackY, 1, true);
					tween = FlxTween.linearMotion(Reg.cardObject2, Reg.cardObject2.x, Reg.cardObject2.y, stackX, stackY, 1, true);
					// move cards to pile
					Reg.cardObject1 = null;
					Reg.cardObject2 = null;

					Reg.matches++;
					matchesText.text = Std.string(Reg.matches);
					if (Reg.matches % 3 == 0)
					{
						stackY += 24;
						stackX = 248;
					}
					else
					{
						stackX += 22;
					}
				}
			}
			if (hide)
			{
				actionDelay -= elapsed;
				if (actionDelay < 0)
				{
					Reg.cardObject1.deselect();
					Reg.cardObject2.deselect();
					hide = false;
					actionDelay = 1;
					Reg.click = 0;
					Reg.cardObject1 = null;
					Reg.cardObject2 = null;
				}
			}
		}
		else
		{
			actionDelay -= elapsed;
			if (actionDelay < 0)
			{
				// If we have matched all the cards we win the game.
				winState();
			}
		}
	}

	/**
	 * This function takes the card deck we create and places the Card objects created from the deck array on the game board
	 */
	private function placeCards()
	{
		shuffleCards();
		var row:Int = 90;
		var column:Int = 32;
		var count:Int = 0;

		for (c in cards)
		{
			card = new Card(row, column, texture, c);
			add(card);

			if (count == 5)
			{
				count = 0;
				column += 24;
				row = 90;
			}
			else
			{
				count++;
				row += 24;
			}
		}
	}

	/**
	 * This function shuffles the array of cards and creates our deck.
	 */
	private function shuffleCards()
	{
		var shuffler:FlxRandom = new FlxRandom();

		var tempArray1:Array<String> = Reg.cardFaces;
		shuffler.shuffle(tempArray1);
		var tempArray2:Array<String> = tempArray1.splice(0, 15);

		cards = tempArray2;
		cards = cards.concat(tempArray2);
		shuffler.shuffle(cards);
	}

	/**
	 * We create a simple win state by lettingthe player know they are done and giving them the option to play again.
	 */
	private function winState()
	{
		winText = new FlxText(80, 10, 160, "Great Job! Try and do better!");
		winText.size = 24;
		winText.alignment = "center";
		add(winText);

		playAgain = new FlxButton(120, 120, "Play Again?", resetGame);
		add(playAgain);
	}

	/**
	 * Here, we reset all the Reg data to their defaults and then reset the game by calling the PlayState again.
	 */
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
}
