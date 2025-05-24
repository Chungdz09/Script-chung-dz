local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Khởi tạo biến toàn cục _G.noclip trạng thái hiện tại
if _G.noclip == nil then
    _G.noclip = true
else
    -- Nếu chạy lại script, toggle trạng thái
    _G.noclip = not _G.noclip
end

print("Noclip is now", _G.noclip and "enabled" or "disabled")

RunService.Stepped:Connect(function()
    if _G.noclip and character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

pcall(function()
	game.StarterGui:SetCore("SendNotification", {
		Title = "NoClip",
		Text = "Loaded. Press it 1 more time to turn on/off.",
		Duration = 4,
	})
end)
