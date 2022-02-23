class Day16 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("input16.txt")));
        trace("solution to part 2: " + part2(loadFile("input16.txt")));    
    }

    static function part1(input:Array<Array<Int>>):Int {
        return 0;
    }
    static function part2(input:Array<Array<Int>>):Int {
        return 0;
    }

    static function loadFile(file:String):Array<Array<Int>> {
        var input:Array<Array<Int>> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            var inp = line.split("");
            var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            input.push(inp2);
        }
        iterator.close();
        return input;
    }
}
