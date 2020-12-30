package;

import sys.io.File;

using Lambda;
using StringTools;

class D01B {
	static var input = File.getContent("D01.input");

	public static function main() {
		var freqChanges = input.split("\n").map(Std.parseInt);
		var resultingFreq = 0;
		var seenFreq = [resultingFreq];

		var idx = 0;
		while (true) {
			resultingFreq += freqChanges[idx];
			if (seenFreq.contains(resultingFreq))
				break;
			seenFreq.push(resultingFreq);
			idx = (idx + 1) % freqChanges.length;
		}

		Sys.println('First frequency reached twice is $resultingFreq');
	}
}
