package;

import sys.io.File;

using Lambda;
using StringTools;

typedef Segments = {
	outside:Array<String>,
	inside:Array<String>
}

class D07A {
	static final input = File.getContent("D07.input");

	public static function main() {
		var count = input.split("\n").count(x -> supportsTLS(parseIP(x)));
		Sys.println('Number of IPs supporting TLS is $count');
	}

	static function supportsTLS(seg:Segments):Bool {
		return seg.outside.exists(isABBA) && !seg.inside.exists(isABBA);
	}

	static function isABBA(str:String):Bool {
		function flip(str:String)
			return [for (i in 0...str.length) str.charAt(str.length - i - 1)].join("");

		for (i in 0...str.length - 3) {
			var chunk = str.substr(i, 4);
			var ab = chunk.substr(0, 2);
			var ba = chunk.substr(2, 2);
			if (ab == flip(ba) && (ab.charAt(1) != ba.charAt(1)))
				return true;
		}
		return false;
	}

	static function parseIP(str:String):Segments {
		var ins = ~/\[(\w+)\]/g;
		var outside = ins.split(str);
		var inside = [];
		while (ins.match(str)) {
			inside.push(ins.matched(1));
			str = ins.matchedRight();
		}
		return {outside: outside, inside: inside};
	}
}
