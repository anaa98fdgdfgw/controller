local M = {}

M.champs = {
    -- {name="Champ1", p1={x=0,y=0,z=0}, p2={x=5,y=0,z=5}, seedChest={x=1,y=0,z=1}, fuelChest={x=2,y=0,z=2}, turtles={"T1"}}
}

function M.draw()
    print("=== Carte Agricole ===\n")
    if #M.champs == 0 then
        print("Aucun champ défini. Ajoutez-en un !")
    else
        for i, champ in ipairs(M.champs) do
            print(string.format("[%d] %s : de (%d,%d,%d) à (%d,%d,%d)", i, champ.name, champ.p1.x, champ.p1.y, champ.p1.z, champ.p2.x, champ.p2.y, champ.p2.z))
            print("  Turtles:", table.concat(champ.turtles or {}, ", "))
        end
    end
    print("\nCliquer pour ajouter un champ (fonction à compléter).")
end

function M.handleClick(x, y)
    -- Ici tu peux coder l'ajout d'un champ via dialogue ou clic
end

return M