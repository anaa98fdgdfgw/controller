return function(parent)
    local frame = parent:addFrame()
    frame:setPosition(1, 1)
    frame:setSize("parent.w", "parent.h")
    frame:setBackground(colors.black)

    frame:addLabel():setText("=== Reactor Control ==="):setPosition(2,2):setForeground(colors.orange)
    -- Ajoute ici le contrôle de ton réacteur

    return frame
end