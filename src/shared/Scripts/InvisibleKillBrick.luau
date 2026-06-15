local module = {
	part = Instance.new("Part"),
	size = Vector3.new(4, 1, 4),
	position = Vector3.new(0, 5, 0),
	brickColor = BrickColor.new("Bright red"),
	transparency = 1,
	explosionRadius = 5,
	explosionPressure = 50000,
	touchCount = 0,
}

local part = module.part
part.Size = module.size
part.Position = module.position
part.Anchored = true
part.BrickColor = module.brickColor
part.Transparency = module.transparency
part.Parent = game.Workspace
local explode = Instance.new("Explosion")
explode.BlastRadius = module.explosionRadius
explode.BlastPressure = module.explosionPressure
local touchCount = module.touchCount
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
