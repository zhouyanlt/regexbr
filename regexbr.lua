
local filename,pattern,outputpath = ...

if not filename then
    print("Usage: lua regexbrackets.lua <filename>[,<pattern>,<outputpath>]")
    return
end

pattern = pattern or "Log%.d%d*%("
outputpath = outputpath or "output"

local bracket = pattern:byte(-1)
local BRACKETS = {
    [40] = 41,--()
    [91] = 93,--[]
    [123] = 125,--{}
}

local OPEN_BR = bracket
local CLOSE_BR = assert(BRACKETS[OPEN_BR])

local file = io.open(filename, "r")
if not file then
    print(string.format("Open file[%s] failed", filename))
    return
end

local content = file:read("a")
local fileLen = content:len()
local targets = {1}

do
    local i = 1
    while true do
        local first,last = content:find(pattern, i)
        if not first then
            break
        end

        local openBr = 1
        for cursor=last+1,fileLen do
            local c = content:byte(cursor)
            if c == OPEN_BR then
                openBr = openBr + 1
            elseif c == CLOSE_BR then
                openBr = openBr - 1
            end
            if openBr == 0 then
                -- table.insert(targets, {first, cursor})
                table.insert(targets, first-1)
                table.insert(targets, cursor+1)
                i = cursor + 1
                break
            end
        end
    end
end

table.insert(targets, fileLen)

local outputFullName = string.format("%s/%s", outputpath, filename)
local outputFullPath = outputFullName:sub(1, -filename:len()-1)
print(outputFullName, outputFullPath)
os.execute("mkdir -p " .. outputFullPath)

local output = io.open(outputFullName, "w")
for i=1,#targets,2 do
    local first = targets[i]
    local last = targets[i+1]
    output:write(content:sub(first, last))
end
output:close()



