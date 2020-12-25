package;

import sys.io.File;

using Lambda;
using StringTools;

class D02B {
	static final input = File.getContent("D02.input");

	static inline var NUL = "_";

	public static function main() {
		var x = 0;
		var y = 2;
		var btnLayout = [
			[NUL, NUL, "1", NUL, NUL],
			[NUL, "2", "3", "4", NUL],
			["5", "6", "7", "8", "9"],
			[NUL, "A", "B", "C", NUL],
			[NUL, NUL, "D", NUL, NUL]
		];
		var code = "";

		function max(a, b)
			return Std.int(Math.max(a, b));
		function min(a, b)
			return Std.int(Math.min(a, b));

		for (line in input.split("\n")) {
			for (cmd in line.iterator()) {
				switch (String.fromCharCode(cmd)) {
					case "U":
						var nxtRow = btnLayout[y - 1];
						var nxtRowValid = nxtRow != null && nxtRow[x] != NUL;
						y = nxtRowValid ? max(0, y - 1) : y;
					case "D":
						var nxtRow = btnLayout[y + 1];
						var nxtRowValid = nxtRow != null && nxtRow[x] != NUL;
						y = nxtRowValid ? min(btnLayout.length - 1, y + 1) : y;
					case "R":
						x = (btnLayout[y][x + 1] != NUL) ? min(btnLayout[y].length - 1, x + 1) : x;
					case "L":
						x = (btnLayout[y][x - 1] != NUL) ? max(0, x - 1) : x;
					case c:
						throw 'invalid cmd $c';
				}
			}
			code += btnLayout[y][x];
		}
		Sys.println('Bathroom code is $code');
	}
}
