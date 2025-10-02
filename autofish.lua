-- Auto Fish Sequence Script (Executor Compatible)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Hapus GUI lama jika ada untuk menghindari duplikasi
if playerGui:FindFirstChild("AutoFishGui") then
    playerGui.AutoFishGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFishGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Cari Remote Functions & Events dengan error handling
local NET_PATH = "Packages/_Index/sleitnick_net@0.2.0/net"
local netFolder = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net")

local RF_ChargeFishingRod = netFolder:WaitForChild("RF/ChargeFishingRod")
local RF_RequestFishingMinigameStarted = netFolder:WaitForChild("RF/RequestFishingMinigameStarted")
local RE_FishingCompleted = netFolder:WaitForChild("RE/FishingCompleted")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 140) -- Diperbesar untuk menampung info tambahan
mainFrame.Position = UDim2.new(1, -230, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.7 
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = mainFrame

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 20)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleLabel.BackgroundTransparency = 0.6
titleLabel.Text = "AUTO FISH SEQUENCE"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -10, 1, -25)
contentFrame.Position = UDim2.new(0, 5, 0, 5)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Delay 2 Input
local delay2Label = Instance.new("TextLabel")
delay2Label.Size = UDim2.new(0.5, 0, 0, 20)
delay2Label.Position = UDim2.new(0, 0, 0, 22)
delay2Label.BackgroundTransparency = 1
delay2Label.Text = "Delay 2 (R->F):"
delay2Label.TextColor3 = Color3.fromRGB(200, 200, 200)
delay2Label.TextXAlignment = Enum.TextXAlignment.Left
delay2Label.TextSize = 12
delay2Label.Font = Enum.Font.Gotham
delay2Label.Parent = contentFrame

local delay2Box = Instance.new("TextBox")
delay2Box.Size = UDim2.new(0.4, 0, 0, 20)
delay2Box.Position = UDim2.new(0.55, 0, 0, 22)
delay2Box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
delay2Box.TextColor3 = Color3.fromRGB(255, 255, 255)
delay2Box.Text = "1"
delay2Box.PlaceholderText = "Detik"
delay2Box.TextSize = 12
delay2Box.Font = Enum.Font.Gotham
delay2Box.Parent = contentFrame

local delay2Corner = Instance.new("UICorner")
delay2Corner.CornerRadius = UDim.new(0, 3)
delay2Corner.Parent = delay2Box

-- Counter & Timer Info
local loopCounterLabel = Instance.new("TextLabel")
loopCounterLabel.Size = UDim2.new(0.6, 0, 0, 15)
loopCounterLabel.Position = UDim2.new(0, 0, 0, 45)
loopCounterLabel.BackgroundTransparency = 1
loopCounterLabel.Text = "Loop Counter: 0"
loopCounterLabel.TextColor3 = Color3.fromRGB(180, 180, 255)
loopCounterLabel.TextXAlignment = Enum.TextXAlignment.Left
loopCounterLabel.TextSize = 11
loopCounterLabel.Font = Enum.Font.Gotham
loopCounterLabel.Parent = contentFrame

local durationLabel = Instance.new("TextLabel")
durationLabel.Size = UDim2.new(0.4, 0, 0, 15)
durationLabel.Position = UDim2.new(0.6, 0, 0, 45)
durationLabel.BackgroundTransparency = 1
durationLabel.Text = "Duration: 0s"
durationLabel.TextColor3 = Color3.fromRGB(180, 255, 180)
durationLabel.TextXAlignment = Enum.TextXAlignment.Right
durationLabel.TextSize = 11
durationLabel.Font = Enum.Font.Gotham
durationLabel.Parent = contentFrame

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 15)
statusLabel.Position = UDim2.new(0, 0, 0, 62)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Ready"
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = contentFrame

-- Toggle Button (Start/Stop)
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(1, 0, 0, 30)
toggleButton.Position = UDim2.new(0, 0, 0, 85)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "START"
toggleButton.TextSize = 14
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = contentFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 4)
toggleCorner.Parent = toggleButton

-- Variabel kontrol
local isRunning = false
local currentSequence = nil
local loopCounter = 0
local startTime = 0

-- Fungsi untuk format waktu
local function formatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    
    if hours > 0 then
        return string.format("%02d:%02d:%02d", hours, minutes, secs)
    else
        return string.format("%02d:%02d", minutes, secs)
    end
end

-- Fungsi untuk update timer
local function updateTimer()
    while isRunning do
        local elapsed = os.time() - startTime
        durationLabel.Text = "Duration: " .. formatTime(elapsed)
        wait(1)
    end
end

