local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

local highlightTable = {}

-- Tạo hitbox (Highlight) cho nhân vật
local function createHitbox(character, player)
	if player == localPlayer then return end

	if character:FindFirstChild("HumanoidRootPart") and not highlightTable[player] then
		local highlight = Instance.new("Highlight")
		highlight.Name = "PlayerHitbox"
		highlight.FillColor = Color3.fromRGB(255, 0, 0)
		highlight.FillTransparency = 0.7
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		highlight.OutlineTransparency = 0
		highlight.Adornee = character
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = game.CoreGui

		highlightTable[player] = highlight
	end
end

-- Xóa hitbox nếu người chơi rời khỏi
local function removeHitbox(player)
	if highlightTable[player] then
		highlightTable[player]:Destroy()
		highlightTable[player] = nil
	end
end

-- Lặp qua người chơi hiện tại
for _, player in ipairs(Players:GetPlayers()) do
	if player ~= localPlayer then
		if player.Character then
			createHitbox(player.Character, player)
		end
		player.CharacterAdded:Connect(function(char)
			createHitbox(char, player)
		end)
	end
end

-- Người chơi mới vào
Players.PlayerAdded:Connect(function(player)
	if player ~= localPlayer then
		player.CharacterAdded:Connect(function(char)
			createHitbox(char, player)
		end)
	end
end)

-- Người chơi rời
Players.PlayerRemoving:Connect(removeHitbox)

-- Xóa hitbox nếu nhân vật biến mất
RunService.RenderStepped:Connect(function()
	for player, highlight in pairs(highlightTable) do
		if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
			removeHitbox(player)
		end
	end
end)
