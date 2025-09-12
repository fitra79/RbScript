-- Loader Key UI

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local HttpService = game:GetService("HttpService")

-- URL server kamu
local SERVER_URL = "https://clients-hf3m249yb-mohd-fitra-wahyudis-projects.vercel.app"

-- Generate random token
local function generateToken()
    return HttpService:GenerateGUID(false) -- contoh: "abc123-xyz"
end

local function checkToken(token)
    local success, response = pcall(function()
        return game:HttpGet(SERVER_URL .. "/cek?token=" .. token)
    end)
    if success then
        return HttpService:JSONDecode(response)
    else
        warn("Gagal cek token:", response)
        return nil
    end
end

local function registerToken(token)
    local payload = HttpService:JSONEncode({ token = token })
    local success, response = pcall(function()
        return syn.request({
            Url = SERVER_URL .. "/register",
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = payload
        })
    end)
    if success and response.StatusCode == 200 then
        return HttpService:JSONDecode(response.Body)
    else
        warn("Gagal register token:", response and response.Body)
        return nil
    end
end


local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ScreenGui
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "CyberFrogMini"
gui.ResetOnSpawn = false

-- Tombol Utama
local mainBtn = Instance.new("TextButton", gui)
mainBtn.Size = UDim2.new(0, 120, 0, 40)
mainBtn.Position = UDim2.new(0.5, -60, 0.5, -20)
mainBtn.BackgroundColor3 = Color3.fromRGB(123, 104, 238)
mainBtn.Text = "CyberFrog"
mainBtn.TextSize = 18
mainBtn.Font = Enum.Font.GothamBold
mainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainBtn.AutoButtonColor = true
local corner = Instance.new("UICorner", mainBtn)
corner.CornerRadius = UDim.new(0.5, 0)

-- Optional: Dragging
local dragging = false
local dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    mainBtn.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

mainBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Fungsi utama saat tombol ditekan
local function onButtonPressed()
    -- Gunakan token otomatis (bisa generate atau load)
    local token = loadKey() or generateToken()
    saveKey(token)

    local result = checkToken(token)
    if result and result.valid then
        print("✅ Token valid, expireAt:", result.expireAt or "permanent")
        -- Jalankan script utama
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fitra79/RbScript/refs/heads/main/listMenu.lua"))()
    else
        print("⚠️ Token belum aktif atau expired, register dulu")
        local reg = registerToken(token)
        if reg then
            print("📌 Token registered, tunggu admin aktifkan:", token)
        end
    end
end

mainBtn.MouseButton1Click:Connect(onButtonPressed)

