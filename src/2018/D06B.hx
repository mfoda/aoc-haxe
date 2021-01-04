package;

import sys.io.File;

using Lambda;
using StringTools;

typedef Coord = {
	x:Int,
	y:Int
}

class D06B {
	static var input = File.getContent("D06.input");

	public static function main() {
		var coords = input.split("\n").mapi((i, e) -> parseCoordinate(i, e));
		var xs = coords.map(c -> c.x);
		var ys = coords.map(c -> c.y);
		xs.sort(Reflect.compare);
		ys.sort(Reflect.compare);
		var maxX = xs[xs.length - 1];
		var maxY = ys[ys.length - 1];
		var grid = [for (_ in 0...maxY + 1) [for (_ in 0...maxX + 1) "."]];

		for (y in 0...maxY + 1) {
			for (x in 0...maxX + 1) {
				var totalDistances = totalDistances({x: x, y: y}, coords);
				var symbol = totalDistances < 10000 ? "#" : "X";
				grid[y][x] = symbol;
			}
		}

		function calculateArea(symbol:String) {
			var area = 0;
			for (row in grid)
				for (col in row)
					if (col == symbol)
						area++;
			return area;
		}

		Sys.println('Size of region is ${calculateArea("#")}');
	}

	static inline function totalDistances(coord:Coord, coords:Array<Coord>):Int {
		return coords.fold((x, acc) -> manhattanDist(x, coord) + acc, 0);
	}

	static inline function manhattanDist(c1:Coord, c2:Coord):Int {
		var it = Math.abs(c1.x - c2.x) + Math.abs(c1.y - c2.y);
		return Std.int(it);
	}

	static inline function parseCoordinate(index:Int, str:String):Coord {
		var pair = str.split(",");
		return {
			x: Std.parseInt(pair[0]),
			y: Std.parseInt(pair[1])
		};
	}
}
