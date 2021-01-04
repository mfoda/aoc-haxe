package;

import sys.io.File;

using Lambda;
using StringTools;

typedef Steps = Map<String, Array<String>>;

class D07A {
	static var input = File.getContent("D07.input");

	public static function main() {
		var steps:Steps = parsePairs(input);
		var ordered = [];
		var next:String = null;
		while ((next = popNextStep(steps)) != null)
			ordered.push(next);
		Sys.println('Instruction order should be ${ordered.join("")}');
	}

	static function parsePairs(lines:String):Steps {
		var steps:Steps = new Steps();
		for (pair in lines.split("\n")) {
			var a = pair.charAt(5);
			var b = pair.charAt(36);
			if (!steps.exists(b))
				steps[b] = [a];
			else
				steps[b].push(a);
		}
		return steps;
	}

	static function popNextStep(steps:Steps):String {
		var keys = [for (k in (steps.keys())) k];
		var vals = [for (v in steps) v].flatten();
		// steps with no dependencies found
		var cands1 = vals.filter(v -> !keys.contains(v));
		// steps with all dependencies met
		var cands2 = [for (k => v in steps) if (v.empty()) k];
		var cands = cands1.concat(cands2);
		cands.sort(Reflect.compare);
		var next = cands[0];
		// remove next from steps
		for (step in steps)
			while (step.remove(next))
				continue;
		for (key in steps.keys())
			if (key == next)
				steps.remove(key);
		return next;
	}
}
