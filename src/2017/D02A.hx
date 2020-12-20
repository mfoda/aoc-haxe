package;

import sys.io.File;
using Lambda;
using StringTools;

class D02A {
	static final input = File.getContent("D02.input");

	public static function main() {
		process();
	}

	static function process() {
		var rows = input.split("\n");

		var checksum = 0;
		for (row in rows) {
			var nums = ~/\s/g.split(row).map(Std.parseInt);
			nums.sort((a, b) -> a > b ? 1 : - 1);

			var smallest = nums[0];
			var largest = nums[nums.length - 1];
		
			checksum += largest - smallest;
		}

		Sys.println('Spreadsheet\'s checksum = $checksum');
	}
}
