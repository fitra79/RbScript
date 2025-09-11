

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local isActive = true
local isBeton = false
local animConn


local function setup(char)
    local humanoid = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")
    local lastPos = hrp.Position

    if animConn then animConn:Disconnect() end
    animConn = RunService.RenderStepped:Connect(function(dt)
        if not hrp or not hrp.Parent then return end

        if isActive then
            local direction = (hrp.Position - lastPos)
            local dist = direction.Magnitude
            if dist > 0.01 then
                local moveVector = direction.Unit * math.clamp(dist*5,0,1)
                humanoid:Move(moveVector,false)
            else
                humanoid:Move(Vector3.zero,false)
            end
        end

        
        if isBeton then
            humanoid.Health = humanoid.MaxHealth
        end

        lastPos = hrp.Position
    end)
end

player.CharacterAdded:Connect(setup)
if player.Character then setup(player.Character) end


local function createUI()
    
end

createUI()


player.CharacterAdded:Connect(function(char)
    wait(0.5)
    if not player.PlayerGui:FindFirstChild("WataX_AnimUI") then
        createUI()
    end
end)

print("✅ WataX Anim + BETON siap, UI persistent")