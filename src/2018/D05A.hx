package;

import sys.io.File;

using Lambda;
using StringTools;

class D05A {
	static var input = File.getContent("D05.input");

	public static function main() {
		function isOppositePolarity(a:String, b:String):Bool
			return a != b && a.toLowerCase() == b.toLowerCase();

		var units = input.split("");
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
		Sys.println('Number of units remaining after fully reacting the polymer = ${units.length}');
	}
}
