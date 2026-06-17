local module1 = {}
function module1.NewFunction()
	local module = {
		part = Instance.new("Part"),
		size = Vector3.new(4, 1, 4),
		position = Vector3.new(0, 5, 0),
		name = "Checkpoint",
		brickColor = BrickColor.new("Bright green"),
		badgeserver = game:GetService("BadgeService"),
		badgeId = 12345678, -- Change this to your badge ID
	}
	local part = module.part
	part.Size = module.size
	part.Position = module.position
	part.Anchored = true
	part.Name = module.name
	part.BrickColor = module.brickColor
	part.Parent = game.Workspace
	local checkpointReached = Instance.new("BindableEvent")
	checkpointReached.Name = "CheckpointReached"
	checkpointReached.Parent = part
	part.Touched:Connect(function(hit)
		local screengui = Instance.new("ScreenGui")
		screengui.Name = "CheckpointNotification"
		screengui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(0, 200, 0, 50)
		textLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
		textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
		textLabel.TextColor3 = Color3.new(1, 1, 1)
		textLabel.Text = "Checkpoint Reached!"
		screengui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
		textLabel.Parent = screengui
		textLabel.TextTransparency = 1
		local character = hit.Parent
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			checkpointReached:Fire(character)
			textLabel.TextTransparency = 0
			wait(2)
			screengui:Destroy()
			game.ReplicatedStorage.Shared.Scripts.Checkpoint.badgeserver:AwardBadge(
				game.Players:GetPlayerFromCharacter(character),
				module.badgeId
			)
			print("Checkpoint reached by " .. character.Name)
		end
	end)
end
return module1
