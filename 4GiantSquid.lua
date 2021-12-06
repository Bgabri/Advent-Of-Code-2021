require("template")
-- function table.print(table)
-- 	local out = "{"
-- 	for i,v in ipairs(table) do
-- 		out = out .. v .. ", "
-- 	end
-- 	local len = out:len()-2
-- 	print(out:sub(1, len).."}")
-- end


local inputFile = io.open('4GiantSquid.txt')
local rngSequence = {};
local input = {};

function inputFormat(inputFile)
	local rng = inputFile:read()
	for value in string.gmatch(rng, "[0-9]+") do
		table.insert(rngSequence, tonumber(value))
	end

	local inputCount = 0
	local boardCount = 0
	for line in inputFile:lines() do
		if (line == "") then
			inputCount = inputCount + 1
			boardCount = 0
			table.insert(input, {})
		else
			table.insert(input[inputCount], {})
			boardCount = boardCount + 1
			for value in string.gmatch(line, "[0-9]+") do
				table.insert(input[inputCount][boardCount], tonumber(value))
			end
		end
	end
end

function part1(sequence, boards)
	local num
	local boardNum
	for i, rng in ipairs(sequence) do
		for j, board in ipairs(boards) do
			for k, row in ipairs(board) do
				for l, value in ipairs(row) do
					if (value == rng) then
						boards[j][k][l] = -1
						if (bingo(boards[j], k, l)) then
							num = rng
							boardNum = j
						end
					end
				end
			end
		end
		if (boardNum) then break end
	end

	local total = 0
	for k, row in ipairs(boards[boardNum]) do
		for l, value in ipairs(row) do
			if not(value == -1) then 
				total = total + value 
			end
		end
	end
	print("part1: " .. total *num)
end

function bingo(board, k, l)
	local columnTest = true
	for _, value in ipairs(board[k]) do
		if not (value == -1) then
			columnTest = false
			break;
		end	
	end

	local rowTest = true
	for i = 1, 5 do
		local value = board[i][l]
		if not (value == -1) then
			rowTest = false
			break;
		end
	end

	return rowTest or columnTest
end


function part2(sequence, boards)
	local num
	local boardNum
	local totalCompleated = 0
	for i, rng in ipairs(sequence) do
		local j = 1
		while (boards[j]) do
			for k, row in ipairs(boards[j]) do
				for l, value in ipairs(row) do
					if (value == rng) then
						boards[j][k][l] = -1
						if (bingo(boards[j], k, l)) then
							if (tableLength(boards) == 1) then
								num = rng
								break
							end
							table.remove(boards, j)
							j = j - 1
						end
					end
				end
			end
			j = j + 1
		end
		if (num) then
			break
		end
	end
	local total = 0
	for k, row in ipairs(boards[1]) do
		for l, value in ipairs(row) do
			if not(value == -1) then 
				total = total + value 
			end
		end
	end
	print("part2: " .. total*num)
end
inputFormat(inputFile)
part1(rngSequence, input)

input = {}
inputFile:close()
inputFile = io.open('4GiantSquid.txt')

inputFormat(inputFile)
part2(rngSequence, input)