--[[
    AVY FREE VERSION
    Entry point for free version
--]]

-- Load modules
local baseUrl = "https://raw.githubusercontent.com/Acheronnnn/Avy/main/src/"

local Config = loadstring(game:HttpGet(baseUrl .. "config.lua"))()
local Utils = loadstring(game:HttpGet(baseUrl .. "utils.lua"))()
local Fishing = loadstring(game:HttpGet(baseUrl .. "fishing.lua"))()
local UI = loadstring(game:HttpGet(baseUrl .. "ui.lua"))()

-- Initialize modules
Fishing.init(Config, Utils)
UI.init(Config, Utils, Fishing)

-- Create Free UI
UI.createFreeUI()

Utils.log("Welcome to Avy Free!", "Avy")
Utils.log("Upgrade to Premium for more features!", "Avy")
