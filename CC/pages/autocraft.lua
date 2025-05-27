return function(parent)
    local frame = parent:addFrame()
    frame:setPosition(1, 1)
    frame:setSize("parent.w", "parent.h")
    frame:setBackground(colors.black)

    local patterns = {
        {name="Iron", state=true},
        {name="Gold", state=false},
        {name="Diamond", state=true}
    }

    local y = 2
    frame:addLabel():setText("=== Autocraft AE2 ==="):setPosition(2, y):setForeground(colors.cyan)
    for i, pat in ipairs(patterns) do
        local lab = frame:addButton()
            :setText("["..i.."] Pattern "..pat.name.." : "..(pat.state and "ACTIF" or "INACTIF"))
            :setPosition(2, y+1+i):setSize(30,1)
        lab:setForeground(pat.state and colors.green or colors.red)
        lab:onClick(function()
            pat.state = not pat.state
            lab:setText("["..i.."] Pattern "..pat.name.." : "..(pat.state and "ACTIF" or "INACTIF"))
            lab:setForeground(pat.state and colors.green or colors.red)
        end)
    end
    frame:addLabel():setText("Cliquez sur un pattern pour activer/désactiver."):setPosition(2, y+6):setForeground(colors.white)

    return frame
end