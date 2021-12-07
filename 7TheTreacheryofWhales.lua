require("template")
local input = {}

function inputFormat(file)
	file = io.open(file)
	local line = file:read()
	for v in string.gmatch(line, "[0-9]+") do
		table.insert(input, tonumber(v))
	end
end



function part1()
	local values = {99999999}
	local position
	for x = 1, 20000 do
		table.insert(values, f(x))
		if (values[x] <= values[x+1]) then
			position = x
			break;
		end
	end
	print("part1: " .. values[position])
end

function f(x)
	local y = 0
	for i,v in ipairs(input) do
		y = y + math.abs(v-x)
	end
	return y
end

function part2()
	local values = {9999999999999999}
	local position
	for x = 1, 20000 do
		table.insert(values, f2(x))
		if (values[x] <= values[x+1]) then
			position = x
			break;
		end
	end
	print("part2: " .. values[position])

end

function f2(x)
	local y = 0
	for i,v in ipairs(input) do
		local k = math.abs(v-x)
		y = y + k*(k+1)/2
	end
	return y
end

inputFormat("7TheTreacheryofWhales.txt")
part1()
part2()