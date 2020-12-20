package;

import sys.io.File;
using Lambda;
using StringTools;

class D04A {
	static final input = File.getContent("D04.input");

	public static function main() {
		process();
	}

	static function process() {
		var passphrases = input.split("\n");

		var countValid = passphrases.count(isValidPassphrase);

		Sys.println('Count of valid passphrases = $countValid');
	}

	static function isValidPassphrase(passphrase:String):Bool {
		var words = passphrase.split(" ");
		var seen = new Map<String,Bool>();

		for (word in words) {
			if (seen.exists(word))
				return false;
			seen[word] = true;
		}

		return true;
	}
}
