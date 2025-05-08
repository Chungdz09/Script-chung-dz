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

Tab1:CreateButton({
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
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Chungdz09/Script-chung-dz/refs/heads/main/AimbotScriptFOV.lua"))()
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
    
local Tab2 = Window:CreateTab("🤑 Duping", nil)
local Section = Tab2:CreateSection("Start Duping items") 


local Button = Tab2:CreateButton({
    Name = "🏁Start Dupe",
    Callback = function()
        getgenv().olddata = game:GetService("ReplicatedStorage").References.Comm.Events.SetSettings
        game:GetService("ReplicatedStorage").References.Comm.Events.SetSettings:FireServer(getgenv().olddata)    
    end,
 })

local Section = Tab2:CreateSection("Armors") 

local Button = Tab2:CreateButton({
   Name = "🌋Dupe Obsidian Armor",
   Callback = function()
      local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
      local putIn = true
      local itemIDs = {225,226,227,228,235}
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
  
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(chest, putIn, itemID)
      end
 end,
})
 
 local Button = Tab2:CreateButton({
    Name = "🦴Soul Duping",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
        local putIn = true
        local itemIDs = {204, 202, 201, 203, 218, 216}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })
 
local Section = Tab2:CreateSection("Packs") 

 local Button = Tab2:CreateButton({
    Name = "📦Chest pack 25x",
    Callback = function()
      local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
      local putIn = true
      local itemIDs = {382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 
      382, 382, 382,}
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
  
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(chest, putIn, itemID)
      end
  end,
})
 
local Button = Tab2:CreateButton({
   Name = "🍭Candypack 500x 😊",
   Callback = function()
     local localChest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
     local putIn = true
     local itemIDs = {}
      
      for i = 1, 500 do
          table.insert(itemIDs, 188)
      end
      
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
      
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(localChest, putIn, itemID)
      end
 end,
})

 local Button = Tab2:CreateButton({
    Name = "🍉Fruit pack 25x",
    Callback = function()
      local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
      local putIn = true
      local itemIDs = {325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325,}
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
  
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(chest, putIn, itemID)
      end
  end,
})

 local Button = Tab2:CreateButton({
    Name = "🛡️Prot. pack 25x",
    Callback = function()
      local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
      local putIn = true
      local itemIDs = {317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317, 317,}
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
  
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(chest, putIn, itemID)
      end
  end,
})

 local Button = Tab2:CreateButton({
    Name = "🤺Warr. pack 25x",
    Callback = function()
      local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
      local putIn = true
      local itemIDs = {318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318, 318,}
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
  
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(chest, putIn, itemID)
      end
  end,
})

 local Button = Tab2:CreateButton({
    Name = "🪓Fresh pack 25x",
    Callback = function()
      local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
      local putIn = true
      local itemIDs = {111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111, 111,}
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
  
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(chest, putIn, itemID)
      end
  end,
})

 local Button = Tab2:CreateButton({
    Name = "Stone pack 25x",
    Callback = function()
      local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
      local putIn = true
      local itemIDs = {112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, 112, }
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
  
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(chest, putIn, itemID)
      end
  end,
})

local Tab3 = Window:CreateTab("😵‍💫 Crazy Dupe", nil)
local Section = Tab3:CreateSection("Gliders 🪁")


 local Button = Tab3:CreateButton({
    Name = "🪁Easter Glider🪁",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
        local putIn = true
        local itemIDs = {272}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })

 local Button = Tab3:CreateButton({
    Name = "🪁Glider🪁",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
        local putIn = true
        local itemIDs = {301}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })

local Section = Tab3:CreateSection("Others")

 local Button = Tab3:CreateButton({
    Name = "🌀Portal Book",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
        local putIn = true
        local itemIDs = {313}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })

 local Button = Tab3:CreateButton({
    Name = "🛡️Deflect Book",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
        local putIn = true
        local itemIDs = {323}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })


 local Button = Tab3:CreateButton({
    Name = "🥶Freezio Book",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
        local putIn = true
        local itemIDs = {310}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })

 local Button = Tab3:CreateButton({
    Name = "💀Oofio Book",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
        local putIn = true
        local itemIDs = {309} 
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })

 local Button = Tab3:CreateButton({
    Name = "🎃Pumpkin Shield🎃",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
        local putIn = true
        local itemIDs = {379}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })

local Tab4 = Window:CreateTab("📦Moonstone Chest input", nil)
local Section = Tab4:CreateSection("Put your items into a Moonstone Chest")

local Section = Tab4:CreateSection("Packs")

 local Button = Tab4:CreateButton({
    Name = "📦Chestpack 25x",
    Callback = function()
      local chest = game:GetService("Workspace").Replicators.NonPassive["Moonstone Storage Chest"]
      local putIn = true
      local itemIDs = {382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 
      382, 382, 382,}
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
  
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(chest, putIn, itemID)
      end
  end,
})
 
local Button = Tab4:CreateButton({
   Name = "🍭Candypack 500x",
   Callback = function()
     local localChest = game:GetService("Workspace").Replicators.NonPassive["Moonstone Storage Chest"]
     local putIn = true
     local itemIDs = {}
      
      for i = 1, 500 do
          table.insert(itemIDs, 188)
      end
      
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
      
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(localChest, putIn, itemID)
      end
 end,
})

local Button = Tab4:CreateButton({
    Name = "Fruit pack 25x",
    Callback = function()
      local chest = game:GetService("Workspace").Replicators.NonPassive["Moonstone Storage Chest"]
      local putIn = true
      local itemIDs = {325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325, 325,}
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
  
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(chest, putIn, itemID)
      end
  end,
})

local Button = Tab4:CreateButton({
   Name = "Zen Pack 500x",
   Callback = function()
     local localChest = game:GetService("Workspace").Replicators.NonPassive["Moonstone Storage Chest"]
     local putIn = true
     local itemIDs = {}
      
      for i = 1, 500 do
          table.insert(itemIDs, 327)
      end
      
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
      
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(localChest, putIn, itemID)
      end
 end,
})

local Section = Tab4:CreateSection("Glider")

 local Button = Tab4:CreateButton({
    Name = "🪁Easter Glider🪁",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Moonstone Storage Chest"]
        local putIn = true
        local itemIDs = {272}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })

 local Button = Tab4:CreateButton({
    Name = "🪁Glider🪁",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Moonstone Storage Chest"]
        local putIn = true
        local itemIDs = {301}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })

local Section = Tab4:CreateSection("Other")

 local Button = Tab4:CreateButton({
    Name = "🎃Pumpkin Shield 10x🎃",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Moonstone Storage Chest"]
        local putIn = true
        local itemIDs = {379, 379, 379, 379, 379, 379, 379, 379, 379, 379}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })

local Section = Tab4:CreateSection("Armors") 

local Button = Tab4:CreateButton({
   Name = "🌋Dupe Obsidian Armor",
   Callback = function()
      local chest = game:GetService("Workspace").Replicators.NonPassive["Moonstone Storage Chest"]
      local putIn = true
      local itemIDs = {225,226,227,228,235,293,230}
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
  
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(chest, putIn, itemID)
      end
 end,
})

local Button = Tab4:CreateButton({
    Name = "🦴Soul Duping",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Moonstone Storage Chest"]
        local putIn = true
        local itemIDs = {204, 202, 201, 203, 218, 216}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })

local Button = Tab4:CreateButton({
    Name = "Moon Duping",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Moonstone Storage Chest"]
        local putIn = true
        local itemIDs = {369, 366, 365, 364, 363, 370,199,222}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })

local Button = Tab4:CreateButton({
   Name = "Easter Candy (500)",
   Callback = function()
     local localChest = game:GetService("Workspace").Replicators.NonPassive["Moonstone Storage Chest"]
     local putIn = true
     local itemIDs = {}
      
      for i = 1, 500 do
          table.insert(itemIDs, 271)
      end
      
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
      
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(localChest, putIn, itemID)
      end
 end,
})

local Button = Tab4:CreateButton({
    Name = "Starter Pack Duping",
    Callback = function()
        local chest = game:GetService("Workspace").Replicators.NonPassive["Moonstone Storage Chest"]
        local putIn = true
        local itemIDs = {354, 355, 356, 357, 358, 359}
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
    
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })
local Tab5 = Window:CreateTab("Open Chest", nil)
local Section = Tab5:CreateSection("Open Chest")

 local Button = Tab5:CreateButton({
    Name = "Open Easy Chest",
    Callback = function()
        local chestID = 166
        local action = "Open"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

 local Button = Tab5:CreateButton({
    Name = "Open Medium Chest",
    Callback = function()
        local chestID = 167
        local action = "Open"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

 local Button = Tab5:CreateButton({
    Name = "Open Hard Chest",
    Callback = function()
        local chestID = 168
        local action = "Open"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

local Section = Tab5:CreateSection("Drop")

 local Button = Tab5:CreateButton({
    Name = "Open Hard Chest",
    Callback = function()
        local chestID = 168
        local action = "Open"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

 local Button = Tab5:CreateButton({
    Name = "Open Hard Chest",
    Callback = function()
        local chestID = 168
        local action = "Open"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

 local Button = Tab5:CreateButton({
    Name = "Open Hard Chest",
    Callback = function()
        local chestID = 168
        local action = "Open"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})
 local Button = Tab5:CreateButton({
    Name = "Leaderboard Place",
    Callback = function()
        local player = game:GetService("Players").LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local myroot = player.Character.HumanoidRootPart
            myroot.CFrame = CFrame.new(5313, 4, -5508)
        else
            warn("Player is not alive or character is not fully loaded.")
        end
    end
})

