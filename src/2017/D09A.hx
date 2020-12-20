package;

import sys.io.File;
using Lambda;
using StringTools;

class D09A {
	static var stream = File.getContent("D09.input");

	public static function main() {
		var score = 0;
		var groupScore = 0;
		var isGarbage = false;
		var cursorIdx = 0;
		while (cursorIdx < stream.length) {
			var char = stream.charAt(cursorIdx);
			switch (char) {
				case "!":
					cursorIdx += 2;
					continue;
				case "<":
					isGarbage = true;
				case ">":
					isGarbage = false;
				case "{":
					if (!isGarbage)
						groupScore++;
				case "}":
					if (!isGarbage) {
						score += groupScore;
						groupScore--;
					}
				case _:
			}
			cursorIdx++;
		}
		Sys.println('Score of groups found in stream = $score');
	}
}
