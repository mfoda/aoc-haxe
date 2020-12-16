package;

import sys.io.File;

using Lambda;
using StringTools;

class D08A {
	public static function main() {
		process();
	}

	static function process() {
		function sum(a, b)
			return a + b;

		var lines = input.split("\n");
		var numOfCharsInCode = lines.map(x -> x.length).fold(sum, 0);
		var numOfCharsInMemory = lines.map(memorySize).fold(sum, 0);

		Sys.println('Number of characters in code = $numOfCharsInCode');
		Sys.println('Number of characters in memory = $numOfCharsInMemory');
		Sys.println('Subtracted = ${numOfCharsInCode - numOfCharsInMemory}');
	}

	static function memorySize(str:String):Int {
		var reg = ~/^"(.*)"$/;
		// remove surrounding quotes
		if (reg.match(str)) {
			str = reg.matched(1);
			// remove backslashes
			str = ~/(\\{2})/g.replace(str, "?");
			// remove quotes
			str = ~/(\\")/g.replace(str, "?");
			// remove hex digits
			str = ~/(\\x[0-9a-f]{2})/g.replace(str, "?");
		} else
			throw "string not enclosed in double quotes";

		return str.length;
	}

	static var input = File.getContent("D08.input");
}
