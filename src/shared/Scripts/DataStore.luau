local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RequestData = ReplicatedStorage.Remotes:WaitForChild("RequestData") -- Change this yo whatever your RemoteFunction was called.
local DataStore = DataStoreService:GetDataStore("DataStore1") -- Change this to your datastore name.
local PlayerData = {}

local function getDefaultData()
	return {
		-- This is where you outline your default values: For example: "Coins = {Value = 100, ShowOnLeaderboard = true},"
		Coins = { Value = 0, ShowOnLeaderboard = true },
	}
end

local function createStatFolders(player, data)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local hiddenStats = Instance.new("Folder")
	hiddenStats.Name = "hiddenStats"
	hiddenStats.Parent = player

	for statName, statData in pairs(data) do
		local stat = Instance.new("IntValue")
		stat.Name = statName
		stat.Value = statData.Value

		if statData.ShowOnLeaderboard then
			stat.Parent = leaderstats
		else
			stat.Parent = hiddenStats
		end
	end
end

local function loadData(player)
	local success, data = pcall(function()
		return DataStore:GetAsync(player.UserId)
	end)

	if not success then
		warn("Failed to load data for " .. player.Name .. ":", data)
	end

	PlayerData[player] = data or getDefaultData()

	local defaults = getDefaultData()
	for key, value in pairs(defaults) do
		if PlayerData[player][key] == nil then
			PlayerData[player][key] = value
		end
	end

	createStatFolders(player, PlayerData[player])
end

local function saveData(player)
	local data = PlayerData[player]
	if not data then
		return
	end

	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		for _, stat in pairs(leaderstats:GetChildren()) do
			if data[stat.Name] then
				data[stat.Name].Value = stat.Value
			end
		end
	end

	local hiddenStats = player:FindFirstChild("hiddenStats")
	if hiddenStats then
		for _, stat in pairs(hiddenStats:GetChildren()) do
			if data[stat.Name] then
				data[stat.Name].Value = stat.Value
			end
		end
	end

	pcall(function()
		DataStore:SetAsync(player.UserId, data)
	end)
end

Players.PlayerAdded:Connect(function(player)
	loadData(player)
end)

Players.PlayerRemoving:Connect(function(player)
	saveData(player)
	PlayerData[player] = nil
end)

RequestData.OnServerInvoke = function(player)
	return PlayerData[player] or getDefaultData()
end

game:BindToClose(function()
	for _, player in pairs(Players:GetPlayers()) do
		saveData(player)
	end
end)
