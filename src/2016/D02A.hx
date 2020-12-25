package;

import sys.io.File;

using Lambda;
using StringTools;

class D02A {
	static final input = File.getContent("D02.input");

	public static function main() {
		var x = 1;
		var y = 1;
		var btnLayout = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
		var code = "";

		function max(a, b)
			return Std.int(Math.max(a, b));
		function min(a, b)
			return Std.int(Math.min(a, b));

		for (line in input.split("\n")) {
			for (cmd in line.iterator()) {
				switch (String.fromCharCode(cmd)) {
					case "U":
						y = max(0, y - 1);
					case "R":
						x = min(2, x + 1);
					case "D":
						y = min(2, y + 1);
					case "L":
						x = max(0, x - 1);
					case c:
						throw 'invalid cmd $c';
				}
			}
			code += btnLayout[y][x];
		}
		Sys.println('Bathroom code is $code');
	}
}
