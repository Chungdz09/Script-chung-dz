local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Configuration
local lockRange = 10000
local screenRadius = 100
local rotationSpeed = 1

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local lockedPlayer = nil
local lockingOn = false
local uiVisible = true

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TargetLockUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(0, 200, 0, 40)
infoLabel.Position = UDim2.new(0, 10, 0, 10)
infoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
infoLabel.BorderSizePixel = 0
infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
infoLabel.TextScaled = true
infoLabel.Font = Enum.Font.SourceSansBold
infoLabel.Text = "Target: None"
infoLabel.Visible = true
infoLabel.Parent = screenGui

-- Drag Variables
local dragging = false
local dragStart, startPos

infoLabel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = infoLabel.Position
	end
end)

infoLabel.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		infoLabel.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
	end
end)

-- Helpers
local function updateUI()
	if lockedPlayer and lockedPlayer.Character then
		infoLabel.Text = "Target: " .. lockedPlayer.Name
	else
		infoLabel.Text = "Target: None"
	end
end

local function isInMouseCircle(worldPosition)
	local screenPoint, onScreen = camera:WorldToViewportPoint(worldPosition)
	if not onScreen then return false end

	local mouseLocation = UserInputService:GetMouseLocation()
	local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mouseLocation).Magnitude

	return distance <= screenRadius
end

-- ✅ Đã sửa: không còn ưu tiên gần nhất, chỉ chọn người đầu tiên trong vòng chuột
local function findPlayerUnderMouse()
	if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
		return nil
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local rootPart = player.Character.HumanoidRootPart
			local distance = (rootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude

			if distance <= lockRange and isInMouseCircle(rootPart.Position) then
				return player -- chỉ cần thấy là chọn
			end
		end
	end

	return nil
end

local function toggleLockUnderMouse()
	if lockedPlayer then
		print("Released lock on", lockedPlayer.Name)
		lockedPlayer = nil
		lockingOn = false
	else
		local target = findPlayerUnderMouse()
		if target then
			lockedPlayer = target
			print("Locked onto", target.Name)
		else
			print("No player under mouse circle")
		end
	end
	updateUI()
end

-- Input Events
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed then
		if input.KeyCode == Enum.KeyCode.LeftControl then
			toggleLockUnderMouse()
		elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
			if lockedPlayer then
				lockingOn = true
			end
		elseif input.KeyCode == Enum.KeyCode.F1 then
			uiVisible = not uiVisible
			infoLabel.Visible = uiVisible
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		lockingOn = false
	end
end)

-- Lock-on camera movement
RunService.RenderStepped:Connect(function()
	if lockingOn and lockedPlayer and lockedPlayer.Character and lockedPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local targetPosition = lockedPlayer.Character.HumanoidRootPart.Position
		local direction = (targetPosition - camera.CFrame.Position).Unit
		local targetCFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + direction)
		camera.CFrame = camera.CFrame:Lerp(targetCFrame, rotationSpeed)
	end
end)

-- Notify on load
game.StarterGui:SetCore("SendNotification", {
	Title = "Target Lock",
	Text = "Script loaded. Ctrl = lock, F1 = toggle UI",
	Duration = 4,
})
