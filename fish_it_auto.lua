--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║                   Fish It Auto Script                     ║
    ║                      Version 1.0                          ║
    ║              Created for Delta Executor                   ║
    ╚═══════════════════════════════════════════════════════════╝
    
    CARA PENGGUNAAN:
    1. Buka executor Delta di Roblox
    2. Paste script loadstring:
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Acheronnnn/Avy/main/fish_it_auto.lua"))()
    3. Execute script
    4. UI akan muncul di layar, klik tombol untuk toggle auto fishing
    
    CARA KERJA:
    - Script mendeteksi fishing rod yang equipped
    - Otomatis melakukan cast (lempar kail)
    - Menunggu bite (ikan menggigit)
    - Otomatis reel in (tarik kail)
    - Loop terus menerus sampai dimatikan
    
    FITUR:
    ✓ Auto Fishing (Cast & Reel)
    ✓ UI Toggle Button
    ✓ Draggable UI
    ✓ Lightweight & Stable
    ✓ Easy to expand
--]]

-- ═══════════════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════
-- CONFIGURATION
-- ═══════════════════════════════════════════════════════════
local Config = {
    -- Auto Fishing Settings
    Enabled = false,
    CastHoldTime = 0.8,        -- Durasi hold mouse saat cast (detik)
    WaitAfterCast = 1.5,       -- Delay setelah cast sebelum cek bite (detik)
    MaxWaitForBite = 20,       -- Maksimal waktu tunggu bite (detik)
    ReelDelay = 0.5,           -- Delay setelah reel (detik)
    RetryDelay = 1,            -- Delay sebelum cast ulang (detik)
    
    -- UI Settings
    UIPosition = UDim2.new(0.5, -100, 0, 50),
    UISize = UDim2.new(0, 220, 0, 120),
}

-- ═══════════════════════════════════════════════════════════
-- VARIABLES
-- ═══════════════════════════════════════════════════════════
local AutoFishRunning = false
local CurrentRod = nil

-- ═══════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════

-- Fungsi untuk mendapatkan fishing rod yang sedang equipped
local function getFishingRod()
    local character = LocalPlayer.Character
    if not character then return nil end
    
    -- Cari tool yang namanya mengandung "rod" atau "fishing"
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") then
            local toolName = tool.Name:lower()
            if toolName:find("rod") or toolName:find("fish") then
                return tool
            end
        end
    end
    
    return nil
end

-- Fungsi untuk simulasi mouse click
local function simulateMouseClick(holdDuration)
    local viewport = workspace.CurrentCamera.ViewportSize
    local centerX = viewport.X / 2
    local centerY = viewport.Y / 2
    
    -- Mouse button down
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
    
    -- Hold jika ada durasi
    if holdDuration and holdDuration > 0 then
        task.wait(holdDuration)
    end
    
    -- Mouse button up
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
end

-- Fungsi untuk log pesan
local function log(message)
    print("[Fish It Auto] " .. message)
end

-- ═══════════════════════════════════════════════════════════
-- FISHING FUNCTIONS
-- ═══════════════════════════════════════════════════════════

-- Fungsi untuk cast (lempar kail)
local function castRod()
    log("Casting rod...")
    simulateMouseClick(Config.CastHoldTime)
    task.wait(Config.WaitAfterCast)
end

-- Fungsi untuk reel in (tarik kail)
local function reelIn()
    log("Reeling in...")
    simulateMouseClick(0.1)
    task.wait(Config.ReelDelay)
end

