local part = Instance.new("Part")
part.Size = Vector3.new(4, 1, 4)
part.Position = Vector3.new(0, 5, 0)
part.Anchored = true
part.BrickColor = BrickColor.new("Bright red")
part.Transparency = 1 -- Make the part invisible
part.Parent = game.Workspace
local explode = Instance.new("Explosion")
explode.BlastRadius = 5
explode.BlastPressure = 50000
local touchCount = 0
part.Touched:Connect(function(hit)
	local character = hit.Parent
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Health = 0
		touchCount = touchCount + 1
		print("Brick touched! Total touches: " .. touchCount)
	end
end)
part.Touched:Connect(function(hit)
	local character = hit.Parent
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		explode.Position = part.Position
		explode.Parent = game.Workspace
	end
end)
