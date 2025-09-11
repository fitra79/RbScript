-- Simple & Clean Loader UI
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "CyberFrogUI"
gui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 350, 0, 220)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Title Bar
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -70, 1, 0)
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
closeBtn.Text = "X"
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Minimize Button
local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -70, 0.5, -14)
minBtn.Text = "-"
minBtn.TextSize = 18
minBtn.Font = Enum.Font.GothamBold
minBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
minBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- Icon (untuk restore)
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

local iconStroke = Instance.new("UIStroke", iconBtn)
iconStroke.Thickness = 1.5
iconStroke.Color = Color3.fromRGB(255, 255, 255)


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


-- Feature Buttons
local feature1 = Instance.new("TextButton", mainFrame)
feature1.Size = UDim2.new(0.8, 0, 0, 36)
feature1.Position = UDim2.new(0.1, 0, 0.35, 0)
feature1.Text = "Mount Atin"
feature1.TextSize = 16
feature1.Font = Enum.Font.GothamBold
feature1.TextColor3 = Color3.fromRGB(255, 255, 255)
feature1.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
Instance.new("UICorner", feature1).CornerRadius = UDim.new(0, 8)

local feature2 = Instance.new("TextButton", mainFrame)
feature2.Size = UDim2.new(0.8, 0, 0, 36)
feature2.Position = UDim2.new(0.1, 0, 0.55, 0)
feature2.Text = "Mount Lembayana"
feature2.TextSize = 16
feature2.Font = Enum.Font.GothamBold
feature2.TextColor3 = Color3.fromRGB(255, 255, 255)
feature2.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
Instance.new("UICorner", feature2).CornerRadius = UDim.new(0, 8)

local feature3 = Instance.new("TextButton", mainFrame)
feature3.Size = UDim2.new(0.8, 0, 0, 36)
feature3.Position = UDim2.new(0.1, 0, 0.75, 0)
feature3.Text = "Mount Arunika"
feature3.TextSize = 16
feature3.Font = Enum.Font.GothamBold
feature3.TextColor3 = Color3.fromRGB(255, 255, 255)
feature3.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
Instance.new("UICorner", feature3).CornerRadius = UDim.new(0, 8)


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
