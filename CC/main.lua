local navbar = require("ui.navbar")
local keypad = require("ui.keypad")
local sync = require("network.sync")
local dashboard = require("pages.dashboard")
local autocraft = require("pages.autocraft")
local turtle_map = require("pages.turtle_map")
local turtle_analyse = require("pages.turtle_analyse")
local reactor = require("pages.reactor")

-- Initialisation, boucle principale, navigation entre pages, etc.
-- À compléter selon la logique de ton projet