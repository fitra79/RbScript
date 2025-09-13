-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- File lokal untuk simpan key
local saveFile = "CyberFrog_Key.txt"

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
mainFrame.Size = UDim2.new(0, 300, 0, 180)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🐸 CyberFrog Key Generator"
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

-- Fungsi generate random key
local function generateRandomKey(length)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local key = ""
    for i = 1, length do
        key = key .. chars:sub(math.random(1, #chars), math.random(1, #chars))
    end
    return key
end

-- Ambil key dari file atau JSON
local function getKey()
    -- Cek dulu apakah sudah ada key di file
    local savedKey = loadKey()
    if savedKey then
        keyLabel.Text = savedKey
        return
    end

    -- Kalau belum ada, coba ambil dari JSON
    local success, response = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/fitra79/RbScript/refs/heads/main/tokens.json")
    end)

    local finalKey
    if success then
        local ok, data = pcall(function()
            return HttpService:JSONDecode(response)
        end)

        if ok and data and data.keys and #data.keys > 0 then
            finalKey = data.keys[1].key -- ambil key pertama dari JSON
        else
            finalKey = generateRandomKey(12) -- JSON kosong, generate sendiri
        end
    else
        finalKey = generateRandomKey(12) -- HTTP gagal, generate sendiri
    end

    -- Simpan ke file supaya key tetap sama di lain waktu
    saveKey(finalKey)
    keyLabel.Text = finalKey
end


getKey()