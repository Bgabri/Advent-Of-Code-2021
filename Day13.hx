class Day13 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("input13.txt")));
        trace("solution to part 2: " + part2(loadFile("input13.txt")));    
    }

    static function part1(input:Array<Array<Array<Dynamic>>>):Int {
        var coords = input[0];
        var folds = input[1];
        var xyMap = ["x" => 0, "y" => 1];

        for (j in 0...1) {
            var eq = folds[j];
            for (i in 0...coords.length) {
                var coord = coords[i];
                var p = coord[xyMap[eq[0]]];
                var l = eq[1];
                if (p > l) {
                    coords[i][xyMap[eq[0]]] = 2*l - p;
                }
            }
        }

        // var total = 0;
        var singles = [coords[0]];
        for (i in 0...coords.length) {
            var coord = coords[i];
            var double = false;
            for (j in 0...singles.length) {
                var coord2 = singles[j];
                if ((coord[0] == coord2[0] && coord[1] == coord2[1])) {
                    double = true;
                    break;
                }
            }
            if(!double){
                singles.push(coord);
            }
        }
        return singles.length;
    }

    static function part2(input:Array<Array<Array<Dynamic>>>):String {
        var coords = input[0];
        var folds = input[1];
        var xyMap = ["x" => 0, "y" => 1];

        for (j in 0...folds.length) {
            var eq = folds[j];
            for (i in 0...coords.length) {
                var coord = coords[i];
                var p = coord[xyMap[eq[0]]];
                var l = eq[1];
                if (p > l) {
                    coords[i][xyMap[eq[0]]] = 2*l - p;
                }
            }
        }

        // var total = 0;
        var singles = [coords[0]];
        var minX:Int = coords[0][0];
        var minY:Int = coords[0][1];
        for (i in 0...coords.length) {
            var coord = coords[i];
            var double = false;
            for (j in 0...singles.length) {
                var coord2 = singles[j];
                if ((coord[0] == coord2[0] && coord[1] == coord2[1])) {
                    double = true;
                    break;
                }
            }
            if(!double){
                if (coord[0] < minX) {
                    minX = coord[0];
                }
                if (coord[1] < minY) {
                    minX = coord[0];
                }
                
                singles.push(coord);
            }
        }
        var grid = toGrid(coords);
        return "\n" + grid.join("\n");
    }

    static function toGrid(coords:Array<Array<Dynamic>>):Array<Array<String>> {
        var grid:Array<Array<String>>=[];
        for (coord in coords) {
            while (grid.length <= coord[1]){
                grid.push([]);
            }
            while (grid[coord[1]].length < coord[0]){
                grid[coord[1]].push(" ");
            }
            grid[coord[1]][coord[0]] = "#";
        }
        return grid;
    }
    static function loadFile(file:String):Array<Array<Array<Dynamic>>> {
        var coords:Array<Array<Int>> = [];
        var folds:Array<Array<Dynamic>> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            if (line == "") break;
            var inp = line.split(",");
            var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            coords.push(inp2);
        }

        while (!iterator.eof()){
            var line = iterator.readLine();
            var inp = line.split("=");
            folds.push([inp[0].substring(11, 12), Std.parseInt(inp[1])]);
        }

        iterator.close();
        return [coords, folds];
    }
}

