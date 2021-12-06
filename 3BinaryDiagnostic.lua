local inputFile = io.open('3BinaryDiagnostic.txt')
local input = {};

function inputFormat(inputFile)
	for line in inputFile:lines() do
		table.insert(input, line)
	end
end

function BinaryToDec(binary)
	local dec = 0;
	local power = 0
	for i = binary:len(), 1, -1 do
		if (binary:sub(i,i) == "1") then
			dec = dec + 2^(power)
		end
		power = power +1
	end
	return dec
end

function BinaryDiagnostic1(input)
	local gammaRate = ""
	local epsilonRate = ""
	local bitCount = {0,0,0,0,0,0,0,0,0,0,0,0}
	local count = 0
	for i,v in ipairs(input) do
		count = count + 1
		for j = 1, v:len() do
			if (v:sub(j,j) == "1") then
				bitCount[j] = bitCount[j] + 1
			end
		end
		-- print(i,v)
	end

	for i, v in ipairs(bitCount) do
		if (2*v > count) then
			gammaRate = gammaRate .. 1
			epsilonRate = epsilonRate .. 0
		else
			gammaRate = gammaRate .. 0
			epsilonRate = epsilonRate .. 1
		end

	end
	print("part1: " .. BinaryToDec(gammaRate)*BinaryToDec(epsilonRate))
end

function BinaryDiagnostic2(input)
	print("part2: " .. BinaryToDec(O2Scrub(input, 1)) * BinaryToDec(CO2Scrub(input, 1)))
end


function O2Scrub(input, i)
	local count = 0
	local size = 0
	for j,v in ipairs(input) do
		size = size + 1
		if(v:sub(i,i) == "1") then
			count = count + 1
		end
	end

	local most = "0"
	if (2*count >= size) then
		most = "1"
	end
	local newInput = {}
	if (size > 1) then
		for j, w in ipairs(input) do
			if (w:sub(i,i) == most) then
				table.insert(newInput, w)
			end
		end
		return O2Scrub(newInput, i + 1)
	else 
		return input[1]
	end
end

function CO2Scrub(input, i)
	local count = 0
	local size = 0
	for j,v in ipairs(input) do
		size = size + 1
		if(v:sub(i,i) == "1") then
			count = count + 1
		end
	end

	local least = "0"
	if (2*count < size) then
		least = "1"
	end
	local newInput = {}
	if (size > 1) then
		for j, w in ipairs(input) do
			if (w:sub(i,i) == least) then
				table.insert(newInput, w)
			end
		end
		return CO2Scrub(newInput, i + 1)
	end
	if (size <= 1) then
		return input[1]
	end
end

function table.print(table)
	local out = "{"
	for i,v in ipairs(table) do
		out = out .. v .. ", "
	end
	local len = out:len()-2
	print(out:sub(1, len).."}")
end

inputFormat(inputFile)
BinaryDiagnostic1(input)
BinaryDiagnostic2(input)
