package;

import sys.io.File;
using Lambda;
using StringTools;

class D05B {
	static final input = File.getContent("D05.input");

	public static function main() {
		var instructions = input.split("\n").map(Std.parseInt);

		var idx = 0;
		var steps = 0;
		while (idx < instructions.length) {
			steps++;
			var inst = instructions[idx];
			instructions[idx] = inst >= 3 ? (inst - 1) : (inst + 1);
			idx += inst;
		}

		Sys.println('Steps taken until exit = $steps');
	}
}
