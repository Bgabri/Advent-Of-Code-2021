//(500)^4*11/(100)^4
class Day15 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("input15.txt")));
        trace("solution to part 2: " + part2(loadFile("input15.txt")));    
    }

    static function part1(input:Array<Array<Int>>):Int {
        var t1 = haxe.Timer.stamp();
        var path = Dijksta(input, 0, 0);
        var t2 = haxe.Timer.stamp();
        trace(t2-t1);
        return path;
    }



    static function part2(input:Array<Array<Int>>):Int {
        var t1 = haxe.Timer.stamp();
        var path = quickPath(enlargeCave(input), 0, 0);
        var t2 = haxe.Timer.stamp();
        trace(t2-t1);
        return path;
    }

    static function enlargeCave(input:Array<Array<Int>>):Array<Array<Int>> {
        var cave:Array<Array<Int>> = [];
        var size = input.length;
        for (y in 0...size*5){
            cave.push([]);
            for (x in 0...size*5){
                var newV = input[y%size][x%size]+Std.int(y/size)+Std.int(x/size);
                cave[y].push((newV-1)%9+1);
            }
        }
        return cave;
    }
    static function quickPath(graph:Array<Array<Int>>, startX:Int, startY:Int):Int {
        var distance:Array<Array<Int>> = [];
        var INF = 200000;
        for (y in 0...graph.length) {
            distance.push([]);
            for (x in 0...graph[y].length) {
                distance[y].push(INF);
            }
        }
        distance[startY][startX] = 0;
        for (i in 0...10){
            for (y in 0...distance.length){
                for (x in 0...distance[y].length){

                    var neighbours = [[x-1, y],
                                    [x, y+1],
                                    [x+1, y],
                                    [x, y-1]];

                    var smallestDist = distance[y][x];
                    for (neighbour in neighbours){
                        if (neighbour[0] >= 0 && neighbour[0] < distance.length && neighbour[1] >= 0 && neighbour[1] < distance.length){
                            if (distance[neighbour[1]][neighbour[0]] < smallestDist) {
                                smallestDist = distance[neighbour[1]][neighbour[0]];
                            }
                        }
                    }
                    if (smallestDist != distance[y][x]) {
                        distance[y][x] = graph[y][x]+smallestDist;
                    }
                }
            }
        }
        // writeFile(distance.join("\n"));
        return distance[distance.length-1][distance.length-1];
    }

    static function Dijksta(graph:Array<Array<Int>>, startX:Int, startY:Int):Int {
        var INF = 912567;

        var unvisited:Array<Array<Int>> = [];
        var distanceSet:Array<Array<Int>> = [];
        var previousSet:Array<Array<Array<Int>>> = [];

        for (y in 0...graph.length){
            distanceSet.push([]);
            previousSet.push([]);

            for (x in 0...graph[y].length){
                distanceSet[y].push(INF);
                previousSet[y].push(null);
                unvisited.push([x,y]);
            }
        }
        distanceSet[startY][startX] = 0;
        while (unvisited.length != 0) {
            var currentNode = smallestCoords(distanceSet, unvisited);
            unvisited.remove(currentNode);

            var neighbours = [[currentNode[0]-1, currentNode[1]],
                              [currentNode[0], currentNode[1]+1],
                              [currentNode[0]+1, currentNode[1]],
                              [currentNode[0], currentNode[1]-1]];

            for (neighbour in neighbours){
                if (neighbour[0] >= 0 && neighbour[0] < graph.length && neighbour[1] >= 0 && neighbour[1] < graph.length){
                    var score = distanceSet[currentNode[1]][currentNode[0]] + graph[neighbour[1]][neighbour[0]];
                    if (score < distanceSet[neighbour[1]][neighbour[0]]) {
                        distanceSet[neighbour[1]][neighbour[0]] = score;
                        previousSet[neighbour[1]][neighbour[0]] = [currentNode[0], currentNode[1]];
                    }
                }
            }

            if (currentNode[0] == distanceSet.length-1 && currentNode[1] == distanceSet.length-1) {
                break;
            }
        }

        return distanceSet[distanceSet.length-1][distanceSet.length-1];
    }

    static function smallestCoords(set:Array<Array<Int>>, unvisited:Array<Array<Int>>):Array<Int> {
        var smallest:Array<Int> = unvisited[0];
        for (v in unvisited) {
            if (set[v[1]][v[0]] < set[smallest[1]][smallest[0]]){
                smallest = v;
            }
        }
        return smallest;
    }
    
    static function writeFile(s:String) {
        var output = sys.io.File.write("out15.txt", false);
        output.writeString(s);
        output.close();
    }

    static function appendFile(s:String) {
        var output = sys.io.File.append("out15.txt", false);
        output.writeString("\n"+s);
        output.close();
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
