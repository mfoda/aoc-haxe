package;

import sys.io.File;

using Lambda;
using StringTools;

typedef Screen = Array<Array<Bool>>;

enum Instruction {
	rect(w:Int, h:Int);
	rotateRow(y:Int, n:Int);
	rotateCol(x:Int, n:Int);
}

class D08 {
	static final input = File.getContent("D08.input");
	static inline var ON = "#";
	static inline var OFF = ".";
	static inline var WIDTH = 50;
	static inline var HEIGHT = 6;

	public static function main() {
		var screen = [for (_ in 0...HEIGHT) [for (_ in 0...WIDTH) false]];
		var instructions = input.split("\n").map(parseInstruction);
		instructions.iter(ins -> execute(ins, screen));
		var countLit = screen.flatten().count(on -> on);
		Sys.println('Count of lit pixels is $countLit\n');
		render(screen);
	}

	static function render(screen:Screen) {
		for (row in screen)
			Sys.println(row.map(x -> x ? ON : OFF));
	}

	static function execute(ins:Instruction, screen:Screen) {
		function rotate(row:Array<Bool>, n:Int) {
			var shifted = row.slice(0, -n);
			var over = row.slice(-n);
			return over.concat(shifted);
		}

		switch (ins) {
			case rect(w, h):
				for (x in 0...w)
					for (y in 0...h)
						screen[y][x] = true;
			case rotateRow(y, n):
				screen[y] = rotate(screen[y].copy(), n % WIDTH);
			case rotateCol(x, n):
				var asRow = [for (i in 0...HEIGHT) screen[i][x]];
				var rotated = rotate(asRow, n % HEIGHT);
				for (i in 0...HEIGHT)
					screen[i][x] = rotated[i];
		}
	}

	static function parseInstruction(str:String):Instruction {
		var reg = ~/rect (\d+)x(\d+)/;
		if (reg.match(str)) {
			var w = Std.parseInt(reg.matched(1));
			var h = Std.parseInt(reg.matched(2));
			return rect(w, h);
		}
		var reg = ~/rotate row y=(\d+) by (\d+)/;
		if (reg.match(str)) {
			var y = Std.parseInt(reg.matched(1));
			var n = Std.parseInt(reg.matched(2));
			return rotateRow(y, n);
		}
		var reg = ~/rotate column x=(\d+) by (\d+)/;
		if (reg.match(str)) {
			var x = Std.parseInt(reg.matched(1));
			var n = Std.parseInt(reg.matched(2));
			return rotateCol(x, n);
		}
		throw "parse instruction failed";
	}
}
