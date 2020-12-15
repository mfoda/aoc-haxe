package;

using Lambda;
using StringTools;
import haxe.crypto.Md5;

class D04B {
	public static function main() {
		process();
	}

	static function process() {
		var leading6 = "";
		var n = 0;

		while (leading6 != "000000") {
			var encoded = Md5.encode('$input$n');
			leading6 = encoded.substr(0, 6);
			n++;
		}

		Sys.println(n-1);
	}

	static inline var input = "ckczppom";
}
