return function(parent)
    local win = parent:addFrame()
    win:setSize(13, 9)
    win:setPosition("parent.w-15", 2)
    win:setBackground(colors.lightGray)
    -- win:setZIndex(100) -- SUPPRIMÉ, car cette méthode n'existe pas dans Basalt2
    win:setVisible(false)

    local keys = {
        {"1", "2", "3"},
        {"4", "5", "6"},
        {"7", "8", "9"},
        {"*", "0", "#"}
    }
    for y=1,4 do
        for x=1,3 do
            local btn = win:addButton()
            btn:setText(keys[y][x])
            btn:setPosition(2+(x-1)*4, 1+(y-1)*2)
            btn:setSize(3,1)
            btn:onClick(function()
                basalt.debug("Touche keypad : "..keys[y][x])
            end)
        end
    end

    return win
end
