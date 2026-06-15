local module = { players = game:GetService("Players"), avatarEditorService = game:GetService("AvatarEditorService") }

local Players = module.players
local Player = Players.LocalPlayer
local AvatarEditorService = module.avatarEditorService

while true do
	local WaitTime = math.random(300, 600) -- This randomises the time each time, you can adjust the range in seconds.
	task.wait(WaitTime)

	if Player then
		AvatarEditorService:PromptSetFavorite(game.PlaceId, Enum.AvatarItemType.Asset, true)
	end
end
