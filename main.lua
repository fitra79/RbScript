-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- File lokal untuk simpan key
local saveFile = "CyberFrog1_Key.txt"

local function saveKey(k)
    writefile(saveFile, k)
end

local function loadKey()
    if isfile(saveFile) then
        return readfile(saveFile)
    else
        return nil
    end
end

-- Fungsi generate random key (8 karakter)
local function generateRandomKey(length)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local key = ""
    for i = 1, length do
        key = key .. chars:sub(math.random(1,#chars), math.random(1,#chars))
    end
    return key
end

-- Fungsi cek key di JSON (validasi saja)
local function isKeyValid(key)
    local success, response = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/fitra79/RbScript/refs/heads/main/tokens.json")
    end)

    if success then
        local ok, data = pcall(function()
            return HttpService:JSONDecode(response)
        end)

        if ok and data and data.keys then
            for _, k in pairs(data.keys) do
                if k.key == key then
                    return true
                end
            end
        end
    end

    return false
end

-- Ambil atau buat key
local function getKey()
    local savedKey = loadKey()
    if savedKey then
        return savedKey
    else
        local newKey = generateRandomKey(8)
        saveKey(newKey)
        return newKey
    end
end

local key = getKey()

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "CyberFrogMini"
gui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Bubble effect (lingkaran transparan di belakang)
local bubble = Instance.new("Frame", mainFrame)
bubble.Size = UDim2.new(0, 60, 0, 60)
bubble.Position = UDim2.new(0.7, 0, 0.1, 0)
bubble.BackgroundColor3 = Color3.fromRGB(100,200,255)
bubble.BackgroundTransparency = 0.7
Instance.new("UICorner", bubble).CornerRadius = UDim.new(1,0)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, -60, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🐸 CyberFrog Key"
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Close
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.Text = "✕"
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(255,80,80)
closeBtn.BackgroundTransparency = 1

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Key Label (Read-only)
local keyLabel = Instance.new("TextLabel", mainFrame)
keyLabel.Size = UDim2.new(0.85, 0, 0, 32)
keyLabel.Position = UDim2.new(0.075, 0, 0.4, 0)
keyLabel.Text = key
keyLabel.TextSize = 14
keyLabel.Font = Enum.Font.Gotham
keyLabel.TextColor3 = isKeyValid(key) and Color3.fromRGB(60,180,100) or Color3.fromRGB(255,180,0)
keyLabel.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
keyLabel.TextXAlignment = Enum.TextXAlignment.Center
keyLabel.TextYAlignment = Enum.TextYAlignment.Center
Instance.new("UICorner", keyLabel).CornerRadius = UDim.new(0, 8)

-- Copy Button
local copyBtn = Instance.new("TextButton", mainFrame)
copyBtn.Size = UDim2.new(0.3, 0, 0, 32)
copyBtn.Position = UDim2.new(0.35, 0, 0.7, 0)
copyBtn.Text = "Copy"
copyBtn.TextSize = 14
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
copyBtn.BackgroundColor3 = Color3.fromRGB(60,180,100)
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0,8)

copyBtn.MouseButton1Click:Connect(function()
    setclipboard(keyLabel.Text)
end)

-- Drag fungsi
local dragging, dragInput, dragStart, startPos = false, nil, nil, nil

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
