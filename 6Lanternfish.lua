require('template')
local input = {}

function inputFormat(file)
	local inputFile = io.open(file)
	local line = inputFile:read()
	for v in string.gmatch(line, "[0-9]+") do
		table.insert(input, tonumber(v))
	end
end

function part1(days)
	local step = 8
	local length = tableLength(input)
	for i = step, days, step do
		local increase = 0
		for j = 1, length do
			local time = input[j]
			input[j] = input[j] - step
			while (input[j] < 0) do
				table.insert(input, 9+input[j])
				input[j] = 7 + input[j]
				increase = increase + 1	
			end
		end
		length = length + increase
		if (i%40==0) then
			print(i)
		end
	end

	local total = 0
	for i,v in ipairs(input) do
		total = total + 1
	end
	print("part1: " .. total)
end

function part2(days)
	local length = tableLength(input)
	--				   0 1 2 3 4 5 6 7 8
	local totalFish = {0,0,0,0,0,0,0,0,0}
	for i,v in ipairs(input) do
		totalFish[v] = totalFish[v] +1
	end
	for i = 2, days do
		local temp0Fish = totalFish[1]
		for i = 1, 8 do
			totalFish[i] = totalFish[i+1]
		end
		totalFish[7] = totalFish[7]+temp0Fish
		totalFish[9] = temp0Fish
	end

	local total = 0
	for i,v in ipairs(totalFish) do
		total = total +v
	end

	print(tableString(totalFish))
	print("part2: " .. total)
end

inputFormat("6Lanternfish.txt")
part1(80) -- optimized iterative
input = {}
inputFormat("6Lanternfish.txt")
part2(256)
