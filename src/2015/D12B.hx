package;

import haxe.DynamicAccess;
import sys.io.File;
import Type.typeof;

using Lambda;
using StringTools;

class D12B {
	public static function main() {
		process();
	}

	static function process() {
		var sum = parseJson(haxe.Json.parse(input));
		trace('Sum of numbers in document (excluding red) = $sum');
	}

	static function parseJson(dyn:Dynamic):Int {
		var data:DynamicAccess<Dynamic> = dyn;
		var sum = 0;
		switch (typeof(data)) {
			case TInt:
				sum += cast(data, Int);
			case TClass(Array):
				sum += parseArray(data);
			case TObject:
				sum += parseObject(data);
			case _:
		}
		return sum;
	}

	static function parseObject(dyn:Dynamic):Int {
		var obj:DynamicAccess<Dynamic> = dyn;
		var sum = 0;
		for (k => v in obj) {
			// skip objects with red key
			switch (typeof(v)) {
				case TClass(String):
					if (cast(v, String) == "red")
						return 0;
				case _:
			}
			sum += parseJson(v);
		}
		return sum;
	}

	static function parseArray(dyn:Dynamic):Int {
		var array:Array<Dynamic> = dyn;
		var sum = 0;
		for (i in array)
			sum += parseJson(i);
		return sum;
	}

	static var input = File.getContent("D12.input");
}
