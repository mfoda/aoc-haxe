package;

import sys.io.File;

using Lambda;
using StringTools;

class D05B {
	static var input = File.getContent("D05.input");

	public static function main() {
		var polymer = input;
		var removeType = t -> new EReg('$t+', "ig").replace(polymer, "");
		var unitTypes = [for (i in 0...26) String.fromCharCode(97 + i)];
		var removed = [for (t in unitTypes) reducePolymer(removeType(t)).length];
		removed.sort(Reflect.compare);
		Sys.println('Length of shortest possible polymer = ${removed[0]}');
	}

	static function reducePolymer(polymer:String):String {
		function isOppositePolarity(a:String, b:String):Bool
			return a != b && a.toLowerCase() == b.toLowerCase();

		var units = polymer.split("");
		var idx = 0;
		while (idx < units.length - 1) {
			var a = units[idx];
			var b = units[idx + 1];
			if (isOppositePolarity(a, b)) {
				units.splice(idx, 2);
				idx = Std.int(Math.max(0, idx - 1));
			} else
				idx++;
		}
		return units.join("");
	}
}
