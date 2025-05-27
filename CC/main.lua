-- Contrôleur principal - Affichage sur le monitor derrière (si présent) et gestion tactile

-- Recherche du monitor derrière le PC
local mon = peripheral.find("monitor") or peripheral.wrap("back")
if mon then
    mon.setTextScale(1)
    mon.clear()
    mon.setCursorPos(1,1)
    term.redirect(mon)
    print("Monitor détecté derrière le PC.")
    print("L'affichage principal sera sur ce grand écran.")
else
    print("Aucun monitor détecté derrière le PC.")
    print("L'affichage restera sur le terminal de l'ordinateur.")
end

-- Importation des modules/pages
local navbar = require("ui/navbar")
local keypad = require("ui/keypad")
local sync = require("network/sync")
local dashboard = require("pages/dashboard")
local autocraft = require("pages/autocraft")
local turtle_map = require("pages/turtle_map")
local turtle_analyse = require("pages/turtle_analyse")
local reactor = require("pages/reactor")

local pages = {dashboard, autocraft, turtle_map, turtle_analyse, reactor}
local pageNames = {"Dashboard", "Autocraft", "Turtle Map", "Turtle Analyse", "Reactor"}
local currentPage = 1
local keypadOpen = false

local function draw()
    term.clear()
    term.setCursorPos(1,1)
    pages[currentPage].draw()
    navbar.draw(currentPage, pageNames, keypadOpen)
    if keypadOpen then
        keypad.draw(true)
    end
end

local function handleClick(x, y)
    local w, h = term.getSize()
    -- NavBar (en bas)
    if y == h then
        local navResult, navType = navbar.handleClick(x, currentPage, #pages, keypadOpen)
        if navType == "page" then
            currentPage = navResult
        elseif navType == "keypad" then
            keypadOpen = not keypadOpen
        end
        return
    end
    -- Keypad
    if keypadOpen and keypad.isOnKeypad(x, y) then
        keypad.handleClick(x, y)
        return
    end
    -- Page courante
    if pages[currentPage].handleClick then
        pages[currentPage].handleClick(x, y)
    end
end

local function mainLoop()
    while true do
        draw()
        local event, p1, p2, p3 = os.pullEvent()
        if event == "mouse_click" then
            handleClick(p2, p3)
        elseif event == "monitor_touch" then
            -- p1 = côté du monitor, p2 = x, p3 = y
            handleClick(p2, p3)
        elseif event == "char" and p1 == "q" then
            break
        end
    end
end

mainLoop()

-- Remet la sortie sur le terminal du PC à la fin (optionnel, utile si tu veux relancer le programme)
if mon then
    term.restore()
end
