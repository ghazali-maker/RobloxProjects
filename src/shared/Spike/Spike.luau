local Players = game:GetService("Players")

local Spike = {}
Spike.__index = Spike

export type Spike = typeof(setmetatable(
	{} :: {
		cf: CFrame,
		hits: { [Player]: boolean },
		part: BasePart,
	},
	Spike
))

function Spike.new(cf: CFrame): Spike
	local self = setmetatable({
		cf = cf,
		hits = {},
	}, Spike)

	local part = Instance.new("Part")
	part.Size = Vector3.new(4, 4, 4)
	part.CFrame = cf
	part.Parent = workspace
	part.Anchored = true
	part.Touched:Connect(function(hit)
		local character = hit.Parent
		if character and character:FindFirstChildOfClass("Humanoid") then
			local player = Players:GetPlayerFromCharacter(character)
			if player and not self.hits[player] then
				self.hits[player] = true
				print(player.Name .. " was hit by the spike!")
			end
		end
	end)
	self.part = part

	return self
end

return Spike
