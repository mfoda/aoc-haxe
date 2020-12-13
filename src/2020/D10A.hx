package;

using Lambda;
using StringTools;

class D10A {
	public static function main() {
		process();
	}

	static function process():Void {
		function byAscending(a, b) return a > b ? 1 : -1;
		var jolts = input.split("\n").map(Std.parseInt);
		jolts.sort(byAscending);
		var diff = new Map<Int, Int>();

		for (i in 0...jolts.length - 1) {
			var j1 = jolts[i], j2 = jolts[i + 1];
			var d = Std.int(Math.abs(j1 - j2));
			if (diff.exists(d))
				diff[d]++;
			else 
				diff[d] = 1;
		}

		diff[1]++; // for first connection to outlet
		diff[3]++; // for built-in adapter extra joltage

		Sys.println(diff);
		Sys.println('Multiplied = ${diff[1] * diff[3]}');
	}

	static inline var input = "8
131
91
35
47
116
105
121
56
62
94
72
13
82
156
102
12
59
31
138
46
120
7
127
126
111
2
123
22
69
18
157
75
149
88
81
23
98
132
1
63
142
37
133
61
112
122
128
155
145
139
66
42
134
24
60
9
28
17
29
101
148
96
68
25
19
6
67
113
55
40
135
97
79
48
159
14
43
86
36
41
85
87
119
30
108
80
152
158
151
32
78
150
95
3
52
49";
}
