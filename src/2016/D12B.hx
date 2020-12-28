package;

class D12B {
	static final input = File.getContent("D12.input");

	static final toInt = Std.parseInt;

	static function main() {
		var registers = ["a" => 0, "b" => 0, "c" => 1, "d" => 0];
		var instructions = input.split("\n");
		var idx = 0;
		while (idx < instructions.length) {
			var instruction = instructions[idx];
			switch (instruction.split(" ")) {
				case ["inc", x]:
					registers[x]++;
				case ["dec", x]:
					registers[x]--;
				case ["cpy", x, y]:
					var val = toInt(x) != null ? toInt(x) : registers[x];
					registers[y] = val;
				case ["jnz", x, y]:
					if (registers[x] != 0)
						idx += toInt(y) - 1;
				case _:
					throw "invalid instruction";
			}
			idx++;
		}
		Sys.println('Value of register a after execution is ${registers["a"]}');
	}
}
