-- Loader Key UI

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer


local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "CyberFrog"
gui.ResetOnSpawn = false


-- Main Frame
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 350, 0, 220)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Gradient
local gradient = Instance.new("UIGradient", mainFrame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(72, 61, 139)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(123, 104, 238))
}
gradient.Rotation = 45

-- Title Bar
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 28)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
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

-- Minimize Button
local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 22, 0, 22)
minBtn.Position = UDim2.new(1, -52, 0.5, -11)
minBtn.Text = "–"
minBtn.TextSize = 18
minBtn.Font = Enum.Font.GothamBold
minBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
minBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

--- Start Icon
local iconBtn = Instance.new("TextButton", gui)
iconBtn.Size = UDim2.new(0, 90, 0, 40)
iconBtn.Position = UDim2.new(1, -110, 1, -80)
iconBtn.BackgroundColor3 = Color3.fromRGB(123, 104, 238)
iconBtn.Text = "CyberFrog"
iconBtn.TextSize = 18
iconBtn.TextColor3 = Color3.fromRGB(255,255,255)
iconBtn.Font = Enum.Font.GothamBold
iconBtn.Visible = false
local iconCorner = Instance.new("UICorner", iconBtn)
iconCorner.CornerRadius = UDim.new(0.5, 0)

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


local submitFeature1 = Instance.new("TextButton", mainFrame)
submitFeature1.Size = UDim2.new(0.8, 0, 0, 36)
submitFeature1.Position = UDim2.new(0.1, 0, 0.35, 0)
submitFeature1.Text = "Mount Atin"
submitFeature1.TextSize = 18
submitFeature1.Font = Enum.Font.GothamBold
submitFeature1.TextColor3 = Color3.fromRGB(0, 0, 0)
submitFeature1.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
Instance.new("UICorner", submitFeature1).CornerRadius = UDim.new(0, 8)

local submitFeature2 = Instance.new("TextButton", mainFrame)
submitFeature2.Size = UDim2.new(0.8, 0, 0, 36)
submitFeature2.Position = UDim2.new(0.1, 0, 0.50, 0) -- geser ke bawah
submitFeature2.Text = "Mount Lembayana"
submitFeature2.TextSize = 18
submitFeature2.Font = Enum.Font.GothamBold
submitFeature2.TextColor3 = Color3.fromRGB(0, 0, 0)
submitFeature2.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
Instance.new("UICorner", submitFeature2).CornerRadius = UDim.new(0, 8)

local submitFeature3 = Instance.new("TextButton", mainFrame)
submitFeature3.Size = UDim2.new(0.8, 0, 0, 36)
submitFeature3.Position = UDim2.new(0.1, 0, 0.70, 0) -- lebih bawah lagi
submitFeature3.Text = "Mount Arunika"
submitFeature3.TextSize = 18
submitFeature3.Font = Enum.Font.GothamBold
submitFeature3.TextColor3 = Color3.fromRGB(0, 0, 0)
submitFeature3.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
Instance.new("UICorner", submitFeature3).CornerRadius = UDim.new(0, 8)


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
