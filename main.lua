-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- File lokal untuk simpan key
local saveFile = "CyberFrog10_Key.txt"

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

-- Title Bar
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 28)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.Text = "🐸 CyberFrog"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 15
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1

-- Close Button
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -26, 0.5, -11)
closeBtn.Text = "✖"
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

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
            mainFrame.Visible = false
            loadstring(game:HttpGet("https://raw.githubusercontent.com/fitra79/RbScript/refs/heads/main/listMenu.lua"))()
        else
            keyLabel.TextColor3 = Color3.fromRGB(255,180,0) -- oranye kalau tidak valid
        end
        return
    end

    -- Jika file belum ada → generate random key dan simpan
    local newKey = generateRandomKey(3)
    saveKey(newKey)
    keyLabel.Text = newKey
    keyLabel.TextColor3 = Color3.fromRGB(255,180,0) -- oranye karena belum tentu valid
end

-- Jalankan
getKey()
