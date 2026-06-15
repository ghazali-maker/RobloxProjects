local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local ragdollEnabled = false
local function enableRagdoll()
	if ragdollEnabled then
		return
	end
	ragdollEnabled = true

	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
			local joint = Instance.new("BallSocketConstraint")
			joint.Name = "RagdollJoint"
			joint.Attachment0 = Instance.new("Attachment", part)
			joint.Attachment1 = Instance.new("Attachment", humanoid.RootPart)
			joint.Parent = part
		end
	end

	humanoid.PlatformStand = true
end
local function disableRagdoll()
	if not ragdollEnabled then
		return
	end
	ragdollEnabled = false

	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
			local joint = part:FindFirstChild("RagdollJoint")
			if joint then
				joint:Destroy()
			end
		end
	end

	humanoid.PlatformStand = false
end
humanoid.Died:Connect(enableRagdoll)
humanoid.HealthChanged:Connect(function()
	if humanoid.Health <= 0 then
		enableRagdoll()
	else
		disableRagdoll()
	end
end)
