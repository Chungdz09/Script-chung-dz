local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Danh sách các khớp xương (nối các bộ phận cơ thể)
local bones = {
	{"Head", "UpperTorso"},
	{"UpperTorso", "LowerTorso"},
	{"UpperTorso", "LeftUpperArm"},
	{"LeftUpperArm", "LeftLowerArm"},
	{"LeftLowerArm", "LeftHand"},
	{"UpperTorso", "RightUpperArm"},
	{"RightUpperArm", "RightLowerArm"},
	{"RightLowerArm", "RightHand"},
	{"LowerTorso", "LeftUpperLeg"},
	{"LeftUpperLeg", "LeftLowerLeg"},
	{"LeftLowerLeg", "LeftFoot"},
	{"LowerTorso", "RightUpperLeg"},
	{"RightUpperLeg", "RightLowerLeg"},
	{"RightLowerLeg", "RightFoot"},
}

-- Tạo table chứa tất cả các line
local skeletons = {}

-- Hàm tạo line cho người chơi
local function createSkeleton(player)
	if player == localPlayer then return end
	skeletons[player] = {}

	RunService.RenderStepped:Connect(function()
		local character = player.Character
		if not character or not character:FindFirstChild("Head") then return end
		if not character:FindFirstChild("Humanoid") or character:FindFirstChildOfClass("Humanoid").Health <= 0 then
			for _, line in pairs(skeletons[player]) do
				line.Visible = false
			end
			return
		end

		-- Cập nhật hoặc tạo lại line
		for i, pair in ipairs(bones) do
			local part0 = character:FindFirstChild(pair[1])
			local part1 = character:FindFirstChild(pair[2])

			if part0 and part1 then
				local screenPos0, onScreen0 = camera:WorldToViewportPoint(part0.Position)
				local screenPos1, onScreen1 = camera:WorldToViewportPoint(part1.Position)

				if onScreen0 and onScreen1 then
					local line = skeletons[player][i]
					if not line then
						line = Drawing.new("Line")
						line.Color = Color3.fromRGB(0, 255, 0)
						line.Thickness = 1.5
						line.Transparency = 1
						skeletons[player][i] = line
					end
					line.From = Vector2.new(screenPos0.X, screenPos0.Y)
					line.To = Vector2.new(screenPos1.X, screenPos1.Y)
					line.Visible = true
				else
					if skeletons[player][i] then
						skeletons[player][i].Visible = false
					end
				end
			end
		end
	end)
end

-- Xóa xương khi người chơi rời
local function removeSkeleton(player)
	if skeletons[player] then
		for _, line in pairs(skeletons[player]) do
			if line then line:Remove() end
		end
		skeletons[player] = nil
	end
end

-- Gán xương cho người chơi hiện tại
for _, player in pairs(Players:GetPlayers()) do
	if player ~= localPlayer then
		if player.Character then
			createSkeleton(player)
		end
		player.CharacterAdded:Connect(function()
			createSkeleton(player)
		end)
	end
end

-- Người chơi mới vào
Players.PlayerAdded:Connect(function(player)
	if player ~= localPlayer then
		player.CharacterAdded:Connect(function()
			createSkeleton(player)
		end)
	end
end)

-- Người chơi rời game
Players.PlayerRemoving:Connect(removeSkeleton)
