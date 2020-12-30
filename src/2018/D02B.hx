package;

import sys.io.File;

using Lambda;
using StringTools;

class D02B {
	static var input = File.getContent("D02.input");

	public static function main() {
		var ids = input.split("\n");

		var combinations = [
			for (i in 0...ids.length) [
				for (j in i + 1...ids.length)
					{a: ids[i], b: ids[j]}
			]
		].flatten();

		var pair = combinations.find(p -> diffEq1(p.a, p.b));

		var commonLetters = [
			for (i in 0...pair.a.length)
				if (pair.a.fastCodeAt(i) == pair.b.fastCodeAt(i)) pair.a.charAt(i)
		].join("");

		Sys.println('Common letters of two correct box IDs are $commonLetters');
	}

	static function diffEq1(a:String, b:String):Bool {
		var found = false;
		for (i in 0...a.length) {
			if (a.fastCodeAt(i) != b.fastCodeAt(i)) {
				if (found)
					return false;
				found = true;
			}
		}
		return true;
	}
}
