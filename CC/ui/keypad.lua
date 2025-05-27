local M = {}

M.keys = {
    {"1", "2", "3"},
    {"4", "5", "6"},
    {"7", "8", "9"},
    {"*", "0", "#"}
}
M.x0, M.y0 = 2, 2

function M.draw(open, target)
    target = target or term
    if not open then return end
    for y=1,4 do
        for x=1,3 do
            target.setCursorPos(M.x0+(x-1)*4, M.y0+(y-1)*2)
            if target.setBackgroundColor then target.setBackgroundColor(colors.lightGray) end
            if target.setTextColor then target.setTextColor(colors.black) end
            target.write(" "..M.keys[y][x].." ")
        end
    end
    if target.setBackgroundColor then target.setBackgroundColor(colors.black) end
end

function M.isOnKeypad(x, y)
    for ky=1,4 do
        for kx=1,3 do
            local px = M.x0+(kx-1)*4
            local py = M.y0+(ky-1)*2
            if x >= px and x <= px+2 and y == py then
                return true
            end
        end
    end
    return false
end

function M.handleClick(x, y)
    for ky=1,4 do
        for kx=1,3 do
            local px = M.x0+(kx-1)*4
            local py = M.y0+(ky-1)*2
            if x >= px and x <= px+2 and y == py then
                print("Touche keypad :", M.keys[ky][kx])
                return M.keys[ky][kx]
            end
        end
    end
    return nil
end

return M