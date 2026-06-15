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
local screengui = module.screengui
screengui.Name = "LoadingScreen"
screengui.Parent = module.textLabelParent
local textLabel = module.textLabel
textLabel.Name = module.textLabelName
textLabel.Size = module.textLabelSize
textLabel.Position = module.textLabelPosition
textLabel.BackgroundColor3 = module.backgroundColor
textLabel.TextColor3 = module.textColor
textLabel.TextSize = module.textSize
textLabel.TextTransparency = module.textTransparency
textLabel.TextStrokeColor3 = module.textStrokeColor
textLabel.TextStrokeTransparency = module.textStrokeTransparency
textLabel.BackgroundTransparency = module.textLabelBackgroundTransparency
textLabel.BorderSizePixel = module.textLabelBorderSizePixel
textLabel.Text = module.text
textLabel.Parent = screengui
task.wait(module.loadingScreenDuration)
screengui:Destroy()

return module
