local base = "https://raw.githubusercontent.com/anaa98fdgdfgw/controller/main/CC/"

local files = {
    "main.lua",
    "ui/navbar.lua",
    "ui/keypad.lua",
    "network/sync.lua",
    "pages/dashboard.lua",
    "pages/autocraft.lua",
    "pages/turtle_map.lua",
    "pages/turtle_analyse.lua",
    "pages/reactor.lua"
}

for _, path in ipairs(files) do
    local url = base .. path
    local dest = path
    local dir = dest:match("(.+)/")
    if dir then shell.run("mkdir", dir) end
    print("Téléchargement de "..dest)
    shell.run("wget", "-f", url, dest)
end

print("Installation terminée ! Lancez main.lua pour démarrer.")