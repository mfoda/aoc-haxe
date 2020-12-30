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

class D03B {
	static var input = File.getContent("D03.input");
	static inline var OVERLAPPED = -1;
	static inline var EMPTY = 0;
	static inline var RECTSIDE = 1000;

	public static function main() {
		var claims = input.split("\n").map(parseClaim);
		var rect = [for (i in 0...RECTSIDE) [for (j in 0...RECTSIDE) EMPTY]];

		function markClaim(clm:Claim) {
			for (h in 0...clm.height)
				for (w in 0...clm.width) {
					var val = rect[clm.top + h][clm.left + w];
					rect[clm.top + h][clm.left + w] = val == EMPTY ? clm.id : OVERLAPPED;
				}
		}
		function notOverlapped(clm:Claim) {
			for (h in 0...clm.height)
				for (w in 0...clm.width) {
					if (rect[clm.top + h][clm.left + w] != clm.id)
						return false;
				}
			return true;
		}

		claims.iter(markClaim);
		Sys.println('ID of only claim that doesn\'t overlap is ${claims.find(notOverlapped)}');
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
