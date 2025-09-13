-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

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

-- KeyBox
local keyBox = Instance.new("TextBox", mainFrame)
keyBox.Size = UDim2.new(0.85, 0, 0, 32)
keyBox.Position = UDim2.new(0.075, 0, 0.4, 0)
keyBox.PlaceholderText = "Your key will appear here..."
keyBox.Text = ""
keyBox.TextSize = 14
keyBox.Font = Enum.Font.Gotham
keyBox.TextColor3 = Color3.fromRGB(30, 30, 30)
keyBox.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)

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
    setclipboard(keyBox.Text)
end)

-- Fetch Key from JSON Online
local function fetchKey()
    local success, response = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/fitra79/RbScript/refs/heads/main/tokens.json")
    end)

    if success then
        local data
        local ok, decode = pcall(function()
            data = HttpService:JSONDecode(response)
        end)
        if ok and data and data.keys and #data.keys > 0 then
            -- Ambil key pertama saja (tidak semua key)
            keyBox.Text = data.keys[1].key
        else
            keyBox.PlaceholderText = "No valid key found"
        end
    else
        keyBox.PlaceholderText = "Failed to load keys"
    end
end

-- Jalankan fetch saat script mulai
fetchKey()
