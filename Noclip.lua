local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local noclip = false

-- Function to toggle noclip
local function toggleNoclip()
	noclip = not noclip
	if noclip then
		print("Noclip enabled")
	else
		print("Noclip disabled")
	end
end

-- Detect key press (N key)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.N then
		toggleNoclip()
	end
end)

-- Update character collision each frame
RunService.Stepped:Connect(function()
	if noclip and character then
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)
