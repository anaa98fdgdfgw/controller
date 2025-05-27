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

    -- Calcul de la place dispo pour les onglets
    local rightBtn = keypadOpen and "[Keypad:O]" or "[Keypad:F]"
    local rightLen = #rightBtn
    local spaceLeft = w - rightLen - 1
    local navString = ""
    local pos = 1
    local lastBtn = 0
    for i, name in ipairs(pages) do
        local btn = " "..name.." "
        if #navString + #btn > spaceLeft then
            navString = navString .. "…"
            break
        end
        navString = navString .. btn
        lastBtn = i
    end

    -- Affichage adaptatif de la barre
    target.setCursorPos(1, h)
    local idx = 1
    local charCount = 1
    for i, name in ipairs(pages) do
        local btn = " "..name.." "
        if charCount + #btn > spaceLeft then
            if charCount < spaceLeft then
                if target.setTextColor then target.setTextColor(colors.white) end
                if target.setBackgroundColor then target.setBackgroundColor(colors.gray) end
                target.write("…")
            end
            charCount = spaceLeft + 1
            break
        end
        target.setCursorPos(charCount, h)
        if i == currentPage then
            if target.setTextColor then target.setTextColor(colors.yellow) end
            if target.setBackgroundColor then target.setBackgroundColor(colors.blue) end
        else
            if target.setTextColor then target.setTextColor(colors.white) end
            if target.setBackgroundColor then target.setBackgroundColor(colors.gray) end
        end
        target.write(btn)
        charCount = charCount + #btn
        idx = idx + 1
    end

    -- Bouton Keypad à droite si possible
    if rightLen < w then
        if target.setTextColor then target.setTextColor(colors.lime) end
        if target.setBackgroundColor then target.setBackgroundColor(colors.gray) end
        target.setCursorPos(w - rightLen + 1, h)
        target.write(rightBtn)
    end

    -- Reset
    if target.setTextColor then target.setTextColor(colors.white) end
    if target.setBackgroundColor then target.setBackgroundColor(colors.black) end
end

function M.handleClick(x, currentPage, nbPages, keypadOpen, target)
    target = target or term
    local w, h = target.getSize()
    local rightBtn = keypadOpen and "[Keypad:O]" or "[Keypad:F]"
    local rightLen = #rightBtn
    if x >= w - rightLen + 1 and x <= w then
        return not keypadOpen, "keypad"
    end
    -- Calcul adaptatif des boutons
    local spaceLeft = w - rightLen - 1
    local pos = 1
    for i, name in ipairs(names) do
        local btnStart = pos
        local btnEnd = btnStart + #name + 1
        if btnEnd > spaceLeft then break end
        if x >= btnStart and x <= btnEnd then
            return i, "page"
        end
        pos = btnEnd + 1
    end
    return nil
end

return M