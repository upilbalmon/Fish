
-- LocalScript untuk Button dengan Pengatur Delay
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SellItemsGui"
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleLabel.Text = "AUTO SELL SYSTEM"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleLabel

-- Delay Settings Frame
local delayFrame = Instance.new("Frame")
delayFrame.Size = UDim2.new(1, -20, 0, 80)
delayFrame.Position = UDim2.new(0, 10, 0, 50)
delayFrame.BackgroundTransparency = 1
delayFrame.Parent = mainFrame

-- Delay Input
local delayLabel = Instance.new("TextLabel")
delayLabel.Size = UDim2.new(0.5, 0, 0, 25)
delayLabel.Position = UDim2.new(0, 0, 0, 0)
delayLabel.BackgroundTransparency = 1
delayLabel.Text = "Delay (menit):"
delayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
delayLabel.TextXAlignment = Enum.TextXAlignment.Left
delayLabel.TextScaled = true
delayLabel.Font = Enum.Font.Gotham
delayLabel.Parent = delayFrame

local delayBox = Instance.new("TextBox")
delayBox.Size = UDim2.new(0.4, 0, 0, 30)
delayBox.Position = UDim2.new(0.5, 0, 0, 0)
delayBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
delayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
delayBox.Text = "5"
delayBox.PlaceholderText = "Masukkan delay"
delayBox.TextScaled = true
delayBox.Parent = delayFrame

local delayBoxCorner = Instance.new("UICorner")
delayBoxCorner.CornerRadius = UDim.new(0, 4)
delayBoxCorner.Parent = delayBox

-- Mode Selection
local modeLabel = Instance.new("TextLabel")
modeLabel.Size = UDim2.new(0.5, 0, 0, 25)
modeLabel.Position = UDim2.new(0, 0, 0, 40)
modeLabel.BackgroundTransparency = 1
modeLabel.Text = "Mode:"
modeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
modeLabel.TextXAlignment = Enum.TextXAlignment.Left
modeLabel.TextScaled = true
modeLabel.Font = Enum.Font.Gotham
modeLabel.Parent = delayFrame

local modeDropdown = Instance.new("TextButton")
modeDropdown.Size = UDim2.new(0.4, 0, 0, 30)
modeDropdown.Position = UDim2.new(0.5, 0, 0, 40)
modeDropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
modeDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
modeDropdown.Text = "Sekali Jalan"
modeDropdown.TextScaled = true
modeDropdown.Font = Enum.Font.Gotham
modeDropdown.Parent = delayFrame

local modeDropdownCorner = Instance.new("UICorner")
modeDropdownCorner.CornerRadius = UDim.new(0, 4)
modeDropdownCorner.Parent = modeDropdown

-- Mode Options
local modeOptions = {"Sekali Jalan", "Loop"}
local currentMode = 1

modeDropdown.MouseButton1Click:Connect(function()
    currentMode = currentMode + 1
    if currentMode > #modeOptions then
        currentMode = 1
    end
    modeDropdown.Text = modeOptions[currentMode]
end)

-- Buttons Frame
local buttonsFrame = Instance.new("Frame")
buttonsFrame.Size = UDim2.new(1, -20, 0, 50)
buttonsFrame.Position = UDim2.new(0, 10, 0, 140)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.Parent = mainFrame

-- Start Button
local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(0.48, 0, 1, 0)
startButton.Position = UDim2.new(0, 0, 0, 0)
startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
startButton.Text = "START"
startButton.TextScaled = true
startButton.Font = Enum.Font.GothamBold
startButton.Parent = buttonsFrame

local startCorner = Instance.new("UICorner")
startCorner.CornerRadius = UDim.new(0, 6)
startCorner.Parent = startButton

-- Stop Button
local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(0.48, 0, 1, 0)
stopButton.Position = UDim2.new(0.52, 0, 0, 0)
stopButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.Text = "STOP"
stopButton.TextScaled = true
stopButton.Font = Enum.Font.GothamBold
stopButton.Parent = buttonsFrame

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0, 6)
stopCorner.Parent = stopButton

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 100)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Ready"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

-- Variables untuk kontrol loop
local isRunning = false
local currentLoop = nil

-- Fungsi untuk menjual items
local function sellAllItems()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    
    local sellRemote = ReplicatedStorage:WaitForChild("Packages")
        :WaitForChild("_Index")
        :WaitForChild("sleitnick_net@0.2.0")
        :WaitForChild("net")
        :WaitForChild("RF/SellAllItems")
    
    local success, result = pcall(function()
        return sellRemote:InvokeServer()
    end)
    
    if success then
        statusLabel.Text = "Status: Berhasil menjual items!"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        print("Items berhasil dijual!")
    else
        statusLabel.Text = "Status: Error - " .. tostring(result)
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        warn("Error:", result)
    end
end

-- Fungsi untuk memulai sistem
local function startSystem()
    if isRunning then return end
    
    local delayMinutes = tonumber(delayBox.Text) or 5
    local delaySeconds = delayMinutes * 60
    
    if delaySeconds <= 0 then
        statusLabel.Text = "Status: Delay harus lebih dari 0!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        return
    end
    
    isRunning = true
    startButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    stopButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    
    if currentMode == 1 then -- Sekali Jalan
        statusLabel.Text = "Status: Menjalankan sekali..."
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        
        sellAllItems()
        
        -- Reset setelah selesai
        wait(2)
        isRunning = false
        startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        statusLabel.Text = "Status: Selesai!"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        
    else -- Loop Mode
        statusLabel.Text = "Status: Loop aktif - " .. delayMinutes .. " menit"
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        
        currentLoop = coroutine.create(function()
            while isRunning do
                -- Jalankan sell items
                sellAllItems()
                
                -- Tunggu untuk delay berikutnya
                for i = delaySeconds, 1, -1 do
                    if not isRunning then break end
                    local minutes = math.floor(i / 60)
                    local seconds = i % 60
                    statusLabel.Text = string.format("Status: Loop - Next: %02d:%02d", minutes, seconds)
                    wait(1)
                end
                
                if not isRunning then break end
            end
        end)
        
        coroutine.resume(currentLoop)
    end
end

-- Fungsi untuk menghentikan sistem
local function stopSystem()
    if not isRunning then return end
    
    isRunning = false
    startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    stopButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    
    if currentLoop then
        coroutine.close(currentLoop)
        currentLoop = nil
    end
    
    statusLabel.Text = "Status: Dihentikan"
    statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
end

-- Event Handlers
startButton.MouseButton1Click:Connect(startSystem)
stopButton.MouseButton1Click:Connect(stopSystem)

-- Validasi input delay
delayBox:GetPropertyChangedSignal("Text"):Connect(function()
    local text = delayBox.Text
    if text == "" then return end
    
    local num = tonumber(text)
    if not num or num < 0 then
        delayBox.Text = "5"
        statusLabel.Text = "Status: Delay harus angka positif!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- Close button (opsional)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    stopSystem()
    screenGui:Destroy()
end)

print("Auto Sell System GUI berhasil dibuat!")
