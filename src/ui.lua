--[[
    UI MODULE  
    UI creation and management
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer

local UI = {}
local Config = nil
local Utils = nil
local Fishing = nil

-- State
local ScreenGui = nil
local state = {}

-- Initialize
function UI.init(config, utils, fishing)
    Config = config
    Utils = utils
    Fishing = fishing
    state = {}
end

-- Create toggle component
local function createToggle(parent, title, desc, order, configKey, onToggle)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 50)
    card.Position = UDim2.new(0, 0, 0, (order - 1) * 58)
    card.BackgroundColor3 = Config.Colors.BgCard
    card.BackgroundTransparency = 0.4
    card.BorderSizePixel = 0
    card.Parent = parent
    Utils.createCorner(card, 10)
    Utils.createStroke(card, Config.Colors.Border, 1, 0.96)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -60, 0, 16)
    titleLabel.Position = UDim2.new(0, 12, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Config.Colors.TextWhite
    titleLabel.TextSize = 12
    titleLabel.Font = Enum.Font.GothamMedium
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = card
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -60, 0, 14)
    descLabel.Position = UDim2.new(0, 12, 0, 28)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = Config.Colors.TextMuted
    descLabel.TextSize = 10
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = card
    
    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 40, 0, 22)
    toggle.Position = UDim2.new(1, -50, 0.5, -11)
    toggle.BackgroundColor3 = Color3.fromRGB(42, 42, 58)
    toggle.Parent = card
    Utils.createCorner(toggle, 11)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(0, 3, 0.5, -8)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Parent = toggle
    Utils.createCorner(knob, 8)
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(1, 0, 1, 0)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Text = ""
    toggleBtn.Parent = toggle
    
    state[configKey] = false
    
    local function updateToggle()
        if state[configKey] then
            toggle.BackgroundColor3 = Config.Colors.AccentBlue
            knob.Position = UDim2.new(0, 21, 0.5, -8)
        else
            toggle.BackgroundColor3 = Color3.fromRGB(42, 42, 58)
            knob.Position = UDim2.new(0, 3, 0.5, -8)
        end
    end
    
    toggleBtn.MouseButton1Click:Connect(function()
        state[configKey] = not state[configKey]
        updateToggle()
        if onToggle then
            onToggle(state[configKey])
        end
    end)
    
    updateToggle()
end

-- Create Free UI
function UI.createFreeUI()
    -- Cleanup
    if game.CoreGui:FindFirstChild("AvyFreeUI") then
        game.CoreGui:FindFirstChild("AvyFreeUI"):Destroy()
    end
    
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AvyFreeUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game.CoreGui
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = Config.UI.FreeSize
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
    MainFrame.BackgroundColor3 = Config.Colors.BgDark
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    Utils.createCorner(MainFrame, 12)
    Utils.createStroke(MainFrame, Config.Colors.Border, 1, 0.92)
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = Config.Colors.BgMedium
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame
    Utils.createCorner(Header, 12)
    
    local HeaderFix = Instance.new("Frame")
    HeaderFix.Size = UDim2.new(1, 0, 0, 15)
    HeaderFix.Position = UDim2.new(0, 0, 1, -15)
    HeaderFix.BackgroundColor3 = Config.Colors.BgMedium
    HeaderFix.BorderSizePixel = 0
    HeaderFix.Parent = Header
    
    -- Logo
    local Logo = Instance.new("Frame")
    Logo.Size = UDim2.new(0, 28, 0, 28)
    Logo.Position = UDim2.new(0, 10, 0.5, -14)
    Logo.BackgroundColor3 = Config.Colors.AccentBlue
    Logo.BorderSizePixel = 0
    Logo.Parent = Header
    Utils.createCorner(Logo, 8)
    
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
    Title.TextColor3 = Config.Colors.TextWhite
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
    CloseBtn.TextColor3 = Config.Colors.TextGray
    CloseBtn.TextSize = 16
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = Header
    
    CloseBtn.MouseButton1Click:Connect(function()
        state.AutoFish = false
        state.AutoEquipRod = false
        ScreenGui:Destroy()
    end)
    
    -- Content
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -20, 1, -55)
    Content.Position = UDim2.new(0, 10, 0, 45)
    Content.BackgroundTransparency = 1
    Content.Parent = MainFrame
    
    -- Toggles
    createToggle(Content, "Auto Fish", "Automatically cast and reel", 1, "AutoFish", function(enabled)
        if enabled then
            task.spawn(function()
                Fishing.autoFishLoop(function() return state.AutoFish end)
            end)
        end
    end)
    
    createToggle(Content, "Auto Equip Rod", "Equip fishing rod automatically", 2, "AutoEquipRod", nil)
    
    -- Free Badge
    local FreeBadge = Instance.new("TextLabel")
    FreeBadge.Size = UDim2.new(0, 60, 0, 20)
    FreeBadge.Position = UDim2.new(0, 0, 1, -28)
    FreeBadge.BackgroundColor3 = Config.Colors.AccentBlue
    FreeBadge.BackgroundTransparency = 0.8
    FreeBadge.Text = "FREE"
    FreeBadge.TextColor3 = Config.Colors.AccentBlue
    FreeBadge.TextSize = 10
    FreeBadge.Font = Enum.Font.GothamBold
    FreeBadge.Parent = Content
    Utils.createCorner(FreeBadge, 5)
    
    -- Auto Equip Loop
    task.spawn(function()
        Fishing.autoEquipLoop(function() return state.AutoEquipRod end)
    end)
    
    Utils.log("Avy Free loaded successfully!", "Avy Free")
end

return UI
