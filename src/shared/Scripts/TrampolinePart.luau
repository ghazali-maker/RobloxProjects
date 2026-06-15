local module = {
	part = Instance.new("Part"),
	size = Vector3.new(4, 1, 4),
	position = Vector3.new(0, 5, 0),
	bounceForce = 50,
	name = "TrampolinePart",
	brickColor = BrickColor.new("Bright green"),
}
local part = module.part
part.Size = module.size
part.Position = module.position
part.Anchored = true
part.Name = module.name
part.BrickColor = module.brickColor
part.Parent = game.Workspace
local bounceForce = module.bounceForce -- Adjust this value to increase/decrease bounce height
part.Touched:Connect(function(hit)
	local character = hit.Parent
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local rootPart = character and character:FindFirstChild("HumanoidRootPart")
	if humanoid and rootPart then
		rootPart.Velocity = Vector3.new(rootPart.Velocity.X, bounceForce, rootPart.Velocity.Z)
		print("Bounced " .. character.Name)
	end
end)
return module
