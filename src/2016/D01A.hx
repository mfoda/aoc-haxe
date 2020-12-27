package;

class D01A {
	static final input = File.getContent("D01.input");

	public static function main() {
		var x = 0;
		var y = 0;
		var rot = 0;

		for (cmd in input.split(", ")) {
			var dir = cmd.charAt(0);
			var dist = Std.parseInt(cmd.substr(1));

			if (dir == "R")
				rot = (rot + 90) % 360;
			if (dir == "L")
				rot = (rot == 0) ? 270 : (rot - 90) % 360;

			switch (rot) {
				case 0:
					y += dist;
				case 90:
					x += dist;
				case 180:
					y -= dist;
				case 270:
					x -= dist;
				case _:
					throw "invalid rot";
			}
		}
		var manhattanDist = Std.int(Math.abs(x) + Math.abs(y));
		Sys.println('Easter Bunny HQ is $manhattanDist blocks away');
	}
}
