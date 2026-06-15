local module = {
	part = Instance.new("Part"),
	size = Vector3.new(4, 1, 4),
	position = Vector3.new(0, 5, 0),
	name = "Door",
	brickColor = BrickColor.new("Brown"),
	textureId = "rbxassetid://12345678", -- Replace with your door texture asset ID
	proximityPromptActionText = "Open Door",
	proximityPromptObjectText = "Door",
	proximityPromptHoldDuration = 0.5, -- Time in seconds to hold the prompt before it activates
	proximityPromptEnabled = true,
}
local door = module.part
door.Size = module.size
door.Position = module.position
door.Anchored = true
door.Name = module.name
door.BrickColor = module.brickColor
local texture = Instance.new("Texture")
texture.Texture = module.textureId
texture.Face = Enum.NormalId.Front
texture.Parent = door
door.Parent = game.Workspace
proximityPrompt = Instance.new("ProximityPrompt")
proximityPrompt.ActionText = module.proximityPromptActionText
proximityPrompt.ObjectText = module.proximityPromptObjectText
proximityPrompt.HoldDuration = module.proximityPromptHoldDuration
proximityPrompt.Enabled = module.proximityPromptEnabled
proximityPrompt.Parent = door
proximityPrompt.Triggered:Connect(function(player)
	-- Add your door opening logic here, such as playing an animation or changing the door's transparency
	door.Transparency = 0.5 -- Example: Make the door semi-transparent to indicate it's open
	door.CanCollide = false -- Allow players to pass through the door when it's open
end)

return module
