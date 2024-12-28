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

local Tab1 = Window:CreateTab("🤑 Duping", nil)
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
   Name = "random",
   Callback = function()
      local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
      local putIn = true
      local itemIDs = {1}
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
  
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(chest, putIn, itemID)
      end
 end,
})
