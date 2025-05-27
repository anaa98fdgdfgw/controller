-- Affichage et détection tactile sur monitor ET terminal/pocket

-- Détection du monitor externe
local mon = peripheral.find("monitor")
local hasMonitor = mon ~= nil

if hasMonitor then
    mon.setTextScale(1)
    mon.clear()
    mon.setCursorPos(1,1)
    mon.write("Monitor détecté !\n")
    mon.write("L'affichage sera aussi sur ce grand écran.\n")
else
    print("Aucun monitor externe détecté.")
    print("L'affichage reste sur le terminal/pocket.")
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

-- Utilitaires d'affichage double
local function termClear()
    term.clear()
    term.setCursorPos(1,1)
end
local function monClear()
    if hasMonitor then
        mon.clear()
        mon.setCursorPos(1,1)
    end
end
local function bothClear()
    termClear()
    monClear()
end

local function termWrite(str)
    print(str)
end
local function monWrite(str)
    if hasMonitor then
        local x, y = mon.getCursorPos()
        mon.write(str)
        -- Ajoute un saut de ligne manuel si besoin
        local _, ny = mon.getCursorPos()
        if ny == y then
            mon.setCursorPos(1, y+1)
        end
    end
end
local function bothWrite(str)
    termWrite(str)
    monWrite(str)
end

-- Fonction pour dessiner l'UI sur les deux supports
local function draw()
    -- Terminal
    termClear()
    pages[currentPage].draw()
    navbar.draw(currentPage, pageNames, keypadOpen)
    if keypadOpen then
        keypad.draw(true)
    end
    -- Monitor
    if hasMonitor then
        monClear()
        if pages[currentPage].draw then
            pages[currentPage].draw(mon)
        end
        navbar.draw(currentPage, pageNames, keypadOpen, mon)
        if keypadOpen then
            keypad.draw(true, mon)
        end
    end
end

-- Gestion du clic pour les deux écrans
local function handleClick(x, y, onMonitor)
    local w, h = term.getSize()
    if onMonitor and hasMonitor then
        w, h = mon.getSize()
    end
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
            -- Clic sur le terminal ou pocket (p2, p3 = x, y)
            handleClick(p2, p3, false)
        elseif event == "monitor_touch" then
            -- Clic tactile sur le monitor (p2, p3 = x, y)
            handleClick(p2, p3, true)
        elseif event == "char" and p1 == "q" then
            break
        end
    end
end

mainLoop()
