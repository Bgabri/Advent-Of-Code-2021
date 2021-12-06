require("template")
coords = {}


function inputFormat(file)
	local inputFile = io.open(file)
	local count = 0
	for line in inputFile:lines() do
		count = count + 1 
		table.insert(coords, {})		
		for value in string.gmatch(line, "[0-9]+") do
			table.insert(coords[count], tonumber(value))
		end
	end
end

function part1()
	local total = 0
	local length = tableLength(coords)
	-- print(tableString(equations))
	local xMax = 1
	local yMax = 1
	for i, coord in ipairs(coords) do
		if(coord[1] > xMax ) then xMax = coord[1] end
		if(coord[3] > xMax ) then xMax = coord[3] end

		if(coord[2] > yMax ) then yMax = coord[2] end
		if(coord[4] > yMax ) then yMax = coord[4] end
	end	

	local graph = {}
	for y = 1, yMax do
		table.insert(graph, {})
		for x = 1, xMax do
			table.insert(graph[y], 0)
		end
	end

	for i, coord in ipairs(coords) do
		if (coord[1] == coord[3] or coord[2] == coord[4]) then
			

		end
	end
	print(total)
end

-- function segmentVsSegment(x1, y1, x2, y2, x3, y3, x4, y4)
--   local dx1, dy1 = x2 - x1, y2 - y1
--   local dx2, dy2 = x4 - x3, y4 - y3
--   local dx3, dy3 = x1 - x3, y1 - y3
--   local d = dx1*dy2 - dy1*dx2
--   if d == 0 then
--     return false
--   end
--   local t1 = (dx2*dy3 - dy2*dx3)/d
--   if t1 < 0 or t1 > 1 then
--     return false
--   end
--   local t2 = (dx1*dy3 - dy1*dx3)/d
--   if t2 < 0 or t2 > 1 then
--     return false
--   end
--   -- point of intersection
--   return true, x1 + t1*dx1, y1 + t1*dy1
-- end

inputFormat("5hydrothermalVenture.txt")
part1()