-- Fungsi untuk mendeteksi bite (ikan menggigit)
-- Metode: Monitoring perubahan pada rod atau timeout
local function waitForBite(rod)
    local startTime = tick()
    local biteDetected = false
    
    log("Waiting for bite...")
    
    while tick() - startTime < Config.MaxWaitForBite do
        -- Stop jika auto fishing dimatikan
        if not Config.Enabled then
            return false
        end
        
        -- Cek apakah rod masih ada
        if not rod or not rod.Parent then
            log("Rod disappeared!")
            return false
        end
        
        -- TODO: Tambahkan deteksi bite yang lebih akurat
        -- Saat ini menggunakan timeout sederhana
        -- Bisa dikembangkan dengan monitoring:
        -- - Rod animation
        -- - ProximityPrompt
        -- - GUI changes
        -- - Sound effects
        
        task.wait(0.1)
    end
    
    -- Timeout = assume bite terjadi
    log("Bite timeout reached, attempting reel...")
    return true
end

-- ═══════════════════════════════════════════════════════════
-- MAIN AUTO FISHING LOOP
-- ═══════════════════════════════════════════════════════════
local function autoFishLoop()
    AutoFishRunning = true
    log("Auto Fishing Started!")
    
    while Config.Enabled do
        -- Cek apakah rod masih equipped
        CurrentRod = getFishingRod()
        
        if not CurrentRod then
            log("No fishing rod equipped! Waiting...")
            task.wait(2)
        else
            -- Proses fishing
            castRod()
            
            if waitForBite(CurrentRod) then
                reelIn()
            end
            
            task.wait(Config.RetryDelay)
        end
    end
    
    AutoFishRunning = false
    log("Auto Fishing Stopped!")
end

-- ═══════════════════════════════════════════════════════════
-- UI CREATION
-- ═══════════════════════════════════════════════════════════

-- Hapus UI lama jika ada
if game.CoreGui:FindFirstChild("FishItAutoUI") then
    game.CoreGui:FindFirstChild("FishItAutoUI"):Destroy()
end

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FishItAutoUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = Config.UISize
MainFrame.Position = Config.UIPosition
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Shadow effect
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.ZIndex = 0
Shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

-- Title Text
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -20, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "🎣 Fish It Auto"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Status Text
local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Size = UDim2.new(1, -20, 0, 20)
StatusText.Position = UDim2.new(0, 10, 0, 45)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Status: Idle"
StatusText.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusText.TextSize = 13
StatusText.Font = Enum.Font.Gotham
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Parent = MainFrame

-- Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 180, 0, 45)
ToggleButton.Position = UDim2.new(0.5, -90, 0, 70)
ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "▶ Start Auto Fish"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 15
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.AutoButtonColor = false
ToggleButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = ToggleButton

-- ═══════════════════════════════════════════════════════════
-- UI INTERACTIONS
-- ═══════════════════════════════════════════════════════════

-- Toggle button click handler
ToggleButton.MouseButton1Click:Connect(function()
    Config.Enabled = not Config.Enabled
    
    if Config.Enabled then
        -- Start auto fishing
        ToggleButton.Text = "⏸ Stop Auto Fish"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 220, 60)
        StatusText.Text = "Status: Running..."
        StatusText.TextColor3 = Color3.fromRGB(100, 255, 100)
        
        -- Jalankan loop di thread terpisah
        task.spawn(autoFishLoop)
    else
        -- Stop auto fishing
        ToggleButton.Text = "▶ Start Auto Fish"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
        StatusText.Text = "Status: Stopped"
        StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- Button hover effect
ToggleButton.MouseEnter:Connect(function()
    ToggleButton.BackgroundColor3 = ToggleButton.BackgroundColor3:Lerp(Color3.fromRGB(255, 255, 255), 0.2)
end)

ToggleButton.MouseLeave:Connect(function()
    if Config.Enabled then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 220, 60)
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    end
end)

-- ═══════════════════════════════════════════════════════════
-- CLEANUP ON PLAYER LEAVE
-- ═══════════════════════════════════════════════════════════
LocalPlayer.CharacterRemoving:Connect(function()
    Config.Enabled = false
end)

-- ═══════════════════════════════════════════════════════════
-- INITIALIZATION COMPLETE
-- ═══════════════════════════════════════════════════════════
log("Script loaded successfully!")
log("UI created. Click the button to start auto fishing.")
log("Repository: https://github.com/Acheronnnn/Avy")
