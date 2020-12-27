package;

typedef Room = {
	name:String,
	sector:Int,
	checksum:String
}

class D04A {
	static final input = File.getContent("D04.input");

	public static function main() {
		var realRooms = input.split("\n").map(parseRoom).filter(isRealRoom);
		var sum = realRooms.fold((x, acc) -> x.sector + acc, 0);
		Sys.println('Sum of sectors IDs of real rooms is $sum');
	}

	static function isRealRoom(room:Room):Bool {
		var letterFreq = tallyFreq(room.name);
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

		var name = reg.matched(1).replace("-", "");
		var sector = Std.parseInt(reg.matched(3));
		var checksum = reg.matched(4);
		return {
			name: name,
			sector: sector,
			checksum: checksum
		};
	}
}
