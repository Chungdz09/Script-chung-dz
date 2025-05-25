local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

-- Cấu hình
local lockRange = 10000 -- Khoảng cách tối đa để nhắm
local rotationSpeed = 25 -- Tốc độ xoay camera
local toggleKey = Enum.KeyCode.X -- Phím bật/tắt lock
local updateInterval = 0.5 -- Khoảng thời gian tìm mục tiêu mới
local maxSpeed = 50 -- Tốc độ tối đa cho phép của mục tiêu (studs/s)
local standStillTimeLimit = 2 -- Thời gian đứng im tối đa (giây)
local offsetDistance = 3.5 -- Khoảng cách dịch chuyển ra phía sau mục tiêu
local minHeight = 5 -- Chiều cao tối thiểu của mục tiêu để dịch chuyển

-- Biến
local localPlayer = Players.LocalPlayer
local lockedPlayer = nil
local lockEnabled = false
local lastUpdate = 0
local previousTargetPosition = nil
local standStillTimer = 0

-- Kiểm tra đồng đội
local function isEnemy(player)
	return player.Team ~= localPlayer.Team
end

-- Tìm người chơi địch gần nhất (ngoại trừ đồng đội, dưới minHeight bỏ qua)
local function findNearestEnemy()
	local nearestPlayer = nil
	local shortestDistance = lockRange

	if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
		return nil
	end

	local myPos = localPlayer.Character.HumanoidRootPart.Position

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer
			and player.Character
			and player.Character:FindFirstChild("HumanoidRootPart")
			and isEnemy(player)
		then
			local targetPos = player.Character.HumanoidRootPart.Position
			if targetPos.Y >= minHeight then
				local dist = (targetPos - myPos).Magnitude
				if dist < shortestDistance then
					shortestDistance = dist
					nearestPlayer = player
				end
			end
		end
	end

	return nearestPlayer
end

-- Kiểm tra mục tiêu còn sống, không di chuyển quá nhanh, không đứng im lâu, không quá thấp
local function isValidTarget(target, deltaTime)
	if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
		return false
	end

	local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return false
	end

	local rootPart = target.Character.HumanoidRootPart
	local currentPos = rootPart.Position

	if currentPos.Y < minHeight then
		return false
	end

	if previousTargetPosition then
		local movement = (currentPos - previousTargetPosition).Magnitude
		local speed = movement / deltaTime

		if speed > maxSpeed then
			print("Target too fast, releasing lock.")
			return false
		end

		if movement < 0.1 then
			standStillTimer = standStillTimer + deltaTime
			if standStillTimer >= standStillTimeLimit then
				print("Target stood still too long, releasing lock.")
				return false
			end
		else
			standStillTimer = 0
		end
	else
		standStillTimer = 0
	end

	previousTargetPosition = currentPos
	return true
end

-- Dịch chuyển ra phía sau mục tiêu
local function teleportBehindTarget(targetPlayer)
	if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then return end

	local targetRoot = targetPlayer.Character.HumanoidRootPart
	if targetRoot.Position.Y < minHeight then return end -- Kiểm tra chiều cao lần nữa

	local backCFrame = targetRoot.CFrame * CFrame.new(0, 0, offsetDistance)

	local myChar = localPlayer.Character
	if myChar and myChar:FindFirstChild("HumanoidRootPart") then
		myChar.HumanoidRootPart.CFrame = CFrame.new(backCFrame.Position, targetRoot.Position)
	end
end

-- Xoay camera về phía mục tiêu
local function rotateCameraToTarget(targetPlayer, deltaTime)
	if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then return end

	local targetPos = targetPlayer.Character.HumanoidRootPart.Position
	local direction = (targetPos - camera.CFrame.Position).Unit
	local targetCFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + direction)
	camera.CFrame = camera.CFrame:Lerp(targetCFrame, rotationSpeed * deltaTime)
end

-- Bật/tắt lock bằng phím X
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == toggleKey then
		lockEnabled = not lockEnabled
		if not lockEnabled then
			lockedPlayer = nil
		end
		print("Auto Lock-On:", lockEnabled and "ON" or "OFF")
	end
end)

local lastTime = tick()

RunService.RenderStepped:Connect(function(deltaTime)
	if not lockEnabled then return end

	local now = tick()
	local dt = now - lastTime
	lastTime = now

	-- Nếu chưa có mục tiêu hoặc mục tiêu không hợp lệ, tìm mục tiêu mới
	if not lockedPlayer or not isValidTarget(lockedPlayer, dt) then
		lockedPlayer = findNearestEnemy()
		previousTargetPosition = nil
		standStillTimer = 0
	end

	-- Nếu có mục tiêu hợp lệ thì di chuyển và xoay camera
	if lockedPlayer then
		teleportBehindTarget(lockedPlayer)
		rotateCameraToTarget(lockedPlayer, deltaTime)
	end
end)

-- Thông báo khi script nạp xong
pcall(function()
	game.StarterGui:SetCore("SendNotification", {
		Title = "Auto Lock-On & Teleport",
		Text = "Loaded. Press X to toggle.",
		Duration = 4,
	})
end)
