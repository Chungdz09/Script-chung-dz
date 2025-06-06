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
   Name = "Draw Player",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/Draw%20Player"))()
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

local AutoAttackPlayer = false
local AttackPlayerLoop
local TargetPlayerName = ""
local HoverForce

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolActionEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ToolAction")
local LocalPlayer = Players.LocalPlayer

-- Input nhập tên người chơi mục tiêu
MainTab:CreateInput({
    Name = "Target Player Name",
    CurrentValue = "",
    PlaceholderText = "Input Player Name",
    RemoveTextAfterFocusLost = false,
    Flag = "TargetPlayerNameInput",
    Callback = function(Text)
        TargetPlayerName = Text
    end,
})

-- Toggle bật/tắt Kill Aura + bay bằng BodyVelocity
MainTab:CreateToggle({
    Name = "Auto Kill Player Target",
    CurrentValue = false,
    Flag = "AutoAttackPlayer",
    Callback = function(Value)
        AutoAttackPlayer = Value

        if AutoAttackPlayer then
            if AttackPlayerLoop then return end

            AttackPlayerLoop = task.spawn(function()
                while AutoAttackPlayer do
                    local Character = LocalPlayer.Character
                    local MyRoot = Character and Character:FindFirstChild("HumanoidRootPart")

                    if MyRoot and TargetPlayerName ~= "" then
                        local targetPlayer = Players:FindFirstChild(TargetPlayerName)

                        if targetPlayer and targetPlayer ~= LocalPlayer then
                            local TargetChar = targetPlayer.Character
                            local TargetHRP = TargetChar and TargetChar:FindFirstChild("HumanoidRootPart")
                            local Humanoid = TargetChar and TargetChar:FindFirstChild("Humanoid")

                            if TargetHRP and Humanoid and Humanoid.Health > 0 then
                                -- Gắn BodyVelocity để bay
                                if not HoverForce then
                                    HoverForce = Instance.new("BodyVelocity")
                                    HoverForce.Name = "AntiGravity"
                                    HoverForce.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                                    HoverForce.Velocity = Vector3.zero
                                    HoverForce.Parent = MyRoot
                                end

                                -- Tính vị trí bay phía trên đầu mục tiêu
                                local targetPos = TargetHRP.Position + Vector3.new(0, 15, 0)
                                local direction = (targetPos - MyRoot.Position) * 5
                                HoverForce.Velocity = direction

                                -- Tấn công
                                ToolActionEvent:FireServer(TargetChar)
                            end
                        end
                    end

                    task.wait(0.3)
                end

                AttackPlayerLoop = nil
            end)
        else
            -- Tắt vòng lặp và gỡ BodyVelocity để ngưng bay
            if AttackPlayerLoop then
                task.cancel(AttackPlayerLoop)
                AttackPlayerLoop = nil
            end

            if HoverForce then
                HoverForce:Destroy()
                HoverForce = nil
            end
        end
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
                -- Tự động đánh Volcanic Rock
                local volcanicRock = workspace:FindFirstChild("Volcanic Rock")
                if volcanicRock then
                    ToolActionEvent:FireServer(volcanicRock)
                end

                -- Quét xung quanh và tự đào mỏ trong phạm vi
                local mineFolder = workspace:FindFirstChild("Replicators") and workspace.Replicators:FindFirstChild("Both")
                if mineFolder then
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
                end

                task.wait(0.5)
            end
            AutoMineThread = nil
        end)
    end
end

-- Tạo nút bật/tắt
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

-- Biến toàn cục để bật/tắt auto pickup
local autoPickupEnabled = false

-- Hàm bật/tắt được gọi từ toggle GUI
local function ToggleAutoPickup(value)
    autoPickupEnabled = value
end

-- Tạo toggle GUI (giả sử bạn có biến MainTab, thay thế theo thư viện bạn dùng)
MainTab:CreateToggle({
    Name = "Auto Pickup",
    CurrentValue = false,
    Flag = "AutoPickupToggle",
    Callback = function(value)
        ToggleAutoPickup(value)
    end,
})

-- Các dịch vụ cần thiết
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local itemEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ItemInteracted")
local pickupRadius = 18.5

-- Lấy vị trí nhân vật
local function getCharacterRoot()
    local character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("HumanoidRootPart")
end

-- Lấy vị trí gần đúng của model (dùng part đầu tiên tìm thấy)
local function getModelPosition(model)
    for _, part in pairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            return part.Position
        end
    end
    return nil
end

-- Hàm tự động nhặt đồ
local function autoPickup()
    local rootPart = getCharacterRoot()
    for _, itemModel in ipairs(workspace:GetDescendants()) do
        if itemModel:IsA("Model") and itemModel:FindFirstChildWhichIsA("BasePart") then
            local pos = getModelPosition(itemModel)
            if pos and (pos - rootPart.Position).Magnitude <= pickupRadius then
                itemEvent:FireServer(itemModel, "Pickup")
            end
        end
    end
end

-- Vòng lặp chạy nền kiểm tra toggle và tự nhặt đồ
task.spawn(function()
    while true do
        if autoPickupEnabled then
            pcall(autoPickup)  -- pcall để tránh lỗi dừng script
        end
        task.wait(0.5) -- chờ 1 giây trước khi quét lại
    end
end)

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

local Tab2 = Window:CreateTab("Farming", nil)
local Section = Tab2:CreateSection("Auto Farm") 

-- Biến điều khiển
local AutoAttackMushroomSpirit = false
local MushroomSpiritLoop

-- Dịch vụ
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ToolActionEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ToolAction")

-- Toggle GUI
local Button = Tab2:CreateToggle({
    Name = "Auto Attack Mushroom Spirit",
    CurrentValue = false,
    Flag = "AutoAttackMushroomSpirit",
    Callback = function(Value)
        AutoAttackMushroomSpirit = Value

        if AutoAttackMushroomSpirit then
            MushroomSpiritLoop = task.spawn(function()
                while AutoAttackMushroomSpirit do
                    local Spirit = workspace:FindFirstChild("Replicators")
                        and workspace.Replicators:FindFirstChild("NonPassive")
                        and workspace.Replicators.NonPassive:FindFirstChild("Mushroom Spirit")

                    local Character = LocalPlayer.Character
                    local MyRoot = Character and Character:FindFirstChild("HumanoidRootPart")

                    if Spirit and Spirit:FindFirstChild("Humanoid")
                        and Spirit:FindFirstChild("HumanoidRootPart")
                        and Spirit.Humanoid.Health > 0 and MyRoot then

                        -- Bay lên đầu Mushroom Spirit
                        local targetPos = Spirit.HumanoidRootPart.Position + Vector3.new(0, 12, 0)
                        local targetCFrame = CFrame.new(targetPos)

                        TweenService:Create(MyRoot, TweenInfo.new(0.02, Enum.EasingStyle.Linear), {
                            CFrame = targetCFrame
                        }):Play()

                        -- Tấn công
                        ToolActionEvent:FireServer(Spirit)
                    end

                    task.wait(0.5)
                end
            end)
        else
            if MushroomSpiritLoop then
                task.cancel(MushroomSpiritLoop)
                MushroomSpiritLoop = nil
            end
        end
    end,
})

-- Biến điều khiển
local AutoAttackLuckySlime = false
local LuckySlimeLoop

-- Dịch vụ
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ToolActionEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ToolAction")

-- Toggle GUI
local Button = Tab2:CreateToggle({
    Name = "Auto Attack Lucky Slime",
    CurrentValue = false,
    Flag = "AutoAttackLuckySlime",
    Callback = function(Value)
        AutoAttackLuckySlime = Value

        if AutoAttackLuckySlime then
            LuckySlimeLoop = task.spawn(function()
                while AutoAttackLuckySlime do
                    local Slime = workspace:FindFirstChild("Replicators")
                        and workspace.Replicators:FindFirstChild("Both")
                        and workspace.Replicators.Both:FindFirstChild("Lucky Slime")

                    local Character = LocalPlayer.Character
                    local MyRoot = Character and Character:FindFirstChild("HumanoidRootPart")

                    if Slime and Slime:FindFirstChild("Humanoid") and Slime:FindFirstChild("HumanoidRootPart")
                        and Slime.Humanoid.Health > 0 and MyRoot then

                        -- Bay lên đầu Slime
                        local targetPos = Slime.HumanoidRootPart.Position + Vector3.new(0, 15, 0)
                        local targetCFrame = CFrame.new(targetPos)

                        TweenService:Create(MyRoot, TweenInfo.new(0.01, Enum.EasingStyle.Linear), {
                            CFrame = targetCFrame
                        }):Play()

                        -- Tấn công
                        ToolActionEvent:FireServer(Slime)
                    end

                    task.wait(0.5)
                end
            end)
        else
            if LuckySlimeLoop then
                task.cancel(LuckySlimeLoop)
                LuckySlimeLoop = nil
            end
        end
    end,
})

-- Biến điều khiển
local AutoAttackZenyteGolem = false
local ZenyteGolemLoop
local HoverForce -- để lưu BodyVelocity khi bay

-- Dịch vụ
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ToolActionEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ToolAction")

-- Toggle GUI
local Button = Tab2:CreateToggle({
    Name = "Auto Attack Zenyte Golem",
    CurrentValue = false,
    Flag = "AutoAttackZenyteGolem",
    Callback = function(Value)
        AutoAttackZenyteGolem = Value

        local Character = LocalPlayer.Character
        local MyRoot = Character and Character:FindFirstChild("HumanoidRootPart")

        if AutoAttackZenyteGolem then
            ZenyteGolemLoop = task.spawn(function()
                while AutoAttackZenyteGolem do
                    local Golem = workspace:FindFirstChild("Replicators")
                        and workspace.Replicators:FindFirstChild("NonPassive")
                        and workspace.Replicators.NonPassive:FindFirstChild("Zenyte Golem")

                    Character = LocalPlayer.Character
                    MyRoot = Character and Character:FindFirstChild("HumanoidRootPart")

                    if Golem and Golem:FindFirstChild("Humanoid") and Golem:FindFirstChild("HumanoidRootPart")
                        and Golem.Humanoid.Health > 0 and MyRoot then

                        -- Tạo BodyVelocity để giữ nhân vật bay
                        if not HoverForce then
                            HoverForce = Instance.new("BodyVelocity")
                            HoverForce.Velocity = Vector3.new(0, 0, 0)
                            HoverForce.MaxForce = Vector3.new(0, 1e5, 0)
                            HoverForce.Name = "AntiGravity"
                            HoverForce.Parent = MyRoot
                        end

                        -- Bay lên đầu Golem
                        local targetPos = Golem.HumanoidRootPart.Position + Vector3.new(0, 15, 0)
                        local targetCFrame = CFrame.new(targetPos)

                        TweenService:Create(MyRoot, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                            CFrame = targetCFrame
                        }):Play()

                        -- Tấn công
                        ToolActionEvent:FireServer(Golem)
                    end

                    task.wait(0.5)
                end
            end)
        else
            if ZenyteGolemLoop then
                task.cancel(ZenyteGolemLoop)
            end
            -- Gỡ BodyVelocity để ngưng bay
            if HoverForce then
                HoverForce:Destroy()
                HoverForce = nil
            end
        end
    end,
})
