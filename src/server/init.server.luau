local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local scripts = game.ReplicatedStorage.Shared.Scripts

-- Require your module script
local KillBrickModule = require(scripts:WaitForChild("KillBrickScript"))

-- Find the folder in Workspace
local folder = Workspace:WaitForChild("KillBricks")

-- Loop through every part inside the folder and bind the kill function
for _, part in folder:GetChildren() do
	if part:IsA("BasePart") then
		part.Touched:Connect(KillBrickModule.Kill)
	end
end

-- Also bind any new parts added to this folder during gameplay
folder.ChildAdded:Connect(function(part)
	if part:IsA("BasePart") then
		part.Touched:Connect(KillBrickModule.Kill)
	end
end)
