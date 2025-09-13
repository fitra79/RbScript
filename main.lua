-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

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

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🐸 CyberFrog Key"
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1

-- Key Label (Read-only)
local keyLabel = Instance.new("TextLabel", mainFrame)
keyLabel.Size = UDim2.new(0.85, 0, 0, 32)
keyLabel.Position = UDim2.new(0.075, 0, 0.4, 0)
keyLabel.Text = "Loading..."
keyLabel.TextSize = 14
keyLabel.Font = Enum.Font.Gotham
keyLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
keyLabel.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
keyLabel.TextXAlignment = Enum.TextXAlignment.Center
keyLabel.TextYAlignment = Enum.TextYAlignment.Center
Instance.new("UICorner", keyLabel).CornerRadius = UDim.new(0, 8)

-- Copy Button
local copyBtn = Instance.new("TextButton", mainFrame)
copyBtn.Size = UDim2.new(0.3, 0, 0, 32)
copyBtn.Position = UDim2.new(0.35, 0, 0.7, 0)
copyBtn.Text = "Copy Key"
copyBtn.TextSize = 14
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
copyBtn.BackgroundColor3 = Color3.fromRGB(60,180,100)
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0,8)

copyBtn.MouseButton1Click:Connect(function()
    setclipboard(keyLabel.Text)
end)

-- Fungsi generate random key (12 karakter)
local function generateRandomKey(length)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local key = ""
    for i = 1, length do
        key = key .. chars:sub(math.random(1,#chars), math.random(1,#chars))
    end
    return key
end

-- Fungsi cek key di JSON
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
        keyLabel.Text = savedKey
        if isKeyValid(savedKey) then
            keyLabel.TextColor3 = Color3.fromRGB(60,180,100) -- hijau kalau valid
        else
            keyLabel.TextColor3 = Color3.fromRGB(255,180,0) -- oranye kalau tidak valid
        end
        return
    end

    -- Jika file belum ada → generate random key dan simpan
    local newKey = generateRandomKey(12)
    saveKey(newKey)
    keyLabel.Text = newKey
    keyLabel.TextColor3 = Color3.fromRGB(255,180,0) -- oranye karena belum tentu valid
end

-- Jalankan
getKey()
