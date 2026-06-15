local module = {
	button = script.Parent,
	teleportLocation = Vector3.new(0, 10, 0), -- Change this to your desired teleport location
	buttonname = "testbutton",
	buttonparent = nil,
	buttonfunction = function()
		script.Parent.MouseButton1Click:Connect(function(hit)
			print("Button clicked!")
			local char = hit.parent
			local player = game.Players:GetPlayerFromCharacter(char)
			if player then
				player.Character.HumanoidRootPart.CFrame =
					CFrame.new(game.Workspace.ReplicatedStorage.UI.UiScripts.testbutton.module.teleportLocation)
			end
		end)
	end,
}
return module
