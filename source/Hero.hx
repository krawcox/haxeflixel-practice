package;

import flixel.math.FlxRandom;
import lime.math.ColorMatrix;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.FlxG;
class Hero extends FlxSprite
{
    public var predkosc_x:Int;
    public var predkosc_y:Int;
    override public function new(x, y)
        {
            super();
            var q:FlxRandom = new FlxRandom();
            var p:FlxRandom = new FlxRandom();
            this.predkosc_x = q.int(-5, 5);
            this.predkosc_y = p.int(-5, 5);
            this.makeGraphic(x, y);
        }
    override public function update(elapsed:Float)
        {
            var tak:FlxRandom = new FlxRandom();
            var kolor:FlxColor = tak.color(0x00000000, 0xFFFFFFFF);
            this.color = kolor;
            if(this.x > FlxG.camera.width)
                {
                    this.x = 0;
                }
            else if(this.x < 0)
                {
                    this.x = FlxG.camera.width;
                }
            if(this.y > FlxG.camera.height)
                {
                    this.y = 0;
                }
            else if(this.y < 0)
                {
                    this.y = FlxG.camera.height;
                }
            this.x += predkosc_x;
            this.y += predkosc_y;
           
            
        }
}