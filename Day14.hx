import haxe.Int64;

class Day14 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("input14.txt")));
        trace("solution to part 2: " + part2(loadFile("input14.txt")));    
    }

    static function part1(input:Array<Dynamic>):Int {
        var polymer:String = input[0];
        var map:Map<String, String> = input[1];
        var steps = 10;
        for (i in 0...steps) {
            var newPolymer = polymer.charAt(0);
            for (j in 0...polymer.length-1) {
                var chain:String = polymer.charAt(j) + polymer.charAt(j+1);
                if (map[chain] != null) {
                    newPolymer += map[chain];
                }
                newPolymer += polymer.charAt(j+1);
            }
            polymer = newPolymer;
        }
        var countMap:Map<String, Int> = [];

        for (i in 0...polymer.length) {
            var char = polymer.charAt(i);
            if (countMap[char] == null) {
                countMap.set(char, 0);
            }
            countMap[char] += 1;
        }
        
        var max = countMap[polymer.charAt(0)];
        var min = countMap[polymer.charAt(0)];
        for (v in countMap.iterator()) {
            if (v > max) {
                max = v;
            }
            if (v < min) {
                min = v;
            }

        }
        // trace(polymer);
        return max-min;
    }

    static function part2(input:Array<Dynamic>):Int64 {
        var polymer:String = input[0];
        var instructions:Map<String, String> = input[1];
        var polymerCount:Map<String, Int64> = [];
        
        for (k in instructions.keys()) {
            polymerCount.set(k, 0);
        }
        var empty = polymerCount.copy();
        // trace("ABCD".substring())
        for (i in 0...polymer.length-1) {
            polymerCount[polymer.substring(i,i+2)] += 1;
        }
        var steps = 40;

        for (i in 0...steps) {
            var temp = empty.copy();
            for (k in polymerCount.keys()) {
                var count = polymerCount[k];

                var char = instructions[k];
                temp[k.substring(0,1)+char] += count;
                temp[char+k.substring(1,2)] += count;
                polymerCount[k]=1;
            }
            polymerCount = temp.copy();
        }

        var countMap:Map<String, Int64> = [];

        for (k in polymerCount.keys()) {
            var char1 = k.substring(0,1);
            if (countMap[char1] == null) {
                countMap.set(char1, 0);
            }
            countMap[char1] += polymerCount[k];
        }
        
        var max = countMap[polymer.charAt(0)];
        var min = countMap[polymer.charAt(0)];
        countMap[polymer.substring(polymer.length-1,polymer.length)] +=1;
        for (v in countMap.iterator()) {
            if (v > max) {
                max = v;
            }
            if (v < min) {
                min = v;
            }

        }
        return max-min;
    }

    static function loadFile(file:String):Array<Dynamic> {
        var input:Map<String, String> = [];
        var iterator = sys.io.File.read(file, false);
        var polymer:String = iterator.readLine();
        iterator.readLine();
        while (!iterator.eof()){
            var line = iterator.readLine();
            var inp = line.split(" -> ");
            input.set(inp[0],inp[1]);
        }
        iterator.close();
        return [polymer, input];
    }
}