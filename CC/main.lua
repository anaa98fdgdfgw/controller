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
        local event, btn, x, y = os.pullEvent()
        if event == "mouse_click" then
            handleClick(x, y)
        elseif event == "char" and btn == "q" then
            break
        end
    end
end

mainLoop()