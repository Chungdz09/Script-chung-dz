local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "                                Island Tribes 🌴",
    LoadingTitle = "WSP",
    LoadingSubtitle = "Made by Chungdz credit to Friend",
    ConfigurationSaving = {
       Enabled = flase,
       FolderName = nil, 
       FileName = "Nigga 69"
    },

    KeySystem = true,
    KeySettings = {
       Title = "Island Tribes 🌴",
       Subtitle = "Made by Chung credit #Chungdz",
       Note = "this guy is gay gbaox_01",
       FileName = "0", 
       SaveKey = true,
       GrabKeyFromSite = true,
       Key = {"https://raw.githubusercontent.com/Chungdz09/Script-chung-dz/refs/heads/main/Key"}
    }
 })

 local MainTab = Window:CreateTab("🏠 Main", nil) 
 local MainSection = MainTab:CreateSection("Other Scripts")


local Button = MainTab:CreateButton({
   Name = "Ctrl + click TP",
   Callback = function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Click%20Teleport.txt"))()  
  end,
})

local Button = MainTab:CreateButton({
   Name = "Infinite yield",
   Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()  
  end,
})

local Button = MainTab:CreateButton({
   Name = "Dark Dex",
   Callback = function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
  end,
})

local Button = MainTab:CreateButton({
    Name = "Heal with Pumpkin if HP < 100 ",
    Callback = function()
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local LocalPlayer = Players.LocalPlayer
        local Event = ReplicatedStorage.References.Comm.Events.InventoryInteraction
        local itemID = 378  -- Pumpkin ID
        local action = "Eat"

        local function IsPlayerAlive()
            return LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0
        end

        task.spawn(function()
            while true do
                task.wait(0.1)
                if not IsPlayerAlive() then break end
                local hum = LocalPlayer.Character.Humanoid
                if hum.Health < 100 then
                    Event:FireServer(itemID, action)
                else
                    break -- Stop healing once HP is 65 or higher
                end
            end
        end)
    end
})

local Button = MainTab:CreateButton({
   Name = "ESP",
   Callback = function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/WRD%20ESP.txt"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Big Hitbox",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Chungdz09/Script-chung-dz/refs/heads/main/Big%20Hitbox"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "AimBot Press X On/Off",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Chungdz09/Script-chung-dz/refs/heads/main/KchungdzAimbot.lua"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "AimBotFOV Press F On/Off",
   Callback = function()
    local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
Aimbot.Load()
   end,
})

local MainSection = MainTab:CreateSection("Toggles")

local Toggle = MainTab:CreateToggle({
   Name = "Toggle Inf Jump",
   CurrentValue = false,
   Flag = "Toggle1", 
   Callback = function(Value)
   loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Infinite%20Jump.txt"))()
   end,
})
 
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolActionEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ToolAction")

local LocalPlayer = Players.LocalPlayer

local RANGE = 21
local AutoMine = false
local AutoMineThread

local function ToggleAutoMine(state)
    AutoMine = state
    if AutoMine then
        if AutoMineThread then return end
        AutoMineThread = task.spawn(function()
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
            while AutoMine do
                local mineFolder = workspace:WaitForChild("Replicators"):WaitForChild("Both")
                for _, mineObject in pairs(mineFolder:GetChildren()) do
                    if mineObject:IsA("BasePart") then
                        local dist = (mineObject.Position - HumanoidRootPart.Position).Magnitude
                        if dist < RANGE then
                            ToolActionEvent:FireServer(mineObject)
                        end
                    elseif mineObject:IsA("Model") and not mineObject:FindFirstChildWhichIsA("Humanoid") then
                        for _, child in pairs(mineObject:GetDescendants()) do
                            if child:IsA("BasePart") then
                                local dist = (child.Position - HumanoidRootPart.Position).Magnitude
                                if dist < RANGE then
                                    ToolActionEvent:FireServer(mineObject)
                                    break
                                end
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
            AutoMineThread = nil
        end)
    end
end

-- Giả sử bạn có UI tab MainTab rồi, tạo toggle thế này:
MainTab:CreateToggle({
    Name = "Mine Aura",
    CurrentValue = false,
    Flag = "AutoMineToggle",
    Callback = function(value)
        ToggleAutoMine(value)
    end,
})

local AutoAttackPlayer = false
local AutoAttackMod = false

-- Biến giữ vòng lặp cho mỗi loại
local AttackPlayerLoop
local AttackModLoop

-- Dịch vụ cần thiết
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolActionEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ToolAction")
local LocalPlayer = Players.LocalPlayer

MainTab:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Flag = "AutoAttackPlayer",
    Callback = function(Value)
        AutoAttackPlayer = Value

        if AutoAttackPlayer then
            AttackPlayerLoop = task.spawn(function()
                while AutoAttackPlayer do
                    local Character = LocalPlayer.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    if HumanoidRootPart then
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHRP = player.Character.HumanoidRootPart
                                if (targetHRP.Position - HumanoidRootPart.Position).Magnitude <= 17 then
                                    ToolActionEvent:FireServer(player.Character)
                                end
                            end
                        end
                    end
                    task.wait(0.3)
                end
            end)
        else
            if AttackPlayerLoop then
                task.cancel(AttackPlayerLoop)
            end
        end
    end,
})

MainTab:CreateToggle({
    Name = "Mod Aura",
    CurrentValue = false,
    Flag = "AutoAttackMod",
    Callback = function(Value)
        AutoAttackMod = Value

        if AutoAttackMod then
            AttackModLoop = task.spawn(function()
                while AutoAttackMod do
                    local Character = LocalPlayer.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    if HumanoidRootPart then
                        for _, npc in pairs(workspace:GetDescendants()) do
                            if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
                                local dist = (npc.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                                if dist <= 17 then
                                    ToolActionEvent:FireServer(npc)
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        else
            if AttackModLoop then
                task.cancel(AttackModLoop)
            end
        end
    end,
})

local MainSection = MainTab:CreateSection("Sliders")

local Slider = MainTab:CreateSlider({
   Name = "WalkSpeed Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderws", 
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "JumpPower Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderjp",
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
   end,
})
