package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;

class Roach extends FlxSprite
{
	private var startX:Int;
	private var startY:Int;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		// X,Y: Starting coordinates
		super(X, Y);

		startX = X;
		startY = Y;

		// we load in the frames collection and use it as the base sprite.
		frames = Texture; // frames is a variable inhereted from FlxSprite

		animation.addByNames("idle", ["roach1", "roach2"], 4, true);
		animation.play("idle");

		setFacingFlip(RIGHT, false, false);
		setFacingFlip(LEFT, true, false);

		FlxMouseEvent.add(this, null, onUp, null, null); // We set an onup mouse action so when a player clicks on the card we can perform actions
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (facing == LEFT)
		{
			velocity.x = 32;
			if (x > startX + 96)
			{
				Reg.misses++;
				kill();
			}
		}
		else
		{
			velocity.x = -32;
			if (x < startX - 96)
			{
				Reg.misses++;
				kill();
			}
		}
	}

	/**
	 * In the onUp function we check to see if the card has been matched, or if it is already revealed and skips the actions if so.
	 * We also check if we have already selected two cards, if so, we ignore the action.
	 * If we haven't already selected two cards, and if this card hasn't already been acted upon, we reveal the card.
	 */
	public function onUp(_):Void
	{
		// update score, kill sprite
		Reg.hits += 10;
		kill();
	}
}
