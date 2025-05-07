-- Configuration
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Range = 32 -- Max distance to target enemies in studs

-- Function to check if the player is alive
local function IsPlayerAlive(player)
    return player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

-- Function to find the closest player to target based on the conditions
local function GetClosestKAPlayer()
    local closestPlayer = nil
    local closestDistance = Range -- Start with max range

    -- Iterate through all players
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            -- Check if the player is alive and has a valid character
            if IsPlayerAlive(plr) and IsPlayerAlive(LocalPlayer) then
                local char = plr.Character
                local myPos = LocalPlayer.Character.HumanoidRootPart.Position
                local plrPos = char and char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.Position

                -- If there's a valid position, calculate the distance
                if plrPos then
                    local dist = (myPos - plrPos).Magnitude
                    if dist < closestDistance then
                        closestDistance = dist
                        closestPlayer = plr
                    end
                end
            end
        end
    end

    return closestPlayer
end

-- Function to execute KillAura
local function KillAura()
    while getgenv().configs.KillAura do
        task.wait(0.1) -- Small delay to prevent excessive loops

        -- Get the closest player to target
        local nearestPlayer = GetClosestKAPlayer()
        if nearestPlayer then
            -- Perform the desired action here, like damaging or attacking the player
            -- For example, you can simulate an attack or damage application on the nearest player
            print("Targeting: " .. nearestPlayer.Name)  -- Just printing the target for now
            -- Example: You can add your attack code here, for example, using a tool or applying damage
        end
    end
end

-- Start the KillAura function
KillAura()
