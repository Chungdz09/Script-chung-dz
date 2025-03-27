local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Configuration
local lockRange = 50 -- Maximum distance to lock onto a player
local rotationSpeed = 1 -- Speed at which the turret rotates

-- Variables
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local lockedPlayer = nil
local lockingOn = false

-- Function to find the nearest player within the lock range
local function findNearestPlayer()
    local nearestPlayer = nil
    local shortestDistance = lockRange

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end

    return nearestPlayer
end

-- Function to lock onto a player
local function lockOn()
    lockedPlayer = findNearestPlayer()
    if lockedPlayer then
        lockingOn = true
    end
end

-- Function to release the lock
local function releaseLock()
    lockedPlayer = nil
    lockingOn = false
end

-- Input detection
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton2 then
        lockOn()
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        releaseLock()
    end
end)

-- Update loop
RunService.RenderStepped:Connect(function()
    if lockingOn and lockedPlayer and lockedPlayer.Character and lockedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = lockedPlayer.Character.HumanoidRootPart.Position
        local direction = (targetPosition - camera.CFrame.Position).Unit
        local targetCFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + direction)
        camera.CFrame = camera.CFrame:Lerp(targetCFrame, rotationSpeed)
    end
end)
