--[[
    CONFIG MODULE
    All configuration and constants
--]]

local Config = {}

-- Version
Config.Version = "2.0.0"
Config.Author = "Avy"

-- Features
Config.Free = {
    AutoFish = true,
    AutoEquipRod = true,
}

Config.Premium = {
    AutoFish = true,
    AutoSell = true,
    AutoCollect = true,
    AutoEquipRod = true,
    Teleport = true,
}

-- Timing
Config.CastHoldTime = 0.8
Config.WaitAfterCast = 1.5
Config.MaxWaitForBite = 20
Config.ReelDelay = 0.5
Config.RetryDelay = 1

-- UI Settings
Config.UI = {
    FreeSize = UDim2.new(0, 350, 0, 220),
    PremiumSize = UDim2.new(0, 520, 0, 290),
    IconSize = UDim2.new(0, 50, 0, 50),
}

-- Colors
Config.Colors = {
    BgDark = Color3.fromRGB(18, 18, 28),
    BgMedium = Color3.fromRGB(25, 25, 38),
    BgCard = Color3.fromRGB(28, 28, 40),
    TextWhite = Color3.fromRGB(232, 232, 232),
    TextGray = Color3.fromRGB(102, 102, 102),
    TextMuted = Color3.fromRGB(85, 85, 85),
    AccentBlue = Color3.fromRGB(79, 172, 254),
    AccentCyan = Color3.fromRGB(0, 198, 251),
    Success = Color3.fromRGB(60, 220, 60),
    Error = Color3.fromRGB(220, 60, 60),
    Border = Color3.fromRGB(255, 255, 255),
}

return Config
