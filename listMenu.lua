-- Loader Key Modern UI
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "CyberFrogUI"
gui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 360, 0, 220)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.05
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 18)

-- Drop Shadow
local shadow = Instance.new("ImageLabel", mainFrame)
shadow.ZIndex = -1
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)

-- Title Bar
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundTransparency = 0.3
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 18)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "🐸 CyberFrog Loader"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1

-- Close Button
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -35, 0.5, -14)
closeBtn.Text = "✖"
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 70, 70)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Minimize Button
local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -70, 0.5, -14)
minBtn.Text = "–"
minBtn.TextSize = 20
minBtn.Font = Enum.Font.GothamBold
minBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
minBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- Icon (muncul saat minimize)
local iconBtn = Instance.new("TextButton", gui)
iconBtn.Size = UDim2.new(0, 100, 0, 40)
iconBtn.Position = UDim2.new(1, -120, 1, -80)
iconBtn.BackgroundColor3 = Color3.fromRGB(123, 104, 238)
iconBtn.Text = "🐸 CyberFrog"
iconBtn.TextSize = 16
iconBtn.Font = Enum.Font.GothamBold
iconBtn.TextColor3 = Color3.fromRGB(255,255,255)
iconBtn.Visible = false
Instance.new("UICorner", iconBtn).CornerRadius = UDim.new(0.5, 0)


local dragging = false
local dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    iconBtn.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end
iconBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = iconBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
iconBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)


minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    iconBtn.Visible = true
end)
iconBtn.MouseButton1Click:Connect(function()
    iconBtn.Visible = false
    mainFrame.Visible = true
end)

---- End Icon


-- Function: Modern Button
local function createButton(text, yPos)
    local btn = Instance.new("TextButton", mainFrame)
    btn.Size = UDim2.new(0.8, 0, 0, 38)
    btn.Position = UDim2.new(0.1, 0, yPos, 0)
    btn.Text = text
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(60, 90, 160)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    -- Hover effect
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 120, 200)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 90, 160)}):Play()
    end)

    return btn
end

-- Feature Buttons
local feature1 = createButton("Mount Atin", 0.35)
local feature2 = createButton("Mount Lembayana", 0.55)
local feature3 = createButton("Mount Arunika", 0.75)


local function runLoader(urls)
    mainFrame.Visible = false
    for _, url in ipairs(urls) do
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Gagal load:", url)
        end
    end
end

-- Tombol: Mount Atin
submitFeature1.MouseButton1Click:Connect(function()
    runLoader({
        "https://raw.githubusercontent.com/fitra79/RbScript/refs/heads/main/maps/atin.lua"
    })
end)

-- Tombol: Mount Lembayana
submitFeature2.MouseButton1Click:Connect(function()
    runLoader({
        "https://raw.githubusercontent.com/WataXScript/WataXMountLembayana/main/Loader/mainmap993.lua"
    })
end)

-- Tombol: Mount Arunika
submitFeature3.MouseButton1Click:Connect(function()
    runLoader({
        "https://raw.githubusercontent.com/WataXScript/WataXMountArunika/main/Loader/WataX.lua",
        "https://raw.githubusercontent.com/WataXScript/WataXMountArunika/main/Loader/mainmap991.lua"
    })
end)
