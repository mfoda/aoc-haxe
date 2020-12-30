package;

import sys.io.File;

using Lambda;
using StringTools;

class D02A {
	static var input = File.getContent("D02.input");

	public static function main() {
		var ids = input.split("\n");
		var idFreq = ids.map(letterFreq);
		var count2 = 0;
		var count3 = 0;

		for (freq in idFreq) {
			if (freq.find(v -> v == 2) != null)
				count2++;
			if (freq.find(v -> v == 3) != null)
				count3++;
		}
		var checksum = count2 * count3;
		Sys.println('Checksum of box IDs is $checksum');
	}

	static function letterFreq<T>(str:String):Map<Int, Int> {
		var freq = new Map<Int, Int>();
		for (x in str.iterator()) {
			if (freq.exists(x))
				freq[x]++;
			else
				freq[x] = 1;
		}
		return freq;
	}
}
