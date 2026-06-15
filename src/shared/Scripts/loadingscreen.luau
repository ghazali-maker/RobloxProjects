local module = {
	screengui = Instance.new("ScreenGui"),
	textLabel = Instance.new("TextLabel"),
	text = "Loading...",
	backgroundColor = Color3.new(0, 0, 0),
	textColor = Color3.new(1, 1, 1),
	textSize = 24,
	textTransparency = 0,
	textStrokeColor = Color3.new(0, 0, 0),
	textStrokeTransparency = 0,
	textLabelSize = UDim2.new(0, 200, 0, 50),
	textLabelPosition = UDim2.new(0.5, -100, 0.5, -25),
	textLabelBackgroundTransparency = 0.5,
	textLabelBorderSizePixel = 0,
	textLabelParent = nil, -- Set this to the parent you want the loading screen to be in (e.g., PlayerGui)
	textLabelName = "LoadingScreenTextLabel",
	loadingScreenDuration = 3, -- Duration in seconds for how long the loading screen should be visible
}

-- Function to create the loading screen
local function createLoadingScreen()
	-- Set up the ScreenGui
	module.screengui.Name = "LoadingScreen"
	module.screengui.ResetOnSpawn = false
	module.screengui.IgnoreGuiInset = true
	module.screengui.DisplayOrder = 100 -- Ensure it's on top
	module.screengui.Parent = module.textLabelParent or game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

return module
