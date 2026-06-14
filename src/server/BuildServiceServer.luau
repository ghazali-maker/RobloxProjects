local replicatedStorage = game:GetService("ReplicatedStorage")
local NetworkerClient = require(game.ReplicatedStorage.Shared.Networker.NetworkerClient)
local BUILD_COOLDOWN = 5 -- Cooldown time in seconds between builds for each player
local BuildServiceServer = {}
function BuildServiceServer.init(self: BuildServiceServer)
	self.lastBuildTimes = {}
	self.networker = NetworkerClient.new("BuildService", self, {
		self.attempBuild,
	})
end

function BuildServiceServer.attempBuild(self: BuildServiceServer, player: Player, cf: CFrame)
	local lastBuild = self.lastBuildTimes[player] or 0
	local timeSinceLastBuild = os.time() - lastBuild
	if timeSinceLastBuild < BUILD_COOLDOWN then
		local timeLeft = BUILD_COOLDOWN - timeSinceLastBuild
		self.networker:FireClient(player, "BuildCooldown", timeLeft)
		return
	end
	self.lastBuildTimes[player] = os.time()
	local part = Instance.new("Part")
	part.Size = Vector3.new(4, 4, 4)
	part.CFrame = cf
	part.Parent = workspace
	part.Anchored = true
end

type BuildServiceServer = typeof(BuildServiceServer) & {
	lastBuildTimes: { [Player]: number },
	networker: NetworkerClient.ServerNetworker<BuildServiceServer>,
	init: (self: BuildServiceServer) -> (),
}
return BuildServiceServer :: BuildServiceServer
