-- Fish It Auto-Fishing Script
-- Simple version: Auto cast and reel

local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- Configuration
local Config = {
    Enabled = false,
    CastDelay = 0.5,      -- Delay before releasing cast
    WaitForBite = 15,     -- Max wait time for bite (seconds)
    ReelDelay = 0.3,      -- Delay after reel
}

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FishItAutoUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.5, -100, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Fish It Auto"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 160, 0, 40)
ToggleButton.Position = UDim2.new(0.5, -80, 0, 45)
ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
ToggleButton.Text = "Start Auto Fish"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Parent = Frame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = ToggleButton

-- Make UI draggable
local dragging, dragInput, dragStart, startPos

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Helper Functions
local function getFishingRod()
    local character = LocalPlayer.Character
    if not character then return nil end
    
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") and (tool.Name:lower():find("rod") or tool.Name:lower():find("fish")) then
            return tool
        end
    end
    
    return nil
end

local function simulateMouseClick(holdTime)
    local mouse = LocalPlayer:GetMouse()
    local screenCenter = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
    
    -- Mouse down
    VirtualInputManager:SendMouseButtonEvent(screenCenter.X, screenCenter.Y, 0, true, game, 0)
    
    if holdTime then
        task.wait(holdTime)
    end
    
    -- Mouse up
    VirtualInputManager:SendMouseButtonEvent(screenCenter.X, screenCenter.Y, 0, false, game, 0)
end

local function castRod()
    print("[Auto Fish] Casting rod...")
    simulateMouseClick(Config.CastDelay)
end

local function reelIn()
    print("[Auto Fish] Reeling in...")
    simulateMouseClick()
end

local function waitForBite(rod)
    local startTime = tick()
    
    -- Try to detect bite by monitoring rod properties
    while tick() - startTime < Config.WaitForBite do
        if not Config.Enabled then return false end
        
        -- Check if rod still exists
        if not rod or not rod.Parent then
            return false
        end
        
        -- Simple time-based detection (can be improved)
        task.wait(0.1)
    end
    
    return true
end

-- Main Auto-Fishing Loop
local function autoFish()
    while Config.Enabled do
        local rod = getFishingRod()
        
        if not rod then
            print("[Auto Fish] No fishing rod equipped! Waiting...")
            task.wait(2)
        else
            -- Cast
            castRod()
            task.wait(1)
            
            -- Wait for bite
            if waitForBite(rod) then
                -- Reel in
                reelIn()
                task.wait(Config.ReelDelay)
            end
            
            task.wait(0.5)
        end
    end
end

-- Toggle Button Logic
ToggleButton.MouseButton1Click:Connect(function()
    Config.Enabled = not Config.Enabled
    
    if Config.Enabled then
        ToggleButton.Text = "Stop Auto Fish"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
        print("[Auto Fish] Started!")
        
        task.spawn(autoFish)
    else
        ToggleButton.Text = "Start Auto Fish"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        print("[Auto Fish] Stopped!")
    end
end)

print("[Auto Fish] Script loaded! Click the button to start.")
