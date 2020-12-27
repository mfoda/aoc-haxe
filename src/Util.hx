package src;

class Util {
	public static function byAscending(a:Int, b:Int):Int
		return a > b ? 1 : -1;

	public static function byDescending(a:Int, b:Int):Int
		return a < b ? 1 : -1;
}

class Extensions {
	public static function intAt(str:String, idx:Int):Null<Int> {
		var it = Std.parseInt(str.charAt(idx));
		return it != null ? it : throw 'could not parse int in $str';
	}

	public static function matchedInt(reg:EReg, idx:Int):Int {
		var it = Std.parseInt(reg.matched(idx));
		return it != null ? it : throw 'could not parse int in $reg';
	}

	public static function sum(collection:Iterable<Int>) {
		var sum = 0;
		for (e in collection.iterator())
			sum += e;
		return sum;
	}
}
