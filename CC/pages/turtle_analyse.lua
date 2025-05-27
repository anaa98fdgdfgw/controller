return function(parent)
    local frame = parent:addFrame()
    frame:setPosition(1, 1)
    frame:setSize("parent.w", "parent.h")
    frame:setBackground(colors.black)

    frame:addLabel():setText("=== Turtle Analyse ==="):setPosition(2,2):setForeground(colors.magenta)
    -- Ajoute ici tes stats, logs, etc.

    return frame
end