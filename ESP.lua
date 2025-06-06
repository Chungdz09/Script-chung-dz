local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

getgenv().configs = getgenv().configs or {}
getgenv().configs.PlayerEsp = true

function IsPlayerAlive(plr)
	return plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.Humanoid.Health > 0
end

function EspOnPlayer(target)
	local BoxOutline = Drawing.new("Square")
	BoxOutline.Thickness = 2
	BoxOutline.Color = Color3.new(0, 0, 0)
	BoxOutline.Transparency = 1
	BoxOutline.Filled = false

	local Box = Drawing.new("Square")
	Box.Thickness = 2
	Box.Color = Color3.fromRGB(0, 255, 0)
	Box.Transparency = 1
	Box.Filled = false

	local HPBarOutline = Drawing.new("Square")
	HPBarOutline.Thickness = 1
	HPBarOutline.Color = Color3.new(0, 0, 0)
	HPBarOutline.Transparency = 1
	HPBarOutline.Filled = false

	local HPBar = Drawing.new("Square")
	HPBar.Thickness = 1
	HPBar.Transparency = 1
	HPBar.Filled = true
	HPBar.Color = Color3.fromRGB(0, 255, 0)

	local NameText = Drawing.new("Text")
	NameText.Size = 14
	NameText.Center = true
	NameText.Outline = true
	NameText.Font = 2
	NameText.Color = Color3.new(1, 1, 1)
	NameText.Text = target.DisplayName

	local conn
	conn = RunService.RenderStepped:Connect(function()
		if not getgenv().configs.PlayerEsp then
			Box:Remove(); BoxOutline:Remove()
			HPBar:Remove(); HPBarOutline:Remove()
			NameText:Remove()
			conn:Disconnect()
			return
		end

		if IsPlayerAlive(target) and target ~= LocalPlayer then
			local hrp = target.Character:FindFirstChild("HumanoidRootPart")
			local head = target.Character:FindFirstChild("Head")
			if not hrp or not head then return end

			local HumPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
			if not onScreen then
				Box.Visible = false; BoxOutline.Visible = false
				HPBar.Visible = false; HPBarOutline.Visible = false
				NameText.Visible = false
				return
			end

			local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
			local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 2.5, 0))

			local boxHeight = headPos.Y - legPos.Y
			local boxWidth = math.clamp(1050 / HumPos.Z, 2, 600)

			local topLeft = Vector2.new(HumPos.X - boxWidth / 2, HumPos.Y - boxHeight / 2)

			BoxOutline.Size = Vector2.new(boxWidth, boxHeight)
			BoxOutline.Position = topLeft
			BoxOutline.Visible = true

			Box.Size = Vector2.new(boxWidth, boxHeight)
			Box.Position = topLeft
			Box.Visible = true

			local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
			local health = humanoid.Health
			local maxHealth = humanoid.MaxHealth
			local hpRatio = math.clamp(health / maxHealth, 0, 1)
			local barHeight = boxHeight * hpRatio

			HPBarOutline.Size = Vector2.new(4, boxHeight)
			HPBarOutline.Position = topLeft - Vector2.new(6, 0)
			HPBarOutline.Visible = true

			HPBar.Size = Vector2.new(2, barHeight)
			HPBar.Position = Vector2.new(HPBarOutline.Position.X + 1, HPBarOutline.Position.Y + (boxHeight - barHeight))
			HPBar.Color = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(0, 255, 0), hpRatio)
			HPBar.Visible = true

			-- ✅ Show name above the head
			local nameWorldPos = head.Position + Vector3.new(0, 1.5, 0)
			local nameScreenPos, nameOnScreen = Camera:WorldToViewportPoint(nameWorldPos)
			if nameOnScreen then
				NameText.Text = target.DisplayName
				NameText.Position = Vector2.new(nameScreenPos.X, nameScreenPos.Y)
				NameText.Visible = true
			else
				NameText.Visible = false
			end
		else
			Box.Visible = false; BoxOutline.Visible = false
			HPBar.Visible = false; HPBarOutline.Visible = false
			NameText.Visible = false
		end
	end)
end

function PlayerEsp()
	if getgenv().configs.PlayerEsp then
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer then
				EspOnPlayer(plr)
			end
		end

		Players.PlayerAdded:Connect(function(plr)
			plr.CharacterAdded:Connect(function()
				if getgenv().configs.PlayerEsp then
					EspOnPlayer(plr)
				end
			end)
		end)
	end
end

-- Kích hoạt ESP
PlayerEsp()

pcall(function()
	game.StarterGui:SetCore("SendNotification", {
		Title = "Draw Player",
		Text = "Loaded. Press it 1 more time to turn on/off.",
		Duration = 4,
	})
end)
