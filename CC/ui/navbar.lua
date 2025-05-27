local M = {}

local names = {
    "Dashboard", "Autocraft", "Turtle Map", "Turtle Analyse", "Reactor"
}

function M.draw(currentPage, pages, keypadOpen, target)
    target = target or term
    local w, h = target.getSize()
    target.setCursorPos(1, h)
    if target.setBackgroundColor then target.setBackgroundColor(colors.gray) end
    if target.clearLine then target.clearLine() end
    local pos = 1
    for i, name in ipairs(pages) do
        target.setCursorPos(pos, h)
        if i == currentPage then
            if target.setTextColor then target.setTextColor(colors.yellow) end
            if target.setBackgroundColor then target.setBackgroundColor(colors.blue) end
        else
            if target.setTextColor then target.setTextColor(colors.white) end
            if target.setBackgroundColor then target.setBackgroundColor(colors.gray) end
        end
        target.write(" "..name.." ")
        pos = pos + #name + 2
    end
    if target.setTextColor then target.setTextColor(colors.lime) end
    if target.setBackgroundColor then target.setBackgroundColor(colors.gray) end
    target.setCursorPos(w-11, h)
    target.write(keypadOpen and "[Keypad:O]" or "[Keypad:F]")
    if target.setTextColor then target.setTextColor(colors.white) end
    if target.setBackgroundColor then target.setBackgroundColor(colors.black) end
end

function M.handleClick(x, currentPage, nbPages, keypadOpen)
    local w, h = term.getSize()
    if x >= w-10 and x <= w then
        return not keypadOpen, "keypad"
    end
    local pos = 1
    for i, name in ipairs(names) do
        local btnStart = pos
        local btnEnd = btnStart + #name + 1
        if x >= btnStart and x <= btnEnd then
            return i, "page"
        end
        pos = btnEnd + 1
    end
    return nil
end

return M