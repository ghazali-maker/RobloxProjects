local Mailbox = Instance.new("Part")
Mailbox.Name = "Mailbox"
Mailbox.Size = Vector3.new(2, 3, 1)
Mailbox.Position = Vector3.new(0, 1.5, 0)
Mailbox.Anchored = true
Mailbox.Parent = game.Workspace
local proximityPrompt = Instance.new("ProximityPrompt")
proximityPrompt.ActionText = "Check Mailbox"
proximityPrompt.ObjectText = "Mailbox"
proximityPrompt.Parent = Mailbox
proximityPrompt.Name = "MailboxPrompt"
local Players = game:GetService("Players")
local SocialService = game:GetService("SocialService")
local Player = Players.LocalPlayer

proximityPrompt.Triggered:Connect(function()
	SocialService:PromptFeedbackSubmissionAsync()
end)
