package;

import sys.io.File;
using Lambda;
using StringTools;

class D01B {
	static final input = File.getContent("D01.input");
	// static final input = ("1111");

	public static function main() {
		process();
	}

	static function process() {
		var digits = input.split("").map(Std.parseInt);
		var mid = Std.int(digits.length / 2);

		var sum = 0;
		for (idx => val in digits) {
			var halfway = (idx + mid) % digits.length;
			if (digits[halfway] == val)
				sum += val;
		}
	
		Sys.println('Sum of digits matching digit halfway around list = $sum');
	}
}
