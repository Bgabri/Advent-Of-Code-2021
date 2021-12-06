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


function tableString(table)
	local out = "\n{"
	if (type(table) == "table") then
		for i,v in ipairs(table) do
			out = out .. tableString(v) .. ", "
		end
	else
		return table
	end
	return out:sub(1, out:len()-2) .. "}"
end

function tableLength(table)
	local length = 0
	for i,v in ipairs(table) do
		length = length + 1
	end
	return length
end