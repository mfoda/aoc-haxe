package;

import sys.io.File;

using Lambda;
using StringTools;

typedef Coord = {
	x:Int,
	y:Int,
	?symbol:String
}

// todo: fix candidate coordinates filtering
class D06A {
	static var input = File.getContent("D06.input");

	public static function main() {
		var coords = input.split("\n").mapi((i, e) -> parseCoordinate(i, e));
		var xs = coords.map(c -> c.x);
		var ys = coords.map(c -> c.y);
		xs.sort(Reflect.compare);
		ys.sort(Reflect.compare);
		var minX = xs[0];
		var minY = ys[0];
		var maxX = xs[xs.length - 1];
		var maxY = ys[ys.length - 1];
		var grid = [for (_ in 0...maxY + 1) [for (_ in 0...maxX + 1) "."]];

		for (y in 0...maxY + 1) {
			for (x in 0...maxX + 1) {
				var nearestIdx = nearestCoordinate({x: x, y: y}, coords);
				var symbol = nearestIdx == null ? "." : coords[nearestIdx].symbol;
				grid[y][x] = symbol;
			}
		}

		inline function calculateArea(symbol:String) {
			var area = 0;
			for (row in grid)
				for (col in row)
					if (col == symbol)
						area++;
			return area;
		}
		// only consider coordinates inside bounds
		var candidateCoords = coords.filter(c -> c.x > minX && c.x < maxX && c.y > minY && c.y < maxY);
		var areas = candidateCoords.map(c -> calculateArea(c.symbol));
		areas.sort((a, b) -> a < b ? 1 : -1);
		Sys.println(areas[0]);
	}

	static inline function nearestCoordinate(coord:Coord, coords:Array<Coord>):Int {
		var distances = coords.map(x -> manhattanDist(x, coord));
		var sorted = distances.copy();
		sorted.sort((a, b) -> a > b ? 1 : -1);
		// should not have 2 or more coordinates of equal distance
		if (sorted[0] == sorted[1])
			return null;
		var nearest = sorted[0];
		return distances.indexOf(nearest);
	}

	static inline function manhattanDist(c1:Coord, c2:Coord):Int {
		var it = Math.abs(c1.x - c2.x) + Math.abs(c1.y - c2.y);
		return Std.int(it);
	}

	static inline function parseCoordinate(index:Int, str:String):Coord {
		var pair = str.split(",");
		var symbols = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		return {
			x: Std.parseInt(pair[0]),
			y: Std.parseInt(pair[1]),
			symbol: symbols.charAt(index)
		};
	}
}
