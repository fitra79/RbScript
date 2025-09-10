-- Loader Key UI

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer


local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "CyberFrog"
gui.ResetOnSpawn = false


local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 15)


local gradient = Instance.new("UIGradient", mainFrame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 130, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(123, 104, 238))
}
gradient.Rotation = 45


local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundTransparency = 1

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, 0, 1, 0)
title.Text = "CyberFrog 🐸"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1

local titleStroke = Instance.new("UIStroke", title)
titleStroke.Thickness = 1.2
titleStroke.Color = Color3.fromRGB(0, 0, 0)


local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(0, 5, 0.5, -15)
closeBtn.Text = "X"
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)


local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -35, 0.5, -15)
minBtn.Text = "-"
minBtn.TextSize = 22
minBtn.Font = Enum.Font.GothamBold
minBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
minBtn.TextColor3 = Color3.fromRGB(255,255,255)
local minCorner = Instance.new("UICorner", minBtn)
minCorner.CornerRadius = UDim.new(0, 6)


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


local submitFeature1 = Instance.new("TextButton", mainFrame)
submitFeature1.Size = UDim2.new(0.8, 0, 0, 40)
submitFeature1.Position = UDim2.new(0.1, 0, 0.30, 0)
submitFeature1.Text = "Mount Atin"
submitFeature1.TextSize = 18
submitFeature1.Font = Enum.Font.GothamBold
submitFeature1.TextColor3 = Color3.fromRGB(0, 0, 0)
submitFeature1.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
Instance.new("UICorner", submitFeature1).CornerRadius = UDim.new(0, 8)

local submitFeature2 = Instance.new("TextButton", mainFrame)
submitFeature2.Size = UDim2.new(0.8, 0, 0, 40)
submitFeature2.Position = UDim2.new(0.1, 0, 0.50, 0) -- geser ke bawah
submitFeature2.Text = "Mount Lembayana"
submitFeature2.TextSize = 18
submitFeature2.Font = Enum.Font.GothamBold
submitFeature2.TextColor3 = Color3.fromRGB(0, 0, 0)
submitFeature2.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
Instance.new("UICorner", submitFeature2).CornerRadius = UDim.new(0, 8)

local submitFeature3 = Instance.new("TextButton", mainFrame)
submitFeature3.Size = UDim2.new(0.8, 0, 0, 40)
submitFeature3.Position = UDim2.new(0.1, 0, 0.70, 0) -- lebih bawah lagi
submitFeature3.Text = "Mount Arunika"
submitFeature3.TextSize = 18
submitFeature3.Font = Enum.Font.GothamBold
submitFeature3.TextColor3 = Color3.fromRGB(0, 0, 0)
submitFeature3.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
Instance.new("UICorner", submitFeature3).CornerRadius = UDim.new(0, 8)


-- ==============================

-- ==============================

submitFeature1.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
        loadstring(game:HttpGet("https://raw.githubusercontent.com/WataXScript/WataXMountAtin/main/Loader/WataX.lua"))()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/WataXScript/WataXMountAtin/main/Loader/mainmap792.lua"))()
    end
end)