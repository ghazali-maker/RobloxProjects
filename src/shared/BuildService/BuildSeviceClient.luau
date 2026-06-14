local Build = {}
function Build:init()
	local build = Instance.new("Model")
	build.Name = "BuildingParts"
	build.Parent = workspace
	self.build = build
end
function game.replicatedStorage.Shared.BuildService.BuildServiceClient.build(self: BuildServiceClient, cf: CFrame)
	local part = Instance.new("Part")
	part.Size = Vector3.new(4, 4, 4)
	part.CFrame = cf
	part.Parent = self.build
end

type BuildServiceClient = typeof(BuildServiceClient) & {
	init: (self: BuildServiceClient) -> (),
	build: (self: BuildServiceClient, cf: CFrame) -> (),
}
return BuildServiceClient
