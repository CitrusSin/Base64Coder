local base64 = {}

local base64str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

function base64.encode(source)
	numtable = table.pack(string.byte(source, 1, #source))
	retVal = ""
	oprLevel = 0
	last2or4bits = 0
	for i, v in ipairs(numtable) do
		if oprLevel == 0 then
			index = bit32.rshift(v, 2) + 1
			last2or4bits = bit32.band(v, 3)
			retVal = retVal .. string.sub(base64str, index, index)
			if i == #source then
				index = bit32.lshift(last2or4bits, 4) + 1
				retVal = retVal .. string.sub(base64str, index, index) .. "=="
			end
		elseif oprLevel == 1 then
			high2bits = bit32.lshift(last2or4bits, 4)
			index = bit32.bor(high2bits, bit32.rshift(v, 4)) + 1
			last2or4bits = bit32.band(v, 15)
			retVal = retVal .. string.sub(base64str, index, index)
			if i == #source then
				index = bit32.lshift(last2or4bits, 2) + 1
				retVal = retVal .. string.sub(base64str, index, index) .. "="
			end
		elseif oprLevel == 2 then
			high4bits = bit32.lshift(last2or4bits, 2)
			index = bit32.bor(high4bits, bit32.rshift(v, 6)) + 1
			retVal = retVal .. string.sub(base64str, index, index)
			index = bit32.band(v, 63) + 1
			retVal = retVal .. string.sub(base64str, index, index)
		end
		oprLevel = (oprLevel+1)%3
	end
	return retVal
end

return base64
