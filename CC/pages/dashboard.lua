local M = {}

M.usines = {
    {name="Usine 1", state=false, side="back"},
    {name="Usine 2", state=false, side="right"},
    {name="Usine 3", state=false, side="left"}
}

function M.draw()
    print("=== Dashboard - Usines ===\n")
    for i, usine in ipairs(M.usines) do
        local status = usine.state and "ON" or "OFF"
        local color = usine.state and colors.green or colors.red
        term.setTextColor(color)
        print(string.format("[%d] %s : %s", i, usine.name, status))
    end
    term.setTextColor(colors.white)
    print("\nCliquez sur un nom pour ON/OFF.")
end

function M.handleClick(x, y)
    local idx = y-2
    if idx >= 1 and idx <= #M.usines then
        local usine = M.usines[idx]
        usine.state = not usine.state
        if peripheral and redstone then
            redstone.setOutput(usine.side, usine.state)
        end
    end
end

return M