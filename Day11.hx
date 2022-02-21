import StringTools.replace;
class Day11 {
    static function main() {
        trace("solution to part 1 " + part1(loadFile("input11.txt")));
        trace("solution to part 2 " + part2(loadFile("input11.txt")));
    }
    /* static function increment(x:Int, y:Int, input:Array<Array<Int>>):Array<Array<Int>> {
         for (y2 in y-1...y+2){
             for (x2 in x-1...x+2){
                 if(!(y2 == y && x2 == x) && y2 >= 0 && x2 >= 0 && y2 < input.length && x2 < input[y2].length){
                     input[y2][x2] += 1;
                 }
             }
         }
         return input;
     }*/
    static function part1(input:Array<Array<Int>>):Int {
        var steps = 100;
        var flashes = 0;
        var flashed:Array<Array<Int>> = [[-3,-3]];
        for (i in 0...steps) {
            for (y in 0...input.length) {
                for (x in 0...input[y].length) {
                    input[y][x] += 1;
                    if (input[y][x] > 9) {
                        flashes += 1;
                        input[y][x] = 0;
                        flashed.push([x,y]);
                    }
                }
            }
            while (flashed.length != 0) {
                var c = flashed.pop();
                var xc = c[0];
                var yc = c[1];
                for (y2 in yc-1...yc+2){
                    for (x2 in xc-1...xc+2){
                        if(!(y2 == yc && x2 == xc) && y2 >= 0 && x2 >= 0 && y2 < input.length && x2 < input[y2].length){
                            if(input[y2][x2] != 0){
                                input[y2][x2] += 1;
                            }
                            if (input[y2][x2] > 9) {
                                flashes += 1;
                                input[y2][x2] = 0;
                                flashed.push([x2,y2]);
                            }
                        }
                    }
                }
            }
        }
        return flashes;
    }

    static function part2(input:Array<Array<Int>>):Int {
        var steps = 1000;
        var flashed:Array<Array<Int>> = [[-3,-3]];
        var flashes = 0;
        var step:Int = 0;
        while (flashes != 100){
            flashes = 0;
            for (y in 0...input.length) {
                for (x in 0...input[y].length) {
                    input[y][x] += 1;
                    if (input[y][x] > 9) {
                        flashes += 1;
                        input[y][x] = 0;
                        flashed.push([x,y]);
                    }
                }
            }
            while (flashed.length != 0) {
                var c = flashed.pop();
                var xc = c[0];
                var yc = c[1];
                for (y2 in yc-1...yc+2){
                    for (x2 in xc-1...xc+2){
                        if(!(y2 == yc && x2 == xc) && y2 >= 0 && x2 >= 0 && y2 < input.length && x2 < input[y2].length){
                            if(input[y2][x2] != 0){
                                input[y2][x2] += 1;
                            }
                            if (input[y2][x2] > 9) {
                                flashes += 1;
                                input[y2][x2] = 0;
                                flashed.push([x2,y2]);
                            }
                        }
                    }
                }
            }
            step +=1;
            trace(flashed.length);
        }
        return step;
    }

    static function loadFile(file:String):Array<Array<Int>> {
        var input:Array<Array<Int>> = [];
        var temp = sys.io.File.getContent(file);
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