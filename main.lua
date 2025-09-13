local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local saveFile = "CyberFrog_Key.txt"

-- Fungsi simpan dan load key
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

-- GUI sederhana untuk menampilkan key
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "CyberFrogMini"
gui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🐸 CyberFrog Key List"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- ScrollFrame untuk key
local scroll = Instance.new("ScrollingFrame", mainFrame)
scroll.Size = UDim2.new(1, -20, 1, -50)
scroll.Position = UDim2.new(0, 10, 0, 40)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 6

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Ambil key dari JSON
local url = "https://raw.githubusercontent.com/fitra79/RbScript/refs/heads/main/tokens.json"
local success, result = pcall(function()
    return game:HttpGet(url)
end)

if success then
    local data = HttpService:JSONDecode(result)
    -- data diasumsikan berbentuk { "keys": [{"key":"xxx","duration":3600}, ...] }
    local keys = data.keys or {}
    
    for i, info in ipairs(keys) do
        local keyBtn = Instance.new("TextButton", scroll)
        keyBtn.Size = UDim2.new(1, 0, 0, 30)
        keyBtn.Text = info.key
        keyBtn.Font = Enum.Font.Gotham
        keyBtn.TextSize = 14
        keyBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
        keyBtn.TextColor3 = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 6)

        keyBtn.MouseButton1Click:Connect(function()
            saveKey(info.key)
            print("Key saved:", info.key)
            mainFrame.Visible = false
            -- jalankan script utama
            loadstring(game:HttpGet("https://raw.githubusercontent.com/fitra79/RbScript/refs/heads/main/listMenu.lua"))()
        end)
    end

    -- Update CanvasSize scroll
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
else
    warn("Failed to get key JSON:", result)
end
