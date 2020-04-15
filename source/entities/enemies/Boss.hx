package entities.enemies;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxRandom;

class Boss extends FlxSprite
{
    public var shot:Bool = false;
    private var kierunek:Bool;
    private var los:FlxRandom;
    private var timer:Int = 50;
    private var licznik:Int;
    public var zycie:Int = 5;
    override public function new() 
        {
        super(FlxG.camera.width - 50, 250);
        makeGraphic(50, 50, FlxColor.RED);
        los = new FlxRandom();
        kierunek = los.bool();
        licznik = 5;
        if(kierunek)
            {
                velocity.y = 35;
            }
        else
            {
                velocity.y = -35;
            }
        }
        override function update(elapsed:Float)
            {
                timer--;
                licznik--;
                if(licznik == 0)
                    {
                        shot = true;
                        licznik = 50;
                    }
                else 
                    {
                        shot = false;
                    }
                if(timer == 0)
                    {
                        velocity.y = los.int(-50, 50);
                        timer = los.int(30, 60);
                    }
                super.update(elapsed);
                
            }
        public function hit()
            {
                zycie--;
            }
}