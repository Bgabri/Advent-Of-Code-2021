local inputFile = io.open('2Dive.txt')
local input = {};

function inputFormat(inputFile)
	local count = 1;
	for line in inputFile:lines() do
		table.insert(input, {})
		table.insert(input[count], string.match(line,'[a-z]*'))
		table.insert(input[count], string.match(line,'[0-9]+'))
		count = count +1
	end
end

function dive1(input)
	hPos = 0
	depth = 0
	for i,v in ipairs(input) do
		if(v[1] == "forward") then
			hPos = hPos + tonumber(v[2])
		elseif(v[1] == "up") then
			depth = depth - tonumber(v[2])
		elseif(v[1] == "down") then
			depth = depth + tonumber(v[2])
		end
	end
	print("part1: " .. hPos*depth)
end

function dive2(input)
	hPos = 0
	depth = 0
	aim = 0
	for i,v in ipairs(input) do
		if(v[1] == "forward") then
			hPos = hPos + tonumber(v[2])
			depth = depth+ aim*tonumber(v[2])
		elseif(v[1] == "up") then
			aim = aim - tonumber(v[2])
		elseif(v[1] == "down") then
			aim = aim + tonumber(v[2])
		end
	end
	print("part2: " .. hPos*depth)
end

inputFormat(inputFile)
dive1(input)
dive2(input)