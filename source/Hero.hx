package;

import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxRandom;
import lime.math.ColorMatrix;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Hero extends FlxSprite
{
    public var predkosc_x:Int;
    public var predkosc_y:Int;
    FlxMouseEventManager.add(this, onMouseDown);
    public function onMouseDown(object:Hero)
        {
            this.predkosc_x -= 2;
        }
    override public function new(x, y)
        {
            super();
            var q:FlxRandom = new FlxRandom();
            var p:FlxRandom = new FlxRandom();
            this.predkosc_x = q.int(0,10);
            this.predkosc_y = p.int(0, 10);
            this.makeGraphic(x, y);
        }
    override public function update(elapsed:Float)
        {
            var tak:FlxRandom = new FlxRandom();
            var kolor:FlxColor = tak.color(0x00000000, 0xFFFFFFFF);
            this.color = kolor;
            this.x += predkosc_x;
            this.y += predkosc_y;
            if(!this.isOnScreen())
                {
                    var k:Float = this.x;
                    var l:Float = this.y;
                    this.x =  0;
                    if(!this.isOnScreen())
                        {
                            this.x = k;
                            this.y = 0;
                            if(!this.isOnScreen())
                                {
                                    this.x = 0;
                                    this.y = 0;
                                }
                        }
                }
            
        }
}