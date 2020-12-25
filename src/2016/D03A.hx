package;

import sys.io.File;

using Lambda;
using StringTools;

class D03A
{
	static final input = File.getContent("D03.input");

	public static function main()
	{
		var validTris = 0;

		function toInt(str)
			return Std.parseInt(str);

		for (line in input.split("\n"))
		{
			var tri = ~/\s+/g.split(line.trim());
			var a = toInt(tri[0]);
			var b = toInt(tri[1]);
			var c = toInt(tri[2]);

			if (isValidTri(a, b, c))
				validTris++;
		}
		Sys.println('Number of possible triangles is $validTris');
	}

	static inline function isValidTri(a:Int, b:Int, c:Int):Bool
		return (a + b > c) && (a + c > b) && (b + c > a);
}
