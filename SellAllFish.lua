-- LocalScript untuk Button dengan Pengatur Delay (Versi Compact & Minimalis)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hapus GUI lama jika ada untuk menghindari duplikasi
if playerGui:FindFirstChild("SellItemsGui") then
    playerGui.SellItemsGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SellItemsGui"
screenGui.Parent = playerGui

-- Variables untuk kontrol loop (DIPINDAHKAN KE ATAS)
local isRunning = false
local currentLoop = nil

-- Fungsi untuk menghentikan sistem (DIPINDAHKAN KE ATAS)
local function stopSystem()
    if not isRunning then return end
    
    isRunning = false
    if startButton then
        startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    end
    if stopButton then
        stopButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    end
    
    if currentLoop then
        coroutine.close(currentLoop)
        currentLoop = nil
    end
    
    if statusLabel then
        statusLabel.Text = "Status: Dihentikan"
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end

-- Main Frame (Compact, Minimalis, Transparan)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 120) -- Ukuran lebih kecil
mainFrame.Position = UDim2.new(1, -210, 0, 10) -- Posisikan di kanan atas
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.7 -- Transparansi
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = mainFrame

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 20) -- Ukuran lebih kecil
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleLabel.BackgroundTransparency = 0.6 -- Transparansi
titleLabel.Text = "AUTO SELL"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = false
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 18, 0, 18)
closeButton.Position = UDim2.new(1, -20, 0, 1)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = false
closeButton.TextSize = 14
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleLabel -- Di dalam title bar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 3)
closeCorner.Parent = closeButton

-- Kontainer Utama untuk Input/Status/Tombol
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -10, 1, -25)
contentFrame.Position = UDim2.new(0, 5, 0, 25)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Delay Input (Lebih padat)
local delayLabel = Instance.new("TextLabel")
delayLabel.Size = UDim2.new(0.5, 0, 0, 20)
delayLabel.Position = UDim2.new(0, 0, 0, 0)
delayLabel.BackgroundTransparency = 1
delayLabel.Text = "Delay (menit):"
delayLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
delayLabel.TextXAlignment = Enum.TextXAlignment.Left
delayLabel.TextScaled = true
delayLabel.Font = Enum.Font.Gotham
delayLabel.Parent = contentFrame

local delayBox = Instance.new("TextBox")
delayBox.Size = UDim2.new(0.4, 0, 0, 20)
delayBox.Position = UDim2.new(0.55, 0, 0, 0)
delayBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
delayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
delayBox.Text = "5"
delayBox.PlaceholderText = "Delay"
delayBox.TextScaled = true
delayBox.Font = Enum.Font.Gotham
delayBox.Parent = contentFrame

local delayBoxCorner = Instance.new("UICorner")
delayBoxCorner.CornerRadius = UDim.new(0, 3)
delayBoxCorner.Parent = delayBox

-- Mode Selection (Lebih padat)
local modeLabel = Instance.new("TextLabel")
modeLabel.Size = UDim2.new(0.5, 0, 0, 20)
modeLabel.Position = UDim2.new(0, 0, 0, 22)
modeLabel.BackgroundTransparency = 1
modeLabel.Text = "Mode:"
modeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
modeLabel.TextXAlignment = Enum.TextXAlignment.Left
modeLabel.TextScaled = true
modeLabel.Font = Enum.Font.Gotham
modeLabel.Parent = contentFrame

local modeDropdown = Instance.new("TextButton")
modeDropdown.Size = UDim2.new(0.4, 0, 0, 20)
modeDropdown.Position = UDim2.new(0.55, 0, 0, 22)
modeDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
modeDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
modeDropdown.Text = "Sekali Jalan"
modeDropdown.TextScaled = true
modeDropdown.Font = Enum.Font.Gotham
modeDropdown.Parent = contentFrame

local modeDropdownCorner = Instance.new("UICorner")
modeDropdownCorner.CornerRadius = UDim.new(0, 3)
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

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 15)
statusLabel.Position = UDim2.new(0, 0, 0, 48)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Ready"
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = contentFrame

-- Buttons Frame (Di bagian bawah)
local buttonsFrame = Instance.new("Frame")
buttonsFrame.Size = UDim2.new(1, 0, 0, 30)
buttonsFrame.Position = UDim2.new(0, 0, 0, 70)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.Parent = contentFrame

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
startCorner.CornerRadius = UDim.new(0, 4)
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
stopCorner.CornerRadius = UDim.new(0, 4)
stopCorner.Parent = stopButton

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
        statusLabel.Text = "Status: Delay harus > 0!"
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
        statusLabel.Text = string.format("Status: Loop aktif (%g m)", delayMinutes)
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
                    statusLabel.Text = string.format("Status: Next: %02d:%02d", minutes, seconds)
                    wait(1)
                end
                
                if not isRunning then break end
            end
        end)
        
        coroutine.resume(currentLoop)
    end
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

-- Event handler untuk close button (SETELAH fungsi stopSystem didefinisikan)
closeButton.MouseButton1Click:Connect(function()
    stopSystem()
    screenGui:Destroy()
end)

print("Auto Sell System GUI (Compact) berhasil dibuat!")
