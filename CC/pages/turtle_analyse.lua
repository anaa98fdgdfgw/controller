local M = {}
M.turtles = {
    -- {id="T1", fuel=1234, x=1, y=65, z=3, job="Labour", time=120, inventory={"Seed","Wheat"}}
}

function M.draw()
    print("=== Analyse Turtles ===\n")
    if #M.turtles == 0 then
        print("Aucune turtle détectée.")
    else
        for i, t in ipairs(M.turtles) do
            print(string.format("[%d] %s @ (%d,%d,%d) | Fuel: %d | Tâche: %s | Temps: %ds", i, t.id, t.x, t.y, t.z, t.fuel, t.job, t.time or 0))
        end
    end
    print("\nCliquez sur une turtle pour les détails.")
end

function M.handleClick(x, y)
    local idx = y-2
    if idx >= 1 and idx <= #M.turtles then
        local t = M.turtles[idx]
        term.clear()
        print("=== Détail Turtle ===\n")
        print("ID:", t.id)
        print("Coord:", t.x, t.y, t.z)
        print("Fuel:", t.fuel)
        print("Inventaire:")
        for _, item in ipairs(t.inventory or {}) do
            print(" -", item)
        end
        print("Tâche:", t.job)
        print("Temps restant:", t.time or "N/A")
        print("\nAppuie sur une touche pour revenir.")
        os.pullEvent("char")
    end
end

return M