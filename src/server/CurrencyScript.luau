local CurrencyConfig = {}

CurrencyConfig.Currency = { -- Currency is name of this table.
	SmallPack = {
		Value = 5, -- This is the amount of currency you get for collecting that item.
		Model = "SmallCoinPack", -- This is the name of your item inside ServerStorage
	},
	MediumPack = {
		Value = 25,
		Model = "MediumCoinPack",
	},
}

CurrencyConfig.RespawnMin = 4 -- This is the minimum time between respawns.
CurrencyConfig.RespawnMax = 30 -- This is the maximum time between respawns.

CurrencyConfig.InitialSpawnCount = 20 -- This is the number of currency items that spawn initially.

return CurrencyConfig
