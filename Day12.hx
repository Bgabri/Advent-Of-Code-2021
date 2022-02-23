class Day12 {
    static function main() {
        trace("solution to part 1 " + part1(loadFile("input12.txt")));
        trace("solution to part 2 " + part2(loadFile("input12.txt")));
    }

/*
current 

next possible

*/

    static function part1(input:Array<Array<String>>):Int {
        
        var paths = 0;
        function pathFind(currentNode:String, path:String):String {
            path += currentNode;
            if (currentNode == "end"){
                paths +=1;
                return path.substring(0, path.length-2) + "\n";
            } else {
                var neighBours:Array<String> = [];
                for (i in 0...input[1].length) {
                    if (input[0][i] == currentNode) {
                        neighBours.push(input[1][i]);
                    }
                    if (input[1][i] == currentNode) {
                        neighBours.push(input[0][i]);
                    }
                }
                for (v in neighBours) {
                    if (path.indexOf(v) == -1 || v == v.toUpperCase() ) {
                        pathFind(v, path);
                    }
                }
            }
            return "-1";
        }
        pathFind("start", "");
        return paths;
    }
    static function part2(input:Array<Array<String>>):Int {
                
        var paths = 0;
        function pathFind(currentNode:String, path:String, double:Bool):String {
            path += currentNode+",";
            if (currentNode == "end"){
                paths +=1;
                return path.substring(0, path.length-2) + "\n";
            } else {
                var neighBours:Array<String> = [];
                for (i in 0...input[1].length) {
                    if (input[0][i] == currentNode) {
                        neighBours.push(input[1][i]);
                    }
                    if (input[1][i] == currentNode) {
                        neighBours.push(input[0][i]);
                    }
                }
                if (stringRepeats(path, currentNode) == 2 && currentNode != currentNode.toUpperCase()){
                    double = true;
                }
                for (v in neighBours) {
                    if (!double && (stringRepeats(path, v) < 2 || v == v.toUpperCase()) && v != "start") {
                        pathFind(v, path, double);
                    } 
                    if (double && (stringRepeats(path, v) == 0 || v == v.toUpperCase())) {
                        pathFind(v, path, double);
                    }
                }
            }
            return "-1";
        }

        pathFind("start", "", false);
        return paths;
    }
    static function stringRepeats(s:String, s2:String):Int {
        return s.split(s2).length-1;
    }

    static function loadFile(file:String):Array<Array<String>> {
        var input:Array<Array<String>> = [[],[]];
        var iterator = sys.io.File.read(file, false);
        while (!iterator.eof()){
            var line = iterator.readLine();
            var path = line.split("-");
            input[0].push(path[0]);
            input[1].push(path[1]);
        }
        iterator.close();
        return input;
    }
}

