--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║                    AVY FISH IT FREE                       ║
    ║                   Version 1.0.0                           ║
    ╚═══════════════════════════════════════════════════════════╝
    
    FREE FEATURES:
    - Auto Fish
    - Auto Equip Rod
--]]

-- Services
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Config
local Config = {
    AutoFish = false,
    AutoEquipRod = false,
    CastHoldTime = 0.8,
    WaitAfterCast = 1.5,
    MaxWaitForBite = 20,
    ReelDelay = 0.5,
    RetryDelay = 1,
}

-- Colors
local Colors = {
    BgDark = Color3.fromRGB(18, 18, 28),
    BgMedium = Color3.fromRGB(25, 25, 38),
    BgCard = Color3.fromRGB(28, 28, 40),
    TextWhite = Color3.fromRGB(232, 232, 232),
    TextGray = Color3.fromRGB(102, 102, 102),
    TextMuted = Color3.fromRGB(85, 85, 85),
    AccentBlue = Color3.fromRGB(79, 172, 254),
    Border = Color3.fromRGB(255, 255, 255),
}

-- Utility
local function log(msg)
    print("[Avy Free] " .. tostring(msg))
end

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Colors.Border
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.92
    stroke.Parent = parent
    return stroke
end

-- Fishing Functions
local function getFishingRod()
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

local function findRodInBackpack()
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

local function equipRod()
    local character = LocalPlayer.Character
    if not character then return false end
    local equipped = getFishingRod()
    if equipped then return true end
    local rod = findRodInBackpack()
    if rod then
        rod.Parent = character
        task.wait(0.1)
        log("Equipped: " .. rod.Name)
        return true
    end
    return false
end

local function simulateClick(holdTime)
    local viewport = workspace.CurrentCamera.ViewportSize
    local x, y = viewport.X / 2, viewport.Y / 2
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
    if holdTime and holdTime > 0 then task.wait(holdTime) end
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
end

local function autoFishLoop()
    log("Auto Fishing Started!")
    while Config.AutoFish do
        local rod = getFishingRod()
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
    log("Auto Fishing Stopped!")
end

-- UI Creation
if game.CoreGui:FindFirstChild("AvyFreeUI") then
    game.CoreGui:FindFirstChild("AvyFreeUI"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AvyFreeUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Main Frame
local MainFrame = Instance.new("Frame  ")
MainFrame.Size = UDim2.new(0, 350, 0, 220)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
MainFrame.BackgroundColor3 = Colors.BgDark
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
createCorner(MainFrame, 12)
createStroke(MainFrame, Colors.Border, 1, 0.92)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Colors.BgMedium
Header.BorderSizePixel = 0
Header.Parent = MainFrame
createCorner(Header, 12)

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 15)
HeaderFix.Position = UDim2.new(0, 0, 1, -15)
HeaderFix.BackgroundColor3 = Colors.BgMedium
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

-- Logo
local Logo = Instance.new("Frame")
Logo.Size = UDim2.new(0, 28, 0, 28)
Logo.Position = UDim2.new(0, 10, 0.5, -14)
Logo.BackgroundColor3 = Colors.AccentBlue
Logo.BorderSizePixel = 0
Logo.Parent = Header
createCorner(Logo, 8)

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "A"
LogoText.TextColor3 = Color3.new(1, 1, 1)
LogoText.TextSize = 14
LogoText.Font = Enum.Font.GothamBold
LogoText.Parent = Logo

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 0, 20)
Title.Position = UDim2.new(0, 45, 0.5, -10)
Title.BackgroundTransparency = 1
Title.Text = "Avy Free | Fish It"
Title.TextColor3 = Colors.TextWhite
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Colors.TextGray
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

CloseBtn.MouseButton1Click:Connect(function()
    Config.AutoFish = false
    ScreenGui:Destroy()
end)

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -55)
Content.Position = UDim2.new(0, 10, 0, 45)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Toggle Helper
local function createToggle(title, desc, order, configKey)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 50)
    card.Position = UDim2.new(0, 0, 0, (order - 1) * 58)
    card.BackgroundColor3 = Colors.BgCard
    card.BackgroundTransparency = 0.4
    card.BorderSizePixel = 0
    card.Parent = Content
    createCorner(card, 10)
    createStroke(card, Colors.Border, 1, 0.96)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -60, 0, 16)
    titleLabel.Position = UDim2.new(0, 12, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Colors.TextWhite
    titleLabel.TextSize = 12
    titleLabel.Font = Enum.Font.GothamMedium
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = card
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -60, 0, 14)
    descLabel.Position = UDim2.new(0, 12, 0, 28)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = Colors.TextMuted
    descLabel.TextSize = 10
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = card
    
    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 40, 0, 22)
    toggle.Position = UDim2.new(1, -50, 0.5, -11)
    toggle.BackgroundColor3 = Color3.fromRGB(42, 42, 58)
    toggle.Parent = card
    createCorner(toggle, 11)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(0, 3, 0.5, -8)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Parent = toggle
    createCorner(knob, 8)
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(1, 0, 1, 0)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Text = ""
    toggleBtn.Parent = toggle
    
    local isOn = Config[configKey] or false
    
    local function updateToggle()
        if isOn then
            toggle.BackgroundColor3 = Colors.AccentBlue
            knob.Position = UDim2.new(0, 21, 0.5, -8)
        else
            toggle.BackgroundColor3 = Color3.fromRGB(42, 42, 58)
            knob.Position = UDim2.new(0, 3, 0.5, -8)
        end
        Config[configKey] = isOn
    end
    
    toggleBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        updateToggle()
        if configKey == "AutoFish" and isOn then
            task.spawn(autoFishLoop)
        end
    end)
    
    updateToggle()
end

-- Create Toggles
createToggle("Auto Fish", "Automatically cast and reel", 1, "AutoFish")
createToggle("Auto Equip Rod", "Equip fishing rod automatically", 2, "AutoEquipRod")

-- Free Badge
local FreeBadge = Instance.new("TextLabel")
FreeBadge.Size = UDim2.new(0, 60, 0, 20)
FreeBadge.Position = UDim2.new(0, 10, 1, -28)
FreeBadge.BackgroundColor3 = Colors.AccentBlue
FreeBadge.BackgroundTransparency = 0.8
FreeBadge.Text = "FREE"
FreeBadge.TextColor3 = Colors.AccentBlue
FreeBadge.TextSize = 10
FreeBadge.Font = Enum.Font.GothamBold
FreeBadge.Parent = Content
createCorner(FreeBadge, 5)

-- Auto Equip Loop
task.spawn(function()
    while ScreenGui.Parent do
        if Config.AutoEquipRod then
            local rod = getFishingRod()
            if not rod then
                equipRod()
            end
        end
        task.wait(3)
    end
end)

log("Avy Free loaded successfully!")
log("Free version - Upgrade to Premium for more features!")
