package;

class D09A {
	static final input = File.getContent("D09.input");

	public static function main() {
		var seq = input;
		var sb = new StringBuf();
		var i = 0;
		while (i < seq.length) {
			var startIdx = seq.indexOf("(", i);
			var endIdx = seq.indexOf(")", i);

			// no more markers, add remaining chars
			if (startIdx == -1) {
				sb.add(seq.substr(i));
				break;
			}
			// push chars with no marker
			sb.add(seq.substring(i, startIdx));

			// push decompressed chars after marker
			var marker = seq.substring(startIdx + 1, endIdx).split("x");
			var markerLength = Std.parseInt(marker[0]);
			var markerCount = Std.parseInt(marker[1]);
			sb.add(decompress(seq.substr(endIdx + 1), markerLength, markerCount));

			i = endIdx + 1 + markerLength;
		}
		Sys.println('Decompressed length of sequence is ${sb.toString().length}');
	}

	static function decompress(seq:String, length:Int, count:Int):String
		return [for (_ in 0...count) seq.substr(0, length)].join("");
}
