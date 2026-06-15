local module = {
	part = Instance.new("Part"),
	size = Vector3.new(4, 1, 4),
	position = Vector3.new(0, 5, 0),
	name = "MovingPart",
	brickColor = BrickColor.new("Bright blue"),
	moveDirection = Vector3.new(1, 0, 0), -- Move along the X-axis
	moveSpeed = 5, -- studs per second
}

local part = module.part
part.Size = module.size
part.Position = module.position
part.Anchored = true
part.Name = module.name
part.BrickColor = module.brickColor
part.Parent = game.Workspace
local moveDirection = module.moveDirection -- Move along the X-axis
local moveSpeed = module.moveSpeed -- studs per second

game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
	part.Position = part.Position + moveDirection * moveSpeed * deltaTime
end)
