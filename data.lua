data = {
save = function(filename, _data)      -- Save data to a JSON file in a folder that you can acces by with the command Win+R then typing %appdata% in the dialog box and looking for a folder called "LOVE".
    love.filesystem.write(filename..".csv", _data)
end,

load = function(filename)     -- Load the data inside a file
    if love.filesystem.getInfo(filename..".csv") ~= nil and love.filesystem.read(filename..".csv") ~= nil then
        return (love.filesystem.read(filename..".csv"))
    else
        return "failed"
    end
end,

loadDirectory = function(filename)     -- Load the data inside a folder
    if love.filesystem.getInfo(filename) ~= nil then
        return (love.filesystem.read(filename))
    else
        return "failed"
    end
end,

createDirectory = function (directoryName)
    love.filesystem.createDirectory(directoryName)
end,

delete = function (name)
    love.filesystem.remove(name)
end,

pack = function(t, drop, indent)
	assert(type(t) == "table", "Can only TSerial.pack tables.")
	local s, indent = "{"..(indent and "\n" or ""), indent and math.max(type(indent)=="number" and indent or 0,0)
	for k, v in pairs(t) do
		local tk, tv, skip = type(k), type(v)
		if tk == "boolean" then k = k and "[true]" or "[false]"
		elseif tk == "string" then if string.format("%q",k) ~= '"'..k..'"' then k = '['..string.format("%q",k)..']' end
		elseif tk == "number" then k = "["..k.."]"
		elseif tk == "table" then k = "["..data.pack(k, drop, indent and indent+1).."]"
		elseif type(drop) == "function" then k = "["..string.format("%q",drop(k)).."]"
		elseif drop then skip = true
		else error("Attempted to TSerial.pack a table with an invalid key: "..tostring(k))
		end
		if tv == "boolean" then v = v and "true" or "false"
		elseif tv == "string" then v = string.format("%q", v)
		elseif tv == "number" then	-- no change needed
		elseif tv == "table" then v = data.pack(v, drop, indent and indent+1)
		elseif type(drop) == "function" then v = "["..string.format("%q",drop(v)).."]"
		elseif drop then skip = true
		else error("Attempted to TSerial.pack a table with an invalid value: "..tostring(v))
		end
		if not skip then s = s..string.rep("\t",indent or 0)..k.."="..v..","..(indent and "\n" or "") end
	end
	return s..string.rep("\t",(indent or 1)-1).."}"
end,

unpack = function(s)
	assert(type(s) == "string", "Can only TSerial.unpack strings.")
	load("tab = "..tostring(s))()
	local t = tab
    tab = nil
	return t
end

}