-- Fungsi untuk menjalankan sequence
local function startFishingSequence()
    if isRunning then 
        statusLabel.Text = "Status: Already Running!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        return 
    end
    
    isRunning = true
    toggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    toggleButton.Text = "STOP"

    -- Reset counter dan timer
    loopCounter = 0
    startTime = os.time()
    loopCounterLabel.Text = "Loop Counter: 0"
    durationLabel.Text = "Duration: 0s"
    
    -- Mulai timer thread
    spawn(updateTimer)

    -- Delay 1 permanen 0.1 detik
    local delay1 = 0.1
    local delay2 = tonumber(delay2Box.Text) or 1

    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    -- Jalankan sequence dalam thread terpisah
    spawn(function()
        while isRunning do
            -- === TAHAP 1: CHARGE ===
            if not isRunning then break end
            statusLabel.Text = "Status: 1. Charging..."
            
            local success, result = pcall(function()
                return RF_ChargeFishingRod:InvokeServer(tick())
            end)
            
            if not success then
                statusLabel.Text = "Status: ❌ Charge Failed!"
                statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                warn("Charge Error:", result)
                break
            end
            
            print("✅ Charge event success")
            
            -- Tunggu Delay 1 (Permanen 0.1 detik)
            if not isRunning then break end
            statusLabel.Text = "Status: Wait D1 - 0.1s"
            wait(0.1)
            if not isRunning then break end

            -- === TAHAP 2: REQUEST MINIGAME ===
            statusLabel.Text = "Status: 2. Requesting Minigame..."
            
            local success, result = pcall(function()
                return RF_RequestFishingMinigameStarted:InvokeServer(12.75006103515625, 1)
            end)

            if not success then
                statusLabel.Text = "Status: ❌ Request Failed!"
                statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                warn("Request Error:", result)
                break
            end
            
            print("✅ Request Minigame success")
            
            -- Tunggu Delay 2
            if not isRunning then break end
            local waitTime = 0
            while waitTime < delay2 and isRunning do
                statusLabel.Text = string.format("Status: Wait D2 - %.1fs", delay2 - waitTime)
                wait(0.1)
                waitTime = waitTime + 0.1
            end
            if not isRunning then break end

            -- === TAHAP 3: FINISH ===
            statusLabel.Text = "Status: 3. Finishing..."
            
            local success, result = pcall(function()
                RE_FishingCompleted:FireServer()
            end)
            
            if not success then
                statusLabel.Text = "Status: ❌ Finish Failed!"
                statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                warn("Finish Error:", result)
            else
                -- Update counter setelah berhasil
                loopCounter = loopCounter + 1
                loopCounterLabel.Text = "Loop Counter: " .. loopCounter
                
                statusLabel.Text = "Status: ✅ Sequence Complete!"
                statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                print("✅ Finish event fired - Loop: " .. loopCounter)
            end

            -- Tunggu sebentar sebelum restart
            if isRunning then
                wait(1)
                statusLabel.Text = "Status: Restarting..."
                statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                wait(1)
            end
        end
        
        -- Reset state
        isRunning = false
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        toggleButton.Text = "START"
        if not string.find(statusLabel.Text, "Stopped") then
            statusLabel.Text = "Status: Ready"
            statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        end
    end)
end

-- Fungsi untuk menghentikan sistem
local function stopSystem()
    if not isRunning then return end
    
    isRunning = false
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    toggleButton.Text = "START"
    
    statusLabel.Text = "Status: Stopped by User"
    statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    
    -- Tampilkan statistik akhir
    local totalDuration = os.time() - startTime
    print("🎣 Auto Fish Session Ended!")
    print("📊 Total Loops: " .. loopCounter)
    print("⏱️  Total Duration: " .. formatTime(totalDuration))
    
    if loopCounter > 0 and totalDuration > 0 then
        local loopsPerMinute = math.floor((loopCounter / totalDuration) * 60)
        print("📈 Average Speed: " .. loopsPerMinute .. " loops/minute")
    end
end

-- Toggle function untuk satu tombol
local function toggleSequence()
    if isRunning then
        stopSystem()
    else
        startFishingSequence()
    end
end

-- Event Handler untuk tombol toggle
toggleButton.MouseButton1Click:Connect(toggleSequence)

-- Tombol Close
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 18, 0, 18)
closeButton.Position = UDim2.new(1, -20, 0, 1)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 12
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleLabel

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 3)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    stopSystem()
    screenGui:Destroy()
end)

-- Fungsi untuk clear textbox ketika diklik
delay2Box.MouseButton1Click:Connect(function()
    delay2Box.Text = ""
end)

-- Validasi input untuk delay 2
delay2Box:GetPropertyChangedSignal("Text"):Connect(function()
    local num = tonumber(delay2Box.Text)
    if not num or num <= 0 then
        delay2Box.Text = "1"
    end
end)

print("🎣 Auto Fish Sequence GUI Ready!")
print("📍 Position: Top Right")
print("⚡ Executor Compatible")
print("⏱️  Delay 1: Fixed 0.1s | Delay 2: Default 1s")
print("🔘 Single Toggle Button: Start/Stop")
print("📊 Added: Loop Counter & Duration Timer")
