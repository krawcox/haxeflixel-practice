package;

import flixel.FlxState;
import flixel.text.FlxText;


class PlayState extends FlxState
{
	public var tekst:FlxText = new FlxText("hello there");
	public var bohater:Hero = new Hero(25, 25);
	public var bohater_1:Hero = new Hero(10, 23);
	public var bohater_2:Hero = new Hero(6, 2);
	public var bohater_3:Hero = new Hero(10, 10);
	public var bohater_4:Hero = new Hero(2, 27);
	public var bohater_5:Hero = new Hero(50, 15);
	public var bohater_6:Hero = new Hero(14, 7);
	override public function create()
	{
		super.create();
		var wyglad:FlxTextFormat = new FlxTextFormat(0xFF00FFFF, true, true, 0x00000000);
		tekst.addFormat(wyglad);
		add(tekst); 
		add(bohater);
		add(bohater_1);
		add(bohater_2);
		add(bohater_3);
		add(bohater_4);
		add(bohater_5);
		add(bohater_6);
		}

	override public function update(elapsed:Float)
	{
		tekst.x += 2;
		tekst.y += 1;
		bohater.update(elapsed);
		bohater_1.update(elapsed);
		bohater_2.update(elapsed);
		bohater_3.update(elapsed);
		bohater_4.update(elapsed);
		bohater_5.update(elapsed);
		bohater_6.update(elapsed);
		super.update(elapsed);
		
	}
}
