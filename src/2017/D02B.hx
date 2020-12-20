package;

import sys.io.File;
using Lambda;
using StringTools;

class D02B {
	static final input = File.getContent("D02.input");

	public static function main() {
		process();
	}

	static function process() {
		var rows = input.split("\n");

		var sum = 0;
		for (row in rows) {
			var nums = ~/\s/g.split(row).map(Std.parseInt);
			var pairs = [for (i in nums) [for (j in nums.slice(1)) [i, j]]].flatten();
			var divisors = pairs.find(p -> (p[0] != p[1]) && (p[0] % p[1] == 0 || p[1] % p[0] == 0));
			divisors.sort((a, b) -> a > b ? 1 : -1);
			var division = Std.int(divisors[1] / divisors[0]);

			sum += division;
		}

		Sys.println('Spreadsheet\'s sum of each row\'s result = $sum');
	}
}
