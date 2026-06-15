local module = {
	part = Instance.new("Part"),
	size = Vector3.new(4, 1, 4),
	position = Vector3.new(0, 5, 0),
	name = "SpinningBrick",
	brickColor = BrickColor.new("Bright yellow"),
	rotationSpeed = 45, -- degrees per second
}

local brick = module.part
brick.Size = module.size
brick.Position = module.position
brick.Anchored = true
brick.BrickColor = module.brickColor
brick.Parent = game.Workspace
local rotationSpeed = module.rotationSpeed -- degrees per second
for _, v in (game.Workspace:GetChildren()) do
	if v:isA("Folder") and v.Name == "Invisible" then
		game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
			brick.CFrame = brick.CFrame * CFrame.Angles(0, math.rad(rotationSpeed * deltaTime), 0)
		end)
	end
end
