package;

import sys.io.File;
using Lambda;
using StringTools;

class D01A {
	static final input = File.getContent("D01.input");
	// static final input = ("1111");

	public static function main() {
		process();
	}

	static function process() {
		// make circular by appending fst to end
		var _digits = input + input.charAt(0);
		var digits = _digits.split("").map(Std.parseInt);

		var sum = 0;
		for (idx => val in digits) 
			if (digits[idx + 1] == val)
				sum += val;
	
		Sys.println('Sum of digits matching neighbor = $sum');
	}
}
