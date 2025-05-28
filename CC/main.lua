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

-- Navbar adaptative (utilise addFrame() pour Basalt2)
local navbar = main:addFrame()
navbar:setPosition(1, "parent.h")
navbar:setSize("parent.w", 1)
navbar:setBackground(colors.gray)

local function showPage(idx)
    for i, page in ipairs(pages) do
        if page then
            page:setVisible(i == idx)
        end
    end
end

-- Pour effacer tous les widgets enfants dans la navbar (compatible Basalt2)
local function clearNavbar()
    local children = navbar:getChildren()
    for i = #children, 1, -1 do
        children[i]:remove()
    end
end

-- Ajout dynamique des boutons de la navbar (adaptatif)
local function drawNavbar()
    clearNavbar()
    local w = tonumber(navbar:getWidth())
    if not w or w == 0 then
        -- On tente de prendre la taille du frame parent (main)
        w = tonumber(main:getWidth())
    end
    if not w or w == 0 then
        w = 51 -- valeur par défaut raisonnable pour un écran standard
    end
    local btnW = math.max(8, math.floor((w - 14) / #pageNames))
    local x = 2
    for i, name in ipairs(pageNames) do
        local btn = navbar:addButton()
        btn:setText(name)
        btn:setPosition(x, 1)
        btn:setSize(btnW, 1)
        -- Correction ici : teste si pages[i] existe avant d'appeler isVisible()
        if pages[i] and pages[i].isVisible and pages[i]:isVisible() then
            btn:setForeground(colors.yellow):setBackground(colors.blue)
        else
            btn:setForeground(colors.white):setBackground(colors.gray)
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
    keypadBtn:setPosition(w-12, 1)
    keypadBtn:setSize(12, 1)
    keypadBtn:setForeground(colors.lime):setBackground(colors.gray)
    keypadBtn:onClick(function()
        keypad:setVisible(not keypad:isVisible())
        drawNavbar()
    end)
end

-- Redessiner la navbar quand la taille change
navbar:onChange(drawNavbar)
main:onChange(drawNavbar)
drawNavbar()

basalt.autoUpdate()