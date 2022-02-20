require("template")
local input = {}
function inputFormat(file)
	file = io.open(file, "r")
	local i = 0
	for line in file:lines() do
		table.insert(input, {})
		i = i  + 1
		for v in string.gmatch(line, "[a-z]+") do
			table.insert(input[i], tostring(v))
		end
	end
end

function part1()
	local total = 0
	for i,v in ipairs(input) do
		-- for i,v2 in ipairs(v[2]) do
			for j = 11,14 do
				v2 = v[j]
			if (string.len(v2) == 2 or string.len(v2) == 3 or string.len(v2) == 4 or string.len(v2) == 7) then
				total = total + 1
			end
		end
	end
	print("part 1: " .. total)
end

function part2()
	local total = 0
	for i, display in ipairs(input) do
		local decoder = {0,0,0,0,0,0,0}
		local agKey = {a=1,b=2,c=3,d=4,e=5,f=6,g=7}

		local encoder09 = {0,0,0,0,0,0,0}
		local encoder1 = {0,0,0,0,0,0,0}
		local encoder4 = {0,0,0,0,0,0,0}
		local encoder7 = {0,0,0,0,0,0,0}
		local encoder069 = {0,0,0,0,0,0,0}

		for j = 1,10 do
			digit = display[j]
			if(string.len(digit) == 2) then
				for char in string.gmatch(digit, "[a-z]") do
					encoder1[agKey[char]] = encoder1[agKey[char]] + 1
				end
			elseif(string.len(digit) == 4) then
				for char in string.gmatch(digit, "[a-z]") do
					encoder4[agKey[char]] = encoder4[agKey[char]] + 1
				end
			elseif(string.len(digit) == 3) then
				for char in string.gmatch(digit, "[a-z]") do
					encoder7[agKey[char]] = encoder7[agKey[char]] + 1
				end
			elseif(string.len(digit) == 6) then
				for char in string.gmatch(digit, "[a-z]") do
					encoder069[agKey[char]] = encoder069[agKey[char]] + 1
				end
			end

			for char in string.gmatch(digit, "[a-z]") do
				encoder09[agKey[char]] = encoder09[agKey[char]] +1
			end
		end

		for i, v in ipairs(encoder09) do
			if (encoder7[i] + encoder1[i] == 1) then
				decoder[i] = 1
			elseif (v == 6) then
				decoder[i] = 2
			elseif (v + encoder1[i] == 9) then
				decoder[i] = 3
			elseif (v + encoder069[i]*2 == 11) then
				decoder[i] = 4
			elseif (v == 4) then
				decoder[i] = 5
			elseif (v == 9) then
				decoder[i] = 6
			elseif (v + encoder4[i]*4 == 7) then
				decoder[i] = 7
			end
		end
		-- print(tableString(decoder))

		local number = 0
		for i = 11, 14 do
			local digit = display[i]
			number = number + digitDecoder(decoder, digit)*10^(14-i)
		end
		print (number)
		total = total + number
	end

	print("part 2: " .. total)
end

function digitDecoder(e, string)
	local agKey = {a=e[1],b=e[2],c=e[3],d=e[4],e=e[5],f=e[6],g=e[7]}
	local code = 0
	for char in string.gmatch(string, "[a-z]") do
		if (agKey[char] == 2) then
			code = code+agKey[char]
		end
		code = code+agKey[char]
	end
	digits = {[26]= 0,
			  [9] = 1,
			  [20]= 2,
			  [21]= 3,
			  [17]= 4,
			  [22]= 5,
			  [27]= 6,
			  [10]= 7,
			  [30]= 8,
			  [25]= 9}
	print(code)
	return digits[code]
end

inputFormat("8SevenSegmentSearch.txt")
part1()
part2()
