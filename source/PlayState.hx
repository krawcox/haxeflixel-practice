package;

import flixel.text.FlxText;
import entities.utility.Zdrowie;
import entities.weapon.Miecz;
import entities.enemies.Boss;
import entities.projectiles.Fireball;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import entities.player.Hero;
import entities.terrain.Wall;
import flixel.FlxState;

class PlayState extends FlxState
{
	private static var WALL_COUNT(default, never) = 10;
	private static var WALL_START_X(default, never) = 150;
	private static var WALL_START_Y(default, never) = 200;

	private static var FIREBALL_COUNT(default, never) = 5;
	private static var FIREBALL_SPAWN_BORDER(default, never) = 50;
	private static var cel:FlxText;

	private var hero:Hero;
	private var zdrowie:FlxTypedGroup<Zdrowie>;
	private var walls:FlxTypedGroup<Wall>;
	private var fireballs:FlxTypedGroup<Fireball>;
	private var bron:Bool = false;
	private var opoznienie:Int = -1;
	private var miecz:Miecz;
	private var boss:Boss;

	override public function create():Void
	{
		super.create();
		cel = new FlxText(50, 4, "Kill evil red rectangle by reflecting fireballs with your mighty shield");
		boss = new Boss();
		hero = new Hero();
		add(hero);
		add(boss);
		fireballs = new FlxTypedGroup<Fireball>();
		trace(fireballs.length);
		initializeWalls();
		initializeHealth(boss);
		add(fireballs);
		add(cel);
	}
	private function initializeHealth(boss:Boss) 
	{
		zdrowie = new FlxTypedGroup<Zdrowie>();
		var licznik:Int = 10;
		for(i in 0...boss.zycie)
			{
				var serduszko = new Zdrowie(FlxG.camera.width - licznik, 4);
				zdrowie.insert(i, serduszko);
				licznik += 10;
			}
		add(zdrowie);
	}
	private function initializeWalls() {
		walls = new FlxTypedGroup<Wall>();

		for (i in 0...WALL_COUNT) {
			var x:Float = WALL_START_X + (i * Wall.WIDTH);
			var y:Float = WALL_START_Y;
			var wall:Wall = new Wall(x, y);
			walls.add(wall);
		}
		add(walls);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// Uncomment to collide hero against all wall objects.
		FlxG.collide(hero, walls);

		// Uncomment to trigger custom logic when a player overlaps with a fireball.
		FlxG.overlap(hero, fireballs, resolveHeroFireballOverlap);

		FlxG.overlap(boss, fireballs, resolveFireballBossOverlap);
		atak(hero);

		FlxG.overlap(miecz, fireballs, resolveMieczFireballOverlap);
		// Wrap various objects if gone offscreen.
		screenWrapObject(hero);
		screenbounce(boss);
		for (fireball in fireballs) {
			if(fireball.x == -100)
				{
					fireball.destroy();
				}
		}
		if(boss.shot)
			{
				var fireball = new Fireball(boss.x - 10, boss.y + 18);
				fireballs.add(fireball);
				add(fireballs);
			}
	}

	private function screenWrapObject(wrappingObject:FlxObject) {
		if (wrappingObject.x > FlxG.width) {
			wrappingObject.x = 0 - wrappingObject.width;
		} else if (wrappingObject.x + wrappingObject.width < 0) {
			wrappingObject.x = FlxG.width;
		}

		if (wrappingObject.y > FlxG.height) {
			wrappingObject.y = 0 - wrappingObject.height;
		} else if (wrappingObject.y + wrappingObject.height < 0) {
			wrappingObject.y = FlxG.height;
		}
	}
	private function screenbounce(object:FlxObject)
		{
			if(object.y < 0 || object.y + object.height > FlxG.height)
				{
					object.velocity.y = -object.velocity.y;
				}
		}

	/**
		Function called when an overlap between hero and fireball is detected.
	**/
	private function resolveHeroFireballOverlap(hero:Hero, fireball:Fireball)
	{
		fireball.kill();
		hero.kill();
		var przegrana:FlxText = new FlxText(FlxG.camera.width/2 - 50, FlxG.camera.height/3, 100, "Your skills are pathetic");
		add(przegrana);
	}

	private function atak(hero:Hero)
		{
			if(hero.alive || opoznienie >= 0)
			{
			if(FlxG.keys.justPressed.W && opoznienie < 0)
				{
					opoznienie = 30;
				}
			if(opoznienie == 30)
				{
					var pocz_x:Float = hero.x + 35;
					var pocz_y:Float = hero.y - 10;
					miecz = new Miecz(pocz_x, pocz_y);
					add(miecz);
					opoznienie--;
				}
			else if(opoznienie > 0 && opoznienie < 30)
				{
					miecz.x = hero.x + 35;
					miecz.y = hero.y - 10;
					opoznienie--;
				}
			else if(opoznienie == 0)
				{
					miecz.kill();
					opoznienie = -1;
				}
			}
		}
	private function resolveMieczFireballOverlap(miecz:Miecz, fireball:Fireball)
		{
			fireball.velocity.x = 100;
		}
	private function resolveFireballBossOverlap(boss:Boss, fireball:Fireball)
		{
			fireball.kill();
			for(serduszko in zdrowie)
				{
					if(serduszko.alive)

					{serduszko.kill();
					break;
					}
				}
			boss.hit();
			if(boss.zycie == 0)
				{
					boss.kill();
					var wygrana:FlxText = new FlxText(FlxG.camera.width/2 - 50, FlxG.camera.height/3, 100, "You win!!!");
					add(wygrana);
				}
		}
}
