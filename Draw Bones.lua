local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

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

-- Toggle bật/tắt ESP mỗi lần chạy lại script
_G.skeletonESPEnabled = not _G.skeletonESPEnabled
local enabled = _G.skeletonESPEnabled

-- Lưu skeletons và connection
_G.skeletons = _G.skeletons or {}
_G.skeletonESPConnection = _G.skeletonESPConnection

if _G.skeletonESPConnection then
	_G.skeletonESPConnection:Disconnect()
	_G.skeletonESPConnection = nil
end

-- Hàm xoá hết skeletons
local function clearSkeletons()
	for player, lines in pairs(_G.skeletons) do
		for _, line in pairs(lines) do
			if line then
				line:Remove()
			end
		end
	end
	_G.skeletons = {}
end

if not enabled then
	clearSkeletons()
	return
end

-- Tạo skeleton cho player
local function createSkeleton(player)
	if player == localPlayer then return end
	_G.skeletons[player] = _G.skeletons[player] or {}
end

-- Xóa skeleton khi player rời
local function removeSkeleton(player)
	if _G.skeletons[player] then
		for _, line in pairs(_G.skeletons[player]) do
			if line then line:Remove() end
		end
		_G.skeletons[player] = nil
	end
end

-- Update vị trí skeleton mỗi frame
_G.skeletonESPConnection = RunService.RenderStepped:Connect(function()
	for player, lines in pairs(_G.skeletons) do
		local character = player.Character
		if not character or not character:FindFirstChild("Head") then
			for _, line in pairs(lines) do
				line.Visible = false
			end
			continue
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then
			for _, line in pairs(lines) do
				line.Visible = false
			end
			continue
		end

		for i, pair in ipairs(bones) do
			local part0 = character:FindFirstChild(pair[1])
			local part1 = character:FindFirstChild(pair[2])
			if part0 and part1 then
				local screenPos0, onScreen0 = camera:WorldToViewportPoint(part0.Position)
				local screenPos1, onScreen1 = camera:WorldToViewportPoint(part1.Position)
				if onScreen0 and onScreen1 then
					local line = lines[i]
					if not line then
						line = Drawing.new("Line")
						line.Color = Color3.fromRGB(0, 255, 0)
						line.Thickness = 1.5
						line.Transparency = 1
						lines[i] = line
					end
					line.From = Vector2.new(screenPos0.X, screenPos0.Y)
					line.To = Vector2.new(screenPos1.X, screenPos1.Y)
					line.Visible = true
				else
					if lines[i] then
						lines[i].Visible = false
					end
				end
			end
		end
	end
end)

-- Khởi tạo skeleton cho tất cả người chơi hiện tại
for _, player in pairs(Players:GetPlayers()) do
	if player ~= localPlayer then
		createSkeleton(player)
	end
end

-- Thêm skeleton khi người chơi mới vào
Players.PlayerAdded:Connect(function(player)
	if player ~= localPlayer then
		createSkeleton(player)
	end
end)

-- Xoá skeleton khi người chơi rời
Players.PlayerRemoving:Connect(removeSkeleton)

pcall(function()
	game.StarterGui:SetCore("SendNotification", {
		Title = "Draw Bones",
		Text = "Loaded. Press it 1 more time to turn on/off.",
		Duration = 4,
	})
end)
