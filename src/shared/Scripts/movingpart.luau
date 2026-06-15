local part = Instance.new("Part")
part.Size = Vector3.new(4, 1, 4)
part.Position = Vector3.new(0, 5, 0)
part.Anchored = true
part.Name = "MovingPart"
part.BrickColor = BrickColor.new("Bright blue")
part.Parent = game.Workspace
local moveDirection = Vector3.new(1, 0, 0) -- Move along the X-axis
local moveSpeed = 5 -- studs per second
game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
	part.Position = part.Position + moveDirection * moveSpeed * deltaTime
end)
