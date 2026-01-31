--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║                      AVY HUB                              ║
    ║                Game Selection Menu                        ║
    ╚═══════════════════════════════════════════════════════════╝
--]]

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Colors
local Colors = {
    BgDark = Color3.fromRGB(18, 18, 28),
    BgMedium = Color3.fromRGB(25, 25, 38),
    BgCard = Color3.fromRGB(28, 28, 40),
    TextWhite = Color3.fromRGB(232, 232, 232),
    TextGray = Color3.fromRGB(102, 102, 102),
    AccentBlue = Color3.fromRGB(79, 172, 254),
    Border = Color3.fromRGB(255, 255, 255),
}

-- Cleanup old UI
if game.CoreGui:FindFirstChild("AvyHub") then
    game.CoreGui:FindFirstChild("AvyHub"):Destroy()
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AvyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Colors.BgDark
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = MainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Colors.Border
stroke.Thickness = 1
stroke.Transparency = 0.92
stroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Colors.BgMedium
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = Header

local headerFix = Instance.new("Frame")
headerFix.Size = UDim2.new(1, 0, 0, 15)
headerFix.Position = UDim2.new(0, 0, 1, -15)
headerFix.BackgroundColor3 = Colors.BgMedium
headerFix.BorderSizePixel = 0
headerFix.Parent = Header

-- Logo
local Logo = Instance.new("Frame")
Logo.Size = UDim2.new(0, 35, 0, 35)
Logo.Position = UDim2.new(0, 15, 0.5, -17)
Logo.BackgroundColor3 = Colors.AccentBlue
Logo.BorderSizePixel = 0
Logo.Parent = Header

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 8)
logoCorner.Parent = Logo

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "A"
LogoText.TextColor3 = Color3.new(1, 1, 1)
LogoText.TextSize = 18
LogoText.Font = Enum.Font.GothamBold
LogoText.Parent = Logo

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 0, 25)
Title.Position = UDim2.new(0, 60, 0.5, -12)
Title.BackgroundTransparency = 1
Title.Text = "Avy Hub"
Title.TextColor3 = Colors.TextWhite
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -15)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Colors.TextGray
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -40, 1, -90)
Content.Position = UDim2.new(0, 20, 0, 70)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Helper function
local function createGameButton(name, desc, order, scriptUrl)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 70)
    btn.Position = UDim2.new(0, 0, 0, (order - 1) * 80)
    btn.BackgroundColor3 = Colors.BgCard
    btn.BackgroundTransparency = 0.4
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.Parent = Content
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Colors.Border
    btnStroke.Thickness = 1
    btnStroke.Transparency = 0.96
    btnStroke.Parent = btn
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 15, 0, 12)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = name
    titleLabel.TextColor3 = Colors.TextWhite
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = btn
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -20, 0, 18)
    descLabel.Position = UDim2.new(0, 15, 0, 38)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = Colors.TextGray
    descLabel.TextSize = 11
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        print("[Avy] Loading " .. name .. "...")
        ScreenGui:Destroy()
        loadstring(game:HttpGet(scriptUrl))()
    end)
    
    return btn
end

-- Game Buttons
createGameButton(
    "Fish It Free", 
    "Basic automation features - completely free!",
    1,
    "https://raw.githubusercontent.com/Acheronnnn/Avy/main/Games/FishItFree.lua"
)

createGameButton(
    "Fish It Premium", 
    "Full-featured with all automation tools",
    2,
    "https://raw.githubusercontent.com/Acheronnnn/Avy/main/Games/FishItPremium.lua"
)

print("[Avy] Hub loaded!")
