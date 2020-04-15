package entities.weapon;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class Miecz extends FlxSprite
{
    override public function new(pocz_x, pocz_y)
        {
            super(pocz_x, pocz_y);
            makeGraphic(10, 42, FlxColor.GRAY);

        }
}