return function(parent)
    local frame = parent:addFrame()
    frame:setPosition(1, 1)
    frame:setSize("parent.w", "parent.h")
    frame:setBackground(colors.black)

    frame:addLabel():setText("=== Turtle Map ==="):setPosition(2,2):setForeground(colors.yellow)
    -- Ajoute ici ta future map dynamique

    return frame
end