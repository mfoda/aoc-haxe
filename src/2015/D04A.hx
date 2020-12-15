package;

using Lambda;
using StringTools;
import haxe.crypto.Md5;

class D04A {
	public static function main() {
		process();
	}

	static function process() {
		var leading5 = "";
		var n = 0;

		while (leading5 != "00000") {
			var encoded = Md5.encode('$input$n');
			leading5 = encoded.substr(0, 5);
			n++;
		}

		Sys.println(n-1);
	}

	static inline var input = "ckczppom";
}
