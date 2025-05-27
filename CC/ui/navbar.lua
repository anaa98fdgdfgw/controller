local M = {}

local names = {
    "Dashboard", "Autocraft", "Turtle Map", "Turtle Analyse", "Reactor"
}

function M.draw(currentPage, pages, keypadOpen)
    local w, h = term.getSize()
    term.setCursorPos(1, h)
    term.setBackgroundColor(colors.gray)
    term.clearLine()
    local pos = 1
    for i, name in ipairs(pages) do
        term.setCursorPos(pos, h)
        if i == currentPage then
            term.setTextColor(colors.yellow)
            term.setBackgroundColor(colors.blue)
        else
            term.setTextColor(colors.white)
            term.setBackgroundColor(colors.gray)
        end
        write(" "..name.." ")
        pos = pos + #name + 2
    end
    term.setTextColor(colors.lime)
    term.setBackgroundColor(colors.gray)
    term.setCursorPos(w-11, h)
    write(keypadOpen and "[Keypad:O]" or "[Keypad:F]")
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)
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