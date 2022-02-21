import haxe.Int64;

class Day10 {
    static function main() {
        trace("solution to part 1 " + part1(loadFile("input10.txt")));
        trace("solution to part 2 " + part2(loadFile("input10.txt")));
    }

    static function part1(input:Array<String>):Int {
        var pointsMap = [
            ")" => 3,
            "]" => 57,
            "}" => 1197,
            ">" => 25137
        ];
        var closingMap = [
            "(" => ")",
            "[" => "]",
            "{" => "}",
            "<" => ">",

        ];
        var score = 0;
        for (line in input) {
            var stack = [];
            for (i in 0...line.length){
                var char = line.charAt(i);
                switch char {
                    case "(":
                        stack.push(char);
                    case "[":
                        stack.push(char);
                    case "{":
                        stack.push(char);
                    case "<":
                        stack.push(char);
                    default:
                        var poped = stack.pop();
                        if (char != closingMap[poped]){
                            score += pointsMap[char];
                        }
                }
            }
        }

        return score;
    }

    static function part2(input:Array<String>):Int64 {
        var pointsMap = [
            ")" => 1,
            "]" => 2,
            "}" => 3,
            ">" => 4
        ];
        var closingMap = [
            "(" => ")",
            "[" => "]",
            "{" => "}",
            "<" => ">",

        ];
        var scores:Array<Int64> = [];

        for (line in input) {
            var corrupt = false;
            var stack = [];
            for (i in 0...line.length){
                var char = line.charAt(i);
                switch char {
                    case "(":
                        stack.push(char);
                    case "[":
                        stack.push(char);
                    case "{":
                        stack.push(char);
                    case "<":
                        stack.push(char);
                    default:
                        var poped = stack.pop();
                        if (char != closingMap[poped]){
                            corrupt = true;
                            break;
                        }
                }
            }

            if(!corrupt) {
                var score:Int64 = 0;
                stack = stack.map(v -> closingMap[v]);
                stack.reverse();

                for (v in stack) {
                    score = score*5+pointsMap[v];
                }
                scores.push(score);
            }
        }
        
        scores.sort(function (a, b) return if (a < b) -1 else 1);
        return scores[Std.int(scores.length/2)];
    }

    static function loadFile(file:String):Array<String> {
        var input:Array<String> = [];
        var temp = sys.io.File.getContent(file);
        var iterator = sys.io.File.read(file, false);
        while (!iterator.eof()){
            input.push(iterator.readLine());
        }
        iterator.close();
        return input;
    }
}