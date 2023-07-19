package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.input.mouse.FlxMouseEvent;
import flixel.math.FlxPoint;

class Spider extends FlxSprite
{
	private var startX:Int;
	private var startY:Int;
	private var running:Bool = false;

	public function new(X:Int, Y:Int, Texture:FlxFramesCollection)
	{
		// X,Y: Starting coordinates
		super(X, Y);

		startX = X;
		startY = Y;

		// we load in the frames collection and use it as the base sprite.
		frames = Texture; // frames is a variable inhereted from FlxSprite

		animation.addByNames("idle", ["spider1", "spider2"], 4, true);
		animation.play("idle");

		setFacingFlip(UP, false, true);
		setFacingFlip(DOWN, false, false);

		origin = FlxPoint.get(16, 16);

		FlxMouseEvent.add(this, null, onUp, null, null); // We set an onup mouse action so when a player clicks on the card we can perform actions
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		trace(angle);
		if (facing == DOWN)
		{
			if (y > startY + 48 && !running)
			{
				velocity.y = 0;
				angle += 1;
				if (angle == 180)
				{
					running = true;
				}
			}
			else if (running && y < startY)
			{
				Reg.misses++;
				kill();
			}
			else
			{
				if (running)
				{
					velocity.y = -32;
				}
				else
				{
					velocity.y = 32;
				}
			}
		}
		else
		{
			if (y < startY - 48 && !running)
			{
				velocity.y = 0;
				angle += 1;
				if (angle == 180)
				{
					running = true;
				}
			}
			else if (running && y > startY)
			{
				Reg.misses++;
				kill();
			}
			else
			{
				if (running)
				{
					velocity.y = 32;
				}
				else
				{
					velocity.y = -32;
				}
			}
		}
		// angle += 1;
	}

	/**
	 * In the onUp function we check to see if the card has been matched, or if it is already revealed and skips the actions if so.
	 * We also check if we have already selected two cards, if so, we ignore the action.
	 * If we haven't already selected two cards, and if this card hasn't already been acted upon, we reveal the card.
	 */
	public function onUp(_):Void
	{
		// update score, kill sprite
		Reg.hits += 15;
		kill();
	}
}
