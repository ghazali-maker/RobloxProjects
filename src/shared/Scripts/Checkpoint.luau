local part = Instance.new("Part")
part.Size = Vector3.new(4, 1, 4)
part.Position = Vector3.new(0, 5, 0)
part.Anchored = true
part.Name = "Checkpoint"
part.BrickColor = BrickColor.new("Bright green")
part.Parent = game.Workspace
local checkpointReached = Instance.new("BindableEvent")
checkpointReached.Name = "CheckpointReached"
checkpointReached.Parent = part
part.Touched:Connect(function(hit)
	local character = hit.Parent
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		checkpointReached:Fire(character)
		print("Checkpoint reached by " .. character.Name)
	end
end)
