package;

class D03B {
	static final input = File.getContent("D03.input");

	public static function main() {
		var validTris = 0;

		function toInt(str)
			return Std.parseInt(str);

		var data = [for (line in input.split("\n")) ~/\s+/g.split(line.trim())];
		for (i in 0...3) {
			var j = 0;
			while (j < data.length) {
				var a = toInt(data[j + 0][i]);
				var b = toInt(data[j + 1][i]);
				var c = toInt(data[j + 2][i]);
				j += 3;

				if (isValidTri(a, b, c))
					validTris++;
			}
		}
		Sys.println('Number of possible triangles is $validTris');
	}

	static inline function isValidTri(a:Int, b:Int, c:Int):Bool
		return (a + b > c) && (a + c > b) && (b + c > a);
}
