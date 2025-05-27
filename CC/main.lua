local basalt = require("basalt")

local pageNames = {"Dashboard", "Autocraft", "Turtle Map", "Turtle Analyse", "Reactor"}
local pageModules = {
    require("pages.dashboard"),
    require("pages.autocraft"),
    require("pages.turtle_map"),
    require("pages.turtle_analyse"),
    require("pages.reactor")
}

local main = basalt.createFrame()
main:setSize("parent.w", "parent.h")

-- Zone centrale pour les pages
local content = main:addFrame()
content:setPosition(1, 1)
content:setSize("parent.w", "parent.h-1")
content:setBackground(colors.black)

-- Construction des pages (chacune est un frame Basalt)
local pages = {}
for i, mod in ipairs(pageModules) do
    pages[i] = mod(content)
    pages[i]:setVisible(i == 1)
end

-- Keypad flottant
local keypad = require("ui.keypad")(main)
keypad:setVisible(false)

-- Navbar adaptative
local navbar = main:addPane()
navbar:setPosition(1, "parent.h")
navbar:setSize("parent.w", 1)
navbar:setBackground(colors.gray)

local function showPage(idx)
    for i, page in ipairs(pages) do
        page:setVisible(i == idx)
    end
end

-- Ajout dynamique des boutons de la navbar (adaptatif)
local function drawNavbar()
    navbar:removeChildren()
    local x = 2
    local btnW = math.max(8, math.floor((navbar:getWidth() - 12) / #pageNames))
    for i, name in ipairs(pageNames) do
        local btn = navbar:addButton()
        btn:setText(name)
        btn:setPosition(x, 1)
        btn:setSize(btnW, 1)
        if i == 1 then
            btn:setForeground(colors.yellow):setBackground(colors.blue)
        end
        btn:onClick(function()
            showPage(i)
            drawNavbar()
        end)
        x = x + btnW + 1
    end
    -- Keypad bouton à droite
    local keypadBtn = navbar:addButton()
    keypadBtn:setText(keypad:isVisible() and "[Keypad:O]" or "[Keypad:F]")
    keypadBtn:setPosition(navbar:getWidth()-12, 1)
    keypadBtn:setSize(12, 1)
    keypadBtn:setForeground(colors.lime)
    keypadBtn:onClick(function()
        keypad:setVisible(not keypad:isVisible())
        drawNavbar()
    end)
end

navbar:onChange(drawNavbar)
main:onChange(drawNavbar)
drawNavbar()

basalt.autoUpdate()