local part = Instance.new("Part")
part.Size = Vector3.new(4, 1, 4)
part.Position = Vector3.new(0, 5, 0)
part.Anchored = true
part.BrickColor = BrickColor.new("Bright green")
part.Parent = game.Workspace
part.Name = "Treadmill"
local speed = 16 -- studs per second
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
