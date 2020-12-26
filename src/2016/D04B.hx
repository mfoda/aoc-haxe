package;

import sys.io.File;

using Lambda;
using StringTools;

typedef Room = {
	name:String,
	sector:Int,
	checksum:String
}

class D04B {
	static final input = File.getContent("D04.input");

	public static function main() {
		var realRooms = input.split("\n").map(parseRoom).filter(isRealRoom);
		var northPole = realRooms.find(x -> decryptRoom(x).contains("northpole"));
		Sys.println('Sector ID of room where North Pole objects are stored is ${northPole.sector}');
	}

	static function decryptRoom(room:Room):String {
		var result = "";
		for (charCode in room.name.iterator()) {
			var char = String.fromCharCode(charCode);
			if (char == "-") {
				result += " ";
				continue;
			}
			var nxt = charCode;
			for (_ in 0...room.sector)
				nxt = (nxt % 97 + 1) % 26 + 97;
			result += String.fromCharCode(nxt);
		}
		return result;
	}

	static function isRealRoom(room:Room):Bool {
		var letterFreq = tallyFreq(room.name.replace("-", ""));
		var top5 = topN(letterFreq, 5);
		return top5.join("") == room.checksum;
	}

	static function topN(map:Map<String, Int>, n:Int):Array<String> {
		var entries = [for (k => v in map.keyValueIterator()) {k: k, v: v}];
		entries.sort((p1, p2) -> {
			var c = 0;
			if (p1.v > p2.v)
				c = -1;
			else if (p1.v < p2.v)
				c = 1;
			else if (p1.k > p2.k)
				c = 1;
			else if (p1.k < p2.k)
				c = -1;
			else
				c = 0;
			return c;
		});
		return [
			for (i in 0...n)
				entries[i].k
		];
	}

	static function tallyFreq(str:String):Map<String, Int> {
		var freq = new Map<String, Int>();
		for (charCode in str) {
			var char = String.fromCharCode(charCode);
			if (freq.exists(char))
				freq[char]++;
			else
				freq[char] = 1;
		}
		return freq;
	}

	static function parseRoom(str:String):Room {
		var reg = ~/((\w+-)+)(\d+)\[(\w+)\]/;
		if (!reg.match(str))
			throw "parse room failed";

		var name = reg.matched(1);
		var sector = Std.parseInt(reg.matched(3));
		var checksum = reg.matched(4);
		return {
			name: name,
			sector: sector,
			checksum: checksum
		};
	}
}
