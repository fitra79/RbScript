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
mainFrame.Size = UDim2.new(0, 350, 0, 450)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
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
scroll.Size = UDim2.new(1, -20, 1, -100)
scroll.Position = UDim2.new(0, 10, 0, 40)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 6

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Tombol generate token sendiri
local generateBtn = Instance.new("TextButton", mainFrame)
generateBtn.Size = UDim2.new(0.9, 0, 0, 40)
generateBtn.Position = UDim2.new(0.05, 0, 0.88, 0)
generateBtn.Text = "Generate GUID & Login"
generateBtn.Font = Enum.Font.GothamBold
generateBtn.TextSize = 16
generateBtn.BackgroundColor3 = Color3.fromRGB(80, 160, 240)
generateBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", generateBtn).CornerRadius = UDim.new(0, 8)

-- Ambil token dari JSON
local url = "https://clients-hf3m249yb-mohd-fitra-wahyudis-projects.vercel.app/client-tokens"
local success, result = pcall(function()
    return game:HttpGet(url)
end)

local activeTokens = {} -- menyimpan token aktif
if success then
    local data = HttpService:JSONDecode(result) -- array objek
    for i, info in ipairs(data) do
        if info.active then
            table.insert(activeTokens, info.token)

            local keyBtn = Instance.new("TextButton", scroll)
            keyBtn.Size = UDim2.new(1, 0, 0, 30)
            keyBtn.Text = info.token
            keyBtn.Font = Enum.Font.Gotham
            keyBtn.TextSize = 14
            keyBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
            keyBtn.TextColor3 = Color3.fromRGB(255,255,255)
            Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 6)

            keyBtn.MouseButton1Click:Connect(function()
                saveKey(info.token)
                print("Key saved:", info.token)
                mainFrame.Visible = false
                -- jalankan script utama
                loadstring(game:HttpGet("https://raw.githubusercontent.com/fitra79/RbScript/refs/heads/main/listMenu.lua"))()
            end)
        end
    end

    -- Update CanvasSize scroll
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
else
    warn("Failed to get key JSON:", result)
end

-- Fungsi login dengan token
local function tryLogin(token)
    local canLogin = false
    for _, t in ipairs(activeTokens) do
        if t == token then
            canLogin = true
            break
        end
    end

    if canLogin then
        saveKey(token)
        print("Login success with token:", token)
        mainFrame.Visible = false
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fitra79/RbScript/refs/heads/main/listMenu.lua"))()
    else
        print("Token not active, sending register request...")
        -- HTTP POST ke URL register
        local postSuccess, postResult = pcall(function()
            return HttpService:PostAsync(
                "https://clients-hf3m249yb-mohd-fitra-wahyudis-projects.vercel.app/register",
                HttpService:JSONEncode({token = token}),
                Enum.HttpContentType.ApplicationJson
            )
        end)
        if postSuccess then
            print("Register request sent successfully for token:", token)
        else
            warn("Failed to send register request:", postResult)
        end
    end
end

-- Tombol generate GUID
generateBtn.MouseButton1Click:Connect(function()
    local newGUID = HttpService:GenerateGUID(false)
    print("Generated GUID:", newGUID)
    tryLogin(newGUID)
end)
