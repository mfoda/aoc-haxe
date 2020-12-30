package;

import sys.io.File;

using Lambda;
using StringTools;

typedef Claim = {
	id:Int,
	left:Int,
	top:Int,
	width:Int,
	height:Int
}

class D03A {
	static var input = File.getContent("D03.input").split("\n");

	public static function main() {
		var claims = input.map(parseClaim);
		var rect = [for (i in 0...1000) [for (j in 0...1000) 0]];
		function markClaim(clm:Claim) {
			for (h in 0...clm.height)
				for (w in 0...clm.width)
					rect[clm.top + h][clm.left + w]++;
		}
		claims.iter(markClaim);

		var twoOrMoreClaims = [for (row in rect) [for (col in row) col >= 2]].flatten().count(x -> x);

		Sys.println('Number of square inches of fabic with two or more claims is $twoOrMoreClaims');
	}

	static function parseClaim(str:String):Claim {
		var reg = ~/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/;
		if (!reg.match(str))
			throw "claim did not match pattern";

		function matchedInt(n)
			return Std.parseInt(reg.matched(n));

		return {
			id: matchedInt(1),
			left: matchedInt(2),
			top: matchedInt(3),
			width: matchedInt(4),
			height: matchedInt(5)
		};
	}
}
