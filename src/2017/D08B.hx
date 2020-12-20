package; 

import sys.io.File;
using Lambda;
using StringTools;

typedef Instruction = {
	targetVar:String,
	targetOp:(Int,Int) -> Int,
	targetVal:Int,
	condVar:String,
	condOp:(Int,Int) -> Bool,
	condVal:Int
}

class D08A {
	static final input = File.getContent("D08.input");

	public static function main() {
		var instructions = input.split("\n").map(parseInstruction);
		var registers = new Map<String, Int>();

		function getVal(x) return 
				registers.exists(x) ? registers[x]
				: (registers[x] = 0);
		function setVal(x, v) 
				registers.exists(x) ? registers[x] = v
				: throw "value does not exist";
		

		var largest = 0;
		for (inst in instructions) {
			var condResult = inst.condOp(getVal(inst.condVar), inst.condVal);
			if (condResult) {
				var newVal = inst.targetOp(getVal(inst.targetVar), inst.targetVal);
				setVal(inst.targetVar, newVal);
				largest = Std.int(Math.max(largest, newVal));
			}
		}

		Sys.println('largest value ever held in registers while executing instructions = $largest');
	}

	static function parseInstruction(str:String):Instruction {
		var reg = ~/(\w+) (inc|dec) (\-?\d+) if (\w+) (==|!=|<|<=|>|>=) (\-?\d+)/;

		if (!reg.match(str)) 
			throw "invalid instruction";

		var targetOps = [
			"inc" => (x, n) -> x + n,
			"dec" => (x, n) -> x - n,
		];
		var condOps = [
			"==" => (x, y) -> x == y,
			"!=" => (x, y) -> x != y,
			"<"  => (x, y) -> x <  y,
			"<=" => (x, y) -> x <= y,
			">"  => (x, y) -> x >  y,
			">=" => (x, y) -> x >= y,
		];
		var m = reg.matched;
		return {
			targetVar: m(1),
			targetOp: targetOps[m(2)],
			targetVal: Std.parseInt(m(3)),
			condVar: m(4),
			condOp: condOps[m(5)],
			condVal: Std.parseInt(m(6))
		}
	}
}
