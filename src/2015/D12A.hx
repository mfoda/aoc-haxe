package;

import haxe.DynamicAccess;
import sys.io.File;

using Lambda;
using StringTools;

class D12A {
	public static function main() {
		process();
	}

	static function process() {
		var sum = parseNumbers(haxe.Json.parse(input));
		trace('Sum of numbers in document = $sum');
	}

	static function parseNumbers(dyn:Dynamic):Int {
		var data:DynamicAccess<Dynamic> = dyn;
		var sum = 0;
		switch (Type.typeof(data)) {
			case TInt:
				sum += cast(data, Int);
			case TClass(Array):
				sum += parseArray(data);
			case TObject:
				sum += parseObject(data);
			case _:
				{}
		}
		return sum;
	}

	static function parseObject(dyn:Dynamic):Int {
		var obj:DynamicAccess<Dynamic> = dyn;
		var sum = 0;
		for (k => v in obj)
			sum += parseNumbers(v);
		return sum;
	}

	static function parseArray(dyn:Dynamic):Int {
		var array:Array<Dynamic> = dyn;
		var sum = 0;
		for (i in array)
			sum += parseNumbers(i);
		return sum;
	}

	static var input = File.getContent("D12.input");
}
