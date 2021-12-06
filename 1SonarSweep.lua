local input = io.open('1SonarSweep.txt', 'r')

function SonarSweeps(input)
	local prev = 9999999999
	local change = {}

	local count = 0
	for line in input:lines() do
		local current = tonumber(line)
		if (current > prev) then
			count = count + 1
		end
		prev = current
	end

	print("part 1: " .. count)
end

function SonarSweeps2(input)

	local buffer = {9999999, 9999999, 9999999}
	local change = {}
	local count = 0
	input = io.open("1SonarSweep.txt")
	for line in input:lines() do
		local current = tonumber(line)
		local total = current + buffer[1] + buffer[2]
		local prevTotal = buffer[1] + buffer[2] + buffer[3]
		local test = "decrease";
		if (total > prevTotal) then
			count = count + 1
			test = "increase"
		elseif (total == prevTotal) then
			test = "same"
		end
		buffer[3] = buffer[2]
		buffer[2] = buffer[1]
		buffer[1] = current
	end

	print("part2: ".. count)
end

SonarSweeps(input)
SonarSweeps2(input)