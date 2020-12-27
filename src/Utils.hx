package src;

class Utils {
	public static function intAt(str:String, idx:Int):Int {
		var it = Std.parseInt(str.charAt(idx));
		return it != null ? it : throw 'could not parse int in $str';
	}
}
