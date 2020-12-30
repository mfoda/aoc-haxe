package;

import sys.io.File;

using Lambda;
using StringTools;

class D01A {
	static var input = File.getContent("D01.input");

	public static function main() {
		function sum(a, b)
			return a + b;

		var freqChanges = input.split("\n").map(Std.parseInt);
		var resultingFreq = freqChanges.fold(sum, 0);

		Sys.println('Resulting frequency after applying changes is $resultingFreq');
	}
}
