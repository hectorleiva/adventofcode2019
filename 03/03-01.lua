local file = "./03.input"
wireA = {}
wireB = {}

function read_lines_from_file(file)
    f = io.input(file)
    contents = {}

    for line in f:lines() do
        table.insert(contents, line)
    end

    f:close()
    return contents
end

local contents = read_lines_from_file(file)

function iterate(a)
    for i in ipairs(a) do
        print(a[i])
    end
end

function direction_calculator(coordinate_direction, wire, lastX, lastY)
    local direction = string.sub(coordinate_direction, 1, 1)
    local distance = string.sub(coordinate_direction, 2)

    if direction == "U" then
        if wire[lastX] ~= nil then
            wire[lastX] = {}
        end

        for i=1, distance do
            table.insert(wire[lastX], lastY + i)
        end

        lastY = lastY + distance
    elseif direction == "D" then
        if wire[lastX] ~= nil then
            wire[lastX] = {}
        end

        for i=1, distance do
            table.insert(wire[lastX], lastY - i)
        end

        lastY = lastY - distance
    elseif direction == "L" then
        for i=1, distance do
            wire[lastX - i] = { lastY }
        end

        lastX = lastX - distance
    else
        for i=1, distance do
            wire[lastX + i] = { lastY }
        end

        lastX = lastX + distance
    end

    for i in ipairs(wire) do
        print(i)
    end

    return wire, lastX, lastY
end


for k, line in ipairs(contents) do
    lastX = 0
    lastY = 0
    for coordinate_direction in string.gmatch(line, "([^,]+),?") do
        if k == 1 then
            wire, lastX, lastY = direction_calculator(coordinate_direction, wireA, lastX, lastY)
        else
        end
    end
end
