local module = {
	part = Instance.new("Part"),
	size = Vector3.new(2, 3, 1),
	position = Vector3.new(0, 1.5, 0),
	name = "Mailbox",
	brickColor = BrickColor.new("Bright red"),
	proximityPrompt = Instance.new("ProximityPrompt"),
	promptActionText = "Check Mailbox",
	promptObjectText = "Mailbox",
	promptParent = nil,
	promptName = "MailboxPrompt",
	players = game:GetService("Players"),
	socialService = game:GetService("SocialService"),
}

local Mailbox = module.part
Mailbox.Name = module.name
Mailbox.Size = module.size
Mailbox.Position = module.position
Mailbox.Anchored = true
Mailbox.Parent = game.Workspace
local proximityPrompt = module.proximityPrompt
proximityPrompt.ActionText = module.promptActionText
proximityPrompt.ObjectText = module.promptObjectText
proximityPrompt.Parent = Mailbox
proximityPrompt.Name = module.promptName
local Players = module.players
local SocialService = module.socialService
local Player = Players.LocalPlayer

proximityPrompt.Triggered:Connect(function()
	SocialService:PromptFeedbackSubmissionAsync()
end)
return module
