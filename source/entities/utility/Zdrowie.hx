package entities.utility;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class Zdrowie extends FlxSprite
{
    override public function new(x:Int, y:Int)
        {
            super(x, y);
            makeGraphic(5, 10, FlxColor.RED);
        }
}