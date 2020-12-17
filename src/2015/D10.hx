package;

using Lambda;
using StringTools;

class D10 {
	public static function main() {
		process();
	}

	static function process() {
		function expand(str:String) 
			return groupByConsecutive(str.split(""), result -> '${result.length}${result[0]}').join("");

		// part 1
		var result = input;
		for (_ in 0...40)
			result = expand(result);
		Sys.println('Length after 40 iterations = ${result.length}');

		// part 2
		var result = input;
		for (_ in 0...50)
			result = expand(result);
		Sys.println('Length after 50 iterations = ${result.length}');
	}

	static function groupByConsecutive<T, U>(seq:Array<T>, project:Array<T>->U):Array<U> {
		var acc = new Array<T>();
		var result = new Array<U>();
		var prev = seq[0];
		var curr = seq[0];
		for (i in 0...seq.length) {
			curr = seq[i];
			if (curr != prev) {
				result.push(project(acc));
				prev = curr;
				acc = [];
			}
			if (i == seq.length - 1) {
				acc.push(curr);
				result.push(project(acc));
			}
			acc.push(curr);
		}
		return result;
	}

	static var input = "1321131112";
}
