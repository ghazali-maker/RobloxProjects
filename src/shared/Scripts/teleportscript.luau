local module = {
	button = script.Parent,
	teleportLocation = Vector3.new(0, 10, 0), -- Change this to your desired teleport location
	buttonname = "teleportbutton",
	buttonparent = nil,
}
local button = module.button
button.name = module.buttonname
button.Parent = game.StarterGUI.ScreenGUI
button.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player then
		player.Character.HumanoidRootPart.CFrame = CFrame.new(module.teleportLocation)
	end
end)
