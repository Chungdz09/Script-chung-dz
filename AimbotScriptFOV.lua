local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Configuration
local lockRange = 50 -- studs
local rotationSpeed = 0.1
local toggleKey = Enum.KeyCode.F
local fovAngle = 15 -- degrees
local visualFovRadius = 100 -- pixels (for on-screen circle only)

-- Variables
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local lockedPlayer = nil
local lockingOn = false
local lockEnabled = true

-- Drawing FOV Circle
local fovCircle = Drawing.new("Circle")
fovCircle.Color = Color3.fromRGB(255, 0, 0)
fovCircle.Thickness = 2
fovCircle.Radius = visualFovRadius
fovCircle.Filled = false
fovCircle.Transparency = 1
fovCircle.Visible = true

-- Find nearest player within range and FOV
local function findNearestPlayerInFOV()
	local nearest = nil
	local shortestDistance = lockRange

	if not localPlayer.Character or not localPlayer.Character:FindFirstChild("Head") then
		return nil
	end

	local localPos = localPlayer.Character.Head.Position
	local camLook = camera.CFrame.LookVector

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Head") then
			local targetPos = player.Character.Head.Position
			local distance = (targetPos - localPos).Magnitude

			if distance < shortestDistance then
				local dirToTarget = (targetPos - localPos).Unit
				local angle = math.deg(math.acos(camLook:Dot(dirToTarget)))

				if angle < fovAngle then
					shortestDistance = distance
					nearest = player
				end
			end
		end
	end

	return nearest
end

-- Lock functions
local function lockOn()
	lockedPlayer = findNearestPlayerInFOV()
	if lockedPlayer then
		lockingOn = true
		print("Locked on:", lockedPlayer.Name)
	else
		print("No target in range or FOV.")
	end
end

local function releaseLock()
	lockingOn = false
	lockedPlayer = nil
end

local function toggleLock()
	lockEnabled = not lockEnabled
	if not lockEnabled then
		releaseLock()
	end
	print("Lock enabled:", lockEnabled)
end

-- Input handlers
UserInputService.InputBegan:Connect(function(input, gp)
	if not gp then
		if input.UserInputType == Enum.UserInputType.MouseButton2 and lockEnabled then
			lockOn()
		elseif input.KeyCode == toggleKey then
			toggleLock()
		end
	end
end)

UserInputService.InputEnded:Connect(function(input, gp)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		releaseLock()
	end
end)

-- Update loop
RunService.RenderStepped:Connect(function()
	-- Update FOV Circle position
	local mousePos = UserInputService:GetMouseLocation()
	fovCircle.Position = Vector2.new(mousePos.X, mousePos.Y)

	-- Lock-on camera follow
	if lockEnabled and lockingOn and lockedPlayer and lockedPlayer.Character and lockedPlayer.Character:FindFirstChild("Head") then
		local targetPos = lockedPlayer.Character.Head.Position
		local direction = (targetPos - camera.CFrame.Position).Unit
		local targetCFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + direction)
		camera.CFrame = camera.CFrame:Lerp(targetCFrame, rotationSpeed)
	end
end)
