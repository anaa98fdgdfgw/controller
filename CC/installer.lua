-- Installeur complet pour controller (ComputerCraft)
-- Télécharge tous les fichiers dans la bonne arborescence

shell.run("mkdir", "ui")
shell.run("mkdir", "network")
shell.run("mkdir", "pages")

print("Téléchargement de main.lua")
shell.run("wget", "-f", "https://raw.githubusercontent.com/anaa98fdgdfgw/controller/main/CC/main.lua", "main.lua")

print("Téléchargement de ui/navbar.lua")
shell.run("wget", "-f", "https://raw.githubusercontent.com/anaa98fdgdfgw/controller/main/CC/ui/navbar.lua", "ui/navbar.lua")

print("Téléchargement de ui/keypad.lua")
shell.run("wget", "-f", "https://raw.githubusercontent.com/anaa98fdgdfgw/controller/main/CC/ui/keypad.lua", "ui/keypad.lua")

print("Téléchargement de network/sync.lua")
shell.run("wget", "-f", "https://raw.githubusercontent.com/anaa98fdgdfgw/controller/main/CC/network/sync.lua", "network/sync.lua")

print("Téléchargement de pages/dashboard.lua")
shell.run("wget", "-f", "https://raw.githubusercontent.com/anaa98fdgdfgw/controller/main/CC/pages/dashboard.lua", "pages/dashboard.lua")

print("Téléchargement de pages/autocraft.lua")
shell.run("wget", "-f", "https://raw.githubusercontent.com/anaa98fdgdfgw/controller/main/CC/pages/autocraft.lua", "pages/autocraft.lua")

print("Téléchargement de pages/turtle_map.lua")
shell.run("wget", "-f", "https://raw.githubusercontent.com/anaa98fdgdfgw/controller/main/CC/pages/turtle_map.lua", "pages/turtle_map.lua")

print("Téléchargement de pages/turtle_analyse.lua")
shell.run("wget", "-f", "https://raw.githubusercontent.com/anaa98fdgdfgw/controller/main/CC/pages/turtle_analyse.lua", "pages/turtle_analyse.lua")

print("Téléchargement de pages/reactor.lua")
shell.run("wget", "-f", "https://raw.githubusercontent.com/anaa98fdgdfgw/controller/main/CC/pages/reactor.lua", "pages/reactor.lua")

print("Installation terminée ! Utilise la commande main pour démarrer.")
