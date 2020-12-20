package;

import sys.io.File;
using Lambda;
using StringTools;

class D04B {
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
		for (i in 0...words.length)
			for (j in i + 1...words.length)
				if (isAnagram(words[i], words[j]))
					return false;
		return true;
	}

	static function isAnagram(a:String, b:String):Bool {
		function byAscending(a:String, b:String)
			return a > b ? 1 : -1;

		if (a.length != b.length)
			return false;

		var lettersA = a.split("");
		var lettersB = b.split("");
		lettersA.sort(byAscending);
		lettersB.sort(byAscending);

		return lettersA.join("") == lettersB.join("");
	}
}
