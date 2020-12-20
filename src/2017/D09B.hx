package;

import sys.io.File;
using Lambda;
using StringTools;

class D09B {
	static var stream = File.getContent("D09.input");

	public static function main() {
		var isGarbage = false;
		var garbageCount = 0;
		var cursorIdx = 0;
		while (cursorIdx < stream.length) {
			var char = stream.charAt(cursorIdx);
			switch (char) {
				case "!":
					cursorIdx += 2;
					continue;
				case "<":
					if (isGarbage) 
						garbageCount++;
					else 
						isGarbage = true;
				case ">":
					isGarbage = false;
				case "{":
					if (isGarbage)
						garbageCount++;
				case "}":
					if (isGarbage) 
						garbageCount++;
				case _:
					if (isGarbage)
						garbageCount++;
			}
			cursorIdx++;
		}
		Sys.println('Count of garbage found in stream = $garbageCount');
	}
}
