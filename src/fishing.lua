--[[
    FISHING MODULE
    All fishing-related logic
--]]

local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

local Fishing = {}
local Config = nil
local Utils = nil

-- State
local isRunning = false

-- Initialize
function Fishing.init(config, utils)
    Config = config
    Utils = utils
end

-- Get fishing rod from character
function Fishing.getFishingRod()
    local character = LocalPlayer.Character
    if not character then return nil end
    
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Tool") then
            local name = item.Name:lower()
            if name:find("rod") or name:find("fish") or name:find("pancing") then
                return item
            end
        end
    end
    return nil
end

-- Find rod in backpack
function Fishing.findRodInBackpack()
    local backpack = LocalPlayer.Backpack
    if not backpack then return nil end
    
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            local name = item.Name:lower()
            if name:find("rod") or name:find("fish") or name:find("pancing") then
                return item
            end
        end
    end
    return nil
end

-- Equip rod
function Fishing.equipRod()
    local character = LocalPlayer.Character
    if not character then return false end
    
    -- Check if already equipped
    local equipped = Fishing.getFishingRod()
    if equipped then return true end
    
    -- Find in backpack
    local rod = Fishing.findRodInBackpack()
    if rod then
        rod.Parent = character
        task.wait(0.1)
        Utils.log("Equipped: " .. rod.Name)
        return true
    else
        Utils.log("No fishing rod found in backpack!")
        return false
    end
end

-- Simulate mouse click
local function simulateClick(holdTime)
    local viewport = workspace.CurrentCamera.ViewportSize
    local x, y = viewport.X / 2, viewport.Y / 2
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
    if holdTime and holdTime > 0 then task.wait(holdTime) end
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
end

-- Auto fishing loop
function Fishing.autoFishLoop(enabled)
    if isRunning then return end
    
    isRunning = true
    Utils.log("Auto Fishing Started!")
    
    while enabled() do
        local rod = Fishing.getFishingRod()
        if not rod then
            task.wait(2)
        else
            simulateClick(Config.CastHoldTime)
            task.wait(Config.WaitAfterCast)
            task.wait(Config.MaxWaitForBite)
            simulateClick(0.1)
            task.wait(Config.ReelDelay)
            task.wait(Config.RetryDelay)
        end
    end
    
    isRunning = false
    Utils.log("Auto Fishing Stopped!")
end

-- Auto equip loop
function Fishing.autoEquipLoop(enabled)
    while enabled() do
        local rod = Fishing.getFishingRod()
        if not rod then
            Fishing.equipRod()
        end
        task.wait(3)
    end
end

return Fishing
