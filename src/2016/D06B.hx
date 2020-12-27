package;

class D06B {
	static final input = File.getContent("D06.input");

	public static function main() {
		var letters = input.split("\n").map(x -> x.split(""));
		var corrected = "";
		for (i in 0...letters[0].length) {
			var column = [for (row in letters) row[i]];
			corrected += mostFreq(column);
		}
		Sys.println('Error-corrected version of message is $corrected');
	}

	static function mostFreq(letters:Array<String>):String {
		var freq = new Map<String, Int>();
		for (letter in letters)
			if (freq.exists(letter))
				freq[letter]++;
			else
				freq[letter] = 1;

		var sorted = [for (k => v in freq.keyValueIterator()) {letter: k, freq: v}];
		sorted.sort((a, b) -> a.freq < b.freq ? -1 : 1);

		return sorted[0].letter;
	}
}
