local M = {}

M.patterns = {
    {name="Pattern Iron", enabled=true},
    {name="Pattern Gold", enabled=false},
    {name="Pattern Diamond", enabled=true}
}

function M.draw()
    print("=== Autocraft AE2 ===\n")
    for i, p in ipairs(M.patterns) do
        local status = p.enabled and "ACTIF" or "INACTIF"
        local color = p.enabled and colors.green or colors.red
        term.setTextColor(color)
        print(string.format("[%d] %s : %s", i, p.name, status))
    end
    term.setTextColor(colors.white)
    print("\nCliquez sur un pattern pour activer/désactiver.")
end

function M.handleClick(x, y)
    local idx = y-2
    if idx >= 1 and idx <= #M.patterns then
        local p = M.patterns[idx]
        p.enabled = not p.enabled
        -- Ajoute ici la logique d'appel au système AE2 si besoin
    end
end

return M