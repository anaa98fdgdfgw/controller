return function(parent)
    local frame = parent:addFrame()
    frame:setPosition(1, 1)
    frame:setSize("parent.w", "parent.h")
    frame:setBackground(colors.black)

    local usines = {
        {name="Usine 1", state=false, side="back"},
        {name="Usine 2", state=false, side="right"},
        {name="Usine 3", state=false, side="left"}
    }

    local y = 2
    frame:addLabel():setText("=== Dashboard - Usines ==="):setPosition(2, y):setForeground(colors.white)

    for i, usine in ipairs(usines) do
        local lab = frame:addButton():setText(
            "["..i.."] "..usine.name.." : "..(usine.state and "ON" or "OFF"))
            :setPosition(2, y+1+i):setSize(20,1)
        lab:setForeground(usine.state and colors.green or colors.red)
        lab:onClick(function()
            usine.state = not usine.state
            lab:setText("["..i.."] "..usine.name.." : "..(usine.state and "ON" or "OFF"))
            lab:setForeground(usine.state and colors.green or colors.red)
            if peripheral and redstone then
                redstone.setOutput(usine.side, usine.state)
            end
        end)
    end

    frame:addLabel():setText("Cliquez sur un nom pour ON/OFF."):setPosition(2, y+6):setForeground(colors.white)

    return frame
end