local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "                                Island TribesPVP 🌴",
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

game.StarterGui:SetCore("SendNotification", {
    Title = "Script Loaded",
    Text = "PVP Script Loaded Successfully.",
    Duration = 4,
})

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
   Name = "ESP",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/ESP.lua"))()
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

local healingEnabled = false
local healTask = nil

local Button = MainTab:CreateToggle({
    Name = "Spam Pumpkin If <100HP",
    Default = false,
    Callback = function(state)
        healingEnabled = state

        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local LocalPlayer = Players.LocalPlayer
        local Event = ReplicatedStorage.References.Comm.Events.InventoryInteraction
        local itemID = 378  -- Pumpkin ID
        local action = "Eat"
        local delayTime = 0.01 -- Thời gian chờ giữa mỗi lần kiểm tra (có thể chỉnh)

        local function IsPlayerAlive()
            return LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0
        end

        -- Nếu tắt toggle thì dừng vòng lặp
        if not healingEnabled then
            healTask = nil
            return
        end

        -- Nếu chưa có vòng lặp thì tạo mới
        if not healTask then
            healTask = task.spawn(function()
                while healingEnabled do
                    task.wait(delayTime)
                    if not IsPlayerAlive() then
                        break
                    end

                    local hum = LocalPlayer.Character.Humanoid
                    if hum.Health < 100 then
                        Event:FireServer(itemID, action)
                    end
                end
            end)
        end
    end
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
                local volcanicRock = workspace:FindFirstChild("Volcanic Rock")
                if volcanicRock then
                    ToolActionEvent:FireServer(volcanicRock)
                end
                local mineFolder = workspace:FindFirstChild("Replicators") and workspace.Replicators:FindFirstChild("Both")
                if mineFolder then
                    local closestMine = nil
                    local closestDistance = RANGE

                    for _, mineObject in pairs(mineFolder:GetChildren()) do
                        if mineObject:IsA("BasePart") then
                            local dist = (mineObject.Position - HumanoidRootPart.Position).Magnitude
                            if dist < closestDistance then
                                closestMine = mineObject
                                closestDistance = dist
                            end
                        elseif mineObject:IsA("Model") and not mineObject:FindFirstChildWhichIsA("Humanoid") then
                            for _, child in pairs(mineObject:GetDescendants()) do
                                if child:IsA("BasePart") then
                                    local dist = (child.Position - HumanoidRootPart.Position).Magnitude
                                    if dist < closestDistance then
                                        closestMine = mineObject
                                        closestDistance = dist
                                        break
                                    end
                                end
                            end
                        end
                    end

                    -- Đào mỏ gần nhất
                    if closestMine then
                        ToolActionEvent:FireServer(closestMine)
                    end
                end

                task.wait(0.5) -- Chờ giữa các lần đánh
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
local AttackPlayerLoop

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
            if AttackPlayerLoop then return end
            AttackPlayerLoop = task.spawn(function()
                while AutoAttackPlayer do
                    local Character = LocalPlayer.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

                    if HumanoidRootPart then
                        local closestPlayer = nil
                        local closestDistance = 17

                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHRP = player.Character.HumanoidRootPart
                                local dist = (targetHRP.Position - HumanoidRootPart.Position).Magnitude
                                if dist <= closestDistance then
                                    closestPlayer = player.Character
                                    closestDistance = dist
                                end
                            end
                        end

                        if closestPlayer then
                            ToolActionEvent:FireServer(closestPlayer)
                        end
                    end

                    task.wait(0.05)
                end
                AttackPlayerLoop = nil
            end)
        else
            if AttackPlayerLoop then
                task.cancel(AttackPlayerLoop)
                AttackPlayerLoop = nil
            end
        end
    end,
})

-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- VARIABLES
local LocalPlayer = Players.LocalPlayer
local ToolActionEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ToolAction")

local RANGE = 17 -- phạm vi dưới 17 studs
local AutoAttackMob = false
local AutoAttackMobThread

-- TOGGLE FUNCTION
local function ToggleAutoAttackMob(state)
    AutoAttackMob = state
    if AutoAttackMob then
        if AutoAttackMobThread then return end
        AutoAttackMobThread = task.spawn(function()
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

            while AutoAttackMob do
                local mobFolder = Workspace:FindFirstChild("Replicators") and Workspace.Replicators:FindFirstChild("Both")
                if mobFolder then
                    local closestMob = nil
                    local closestDistance = RANGE

                    for _, mob in pairs(mobFolder:GetChildren()) do
                        if mob:IsA("Model") and mob:FindFirstChildWhichIsA("Humanoid") then
                            local mobHRP = mob:FindFirstChild("HumanoidRootPart") or mob:FindFirstChild("Torso")
                            if mobHRP then
                                local dist = (mobHRP.Position - HumanoidRootPart.Position).Magnitude
                                if dist < closestDistance then
                                    closestMob = mob
                                    closestDistance = dist
                                end
                            end
                        end
                    end

                    if closestMob then
                        ToolActionEvent:FireServer(closestMob)
                    end
                end

                task.wait(0.3)
            end

            AutoAttackMobThread = nil
        end)
    else
        if AutoAttackMobThread then
            task.cancel(AutoAttackMobThread)
            AutoAttackMobThread = nil
        end
    end
end

-- GUI TOGGLE BUTTON
MainTab:CreateToggle({
    Name = "Mob Aura",
    CurrentValue = false,
    Flag = "AutoAttackMobToggle",
    Callback = function(value)
        ToggleAutoAttackMob(value)
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

local AutoAttackObsidianGolem = false
local ObsidianGolemLoop
local HoverForce

-- Dịch vụ
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ToolActionEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ToolAction")

-- Toggle GUI
local Button = Tab2:CreateToggle({
    Name = "Auto Attack Obsidian Golem",
    CurrentValue = false,
    Flag = "AutoAttackObsidianGolem",
    Callback = function(Value)
        AutoAttackObsidianGolem = Value

        local Character = LocalPlayer.Character
        local MyRoot = Character and Character:FindFirstChild("HumanoidRootPart")

        if AutoAttackObsidianGolem then
            ObsidianGolemLoop = task.spawn(function()
                while AutoAttackObsidianGolem do
                    local Golem = workspace:FindFirstChild("Replicators")
                        and workspace.Replicators:FindFirstChild("NonPassive")
                        and workspace.Replicators.NonPassive:FindFirstChild("Obsidian Golem")

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
            if ObsidianGolemLoop then
                task.cancel(ObsidianGolemLoop)
            end
            -- Gỡ BodyVelocity
            if HoverForce then
                HoverForce:Destroy()
                HoverForce = nil
            end
        end
    end,
})
