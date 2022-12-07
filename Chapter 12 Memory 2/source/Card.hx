package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;

/**
 * This is our Card class. This class sets up the card objects that we use throughout the game.
 */
class Card extends FlxSprite
{
	public var cardName:String; // the name of the card so we can assign the face of it from the Texture Atlas we created
	public var matched:Bool = false; // A variable to use to determine if it has been matched.

	var flipSound:FlxSound;
	var flip2Sound:FlxSound;

	private var revealed:Bool = false; // This tracks if the card has been revealed so we can't select it twice

	static inline var TURNING_TIME:Float = 0.2; // a timer to use when we flip the card over.

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection, frameN:String)
	{
		super(X, Y);

		frames = Texture; // frames is a variable inhereted from FlxSprite
		animation.frameName = "back"; // We set the default image for the card to the back.
		cardName = frameN; // We store the name of the frmae for the front of the card for use later

		// We initialize two sounds for the card flip. I define two osunds just to make the game more interesting audibly.
		flipSound = FlxG.sound.load(AssetPaths.card_flip__wav, 0.5);
		flip2Sound = FlxG.sound.load(AssetPaths.card_flip1__wav, 0.5);

		FlxMouseEvent.add(this, null, onUp, null, null); // We set an onup mouse action so when a player clicks on the card we can perform actions
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// don't need to do much here
	}

	/**
	 * In the onUp function we check to see if the card has been matched, or if it is already revealed and skips the actions if so.
	 * We also check if we have already selected two cards, if so, we ignore the action.
	 * If we haven't already selected two cards, and if this card hasn't already been acted upon, we reveal the card.
	 */
	public function onUp(_):Void
	{
		if ((!matched && !revealed) && (Reg.cardObject1 == null || Reg.cardObject2 == null))
		{
			// FlxTween is awesome. If creates an animation that makes the game look like the card is being flipped.
			// When the animation is done, we call the revealCard function
			FlxTween.tween(scale, {x: 0}, TURNING_TIME / 2, {onComplete: revealCard});
		}
	}

	/**
	 * revealCard sets some global variables that we use throughout the game to let the main game know that this is the card we picked.
	 */
	public function revealCard(_):Void
	{
		animation.frameName = cardName; // We set the animation frame to the card's face
		revealed = true; // reveal it
		flipSound.play(); // play our flip sound
		if (Reg.click == 0)
		{
			// If this is the the first card picked assign it to the first card object
			Reg.card1 = cardName;
			Reg.click = 1;
			Reg.checking = true;
			Reg.cardObject1 = this;
		}
		else if (Reg.click == 1)
		{
			// if this is the second card picked, assign it to the second card object.
			Reg.click = 2;
			Reg.card2 = cardName;
			Reg.cardObject2 = this;
		}
		// Finish the flip reveal action.
		FlxTween.tween(scale, {x: 1}, TURNING_TIME / 2);
	}

	/**
	 * The card is no longer revealed and we start the animation that flips it back over.
	 */
	public function deselect():Void
	{
		revealed = false;
		flip2Sound.play(); // play our other flip sound.
		FlxTween.tween(scale, {x: 0}, TURNING_TIME / 2, {onComplete: hideCard});
	}

	/**
	 * Here we change the animation frame back to the back of the card and finish the flip animation.
	 */
	private function hideCard(_):Void
	{
		animation.frameName = "back";
		FlxTween.tween(scale, {x: 1}, TURNING_TIME / 2);
	}
}
