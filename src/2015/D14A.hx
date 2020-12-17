package;

using Lambda;
using StringTools;

class Reindeer {
	var isResting:Bool;
	var secondsTillSwitch:Int;
	public var distanceRan(default, null):Int;
	public var name(default, null):String;
	public var speed(default, null):Int; // km per second
	public var endurance(default, null):Int; // seconds
	public var rest(default, null):Int; // seconds

	static final reg = 
		~/(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds./;

	public function new(description:String) {
		if (!reg.match(description))
			throw "invalid initializer description";

		var m = reg.matched;
		name = m(1);
		speed = Std.parseInt(m(2));
		endurance = Std.parseInt(m(3));
		rest = Std.parseInt(m(4));
		isResting = false;
		secondsTillSwitch = endurance;
		distanceRan = 0;
	}

	public function simulate():Void {
		if (secondsTillSwitch == 0) {
			isResting = !isResting;
			secondsTillSwitch = isResting ? rest : endurance;
		}
		if (!isResting)
			distanceRan += speed;

		secondsTillSwitch--;
	} 
}

class D14A {
	public static function main() {
		process();
	}

	static function process() {
		var reindeers = input.split("\n").map(x -> new Reindeer(x));

		for (i in 0...2503)
			for (reindeer in reindeers)
				reindeer.simulate();

		reindeers.sort((a, b) -> a.distanceRan > b.distanceRan ? -1 : 1);
		for (i => r in reindeers.keyValueIterator())
			Sys.println('#${i+1} ${r.name} ran ${r.distanceRan} km');
	}

	static var input = "Vixen can fly 8 km/s for 8 seconds, but then must rest for 53 seconds.
Blitzen can fly 13 km/s for 4 seconds, but then must rest for 49 seconds.
Rudolph can fly 20 km/s for 7 seconds, but then must rest for 132 seconds.
Cupid can fly 12 km/s for 4 seconds, but then must rest for 43 seconds.
Donner can fly 9 km/s for 5 seconds, but then must rest for 38 seconds.
Dasher can fly 10 km/s for 4 seconds, but then must rest for 37 seconds.
Comet can fly 3 km/s for 37 seconds, but then must rest for 76 seconds.
Prancer can fly 9 km/s for 12 seconds, but then must rest for 97 seconds.
Dancer can fly 37 km/s for 1 seconds, but then must rest for 36 seconds.";
}
