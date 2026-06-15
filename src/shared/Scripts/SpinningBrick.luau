local brick = Instance.new("Part")
brick.Size = Vector3.new(4, 1, 4)
brick.Position = Vector3.new(0, 5, 0)
brick.Anchored = true
brick.BrickColor = BrickColor.new("Bright yellow")
brick.Parent = game.Workspace
local rotationSpeed = 45 -- degrees per second
game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
	brick.CFrame = brick.CFrame * CFrame.Angles(0, math.rad(rotationSpeed * deltaTime), 0)
end)
