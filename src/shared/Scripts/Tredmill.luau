local module = {
	part = Instance.new("Part"),
	size = Vector3.new(4, 1, 4),
	position = Vector3.new(0, 5, 0),
	name = "Treadmill",
	brickColor = BrickColor.new("Bright green"),
	speed = 16,
}

local part = module.part
part.Size = module.size
part.Position = module.position
part.Anchored = true
part.BrickColor = module.brickColor
part.Parent = game.Workspace
part.Name = module.name
local speed = module.speed -- studs per second
game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
	for _, character in pairs(game.Workspace:GetChildren()) do
		if character:IsA("Model") and character:FindFirstChildOfClass("Humanoid") then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local rootPart = character:FindFirstChild("HumanoidRootPart")
			if rootPart and (rootPart.Position - part.Position).magnitude < 5 then
				local direction = (part.Position - rootPart.Position).unit
				rootPart.Velocity = direction * speed
			end
		end
	end
end)
