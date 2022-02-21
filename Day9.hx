interface Printable {
    public function toString():String;
}

class Day9 {
    static function main() {
        trace("solution to part 1 " + part1());
        trace("solution to part 2 " + part2());
    }

    static  function part1():Int {
        var input = loadFile("input9.txt");
        var danger = 0;
        for (y in 0...input.length){
            for (x in 0...input[y].length){
                var current = Std.parseInt(input[y].charAt(x));
                var low = 0;
                var neighbour = 0;
                for (y2 in y-1...y+2){
                    for (x2 in x-1...x+2){
                        if(!(y2 == y && x2 == x) && y2 >= 0 && x2 >= 0 && y2 < input.length && x2 < input[y2].length){
                            neighbour += 1;
                            if(current < Std.parseInt(input[y2].charAt(x2))){
                                low += 1;
                            }
                        }
                    }
                }
                if(low == neighbour){
                    danger += current+1;
                }
            }
        }
        return danger;
    }

    static  function part2():Int {
        var input = loadFile("input9.txt");
        var largestsBasins = [0,0,0];
        for (y in 0...input.length){
            for (x in 0...input[y].length){
                if (Std.parseInt(input[y].charAt(x)) != 9) {
                    var basinCoords:Array<Array<Int>> = [[x,y]];
                    var basinSize = 0;

                    var oper = input[y].substring(0, x);
                    var lower = input[y].substring(x+1);
                    input[y] = oper+"9"+lower;

                    while (basinCoords.length != 0){
                        // trace(basinCoords);
                        var current = basinCoords.shift();
                        var cx = current[0];
                        var cy = current[1];
                        basinSize += 1;

                        var relCoords = [[-1,0],[0,-1],[0,1],[1,0]];
                        for (relCoord in relCoords){
                            var x2 = cx+relCoord[0];
                            var y2 = cy+relCoord[1];
                            if(!(y2 == cy && x2 == cx) && y2 >= 0 && x2 >= 0 && y2 < input.length && x2 < input[y2].length){
                                if(Std.parseInt(input[y2].charAt(x2)) != 9){
                                    basinCoords.push([x2,y2]);

                                    var oper = input[y2].substring(0, x2);
                                    var lower = input[y2].substring(x2+1);
                                    input[y2] = oper+"9"+lower;
                                }
                            }
                        }
                    }
                    for (i in 0...largestsBasins.length){
                        if (largestsBasins[i] < basinSize) {
                            largestsBasins[i] = basinSize;
                            break;
                        }
                    }
                }
            }
        }
        return largestsBasins[0]*largestsBasins[1]*largestsBasins[2];
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