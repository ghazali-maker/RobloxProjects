local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local scripts = ReplicatedStorage.Shared.Scripts

-- Require your module script
local KillBrickModule = require(scripts:WaitForChild("KillBrickScript"))

-- Find the folder in Workspace
local folder1 = Workspace:WaitForChild("KillBricks")
local folder2 = Workspace:WaitForChild("Treadmill")
local folder3 = Workspace:WaitForChild("Trampoline")
local folder4 = Workspace:WaitForChild("Door")
local folder5 = Workspace:WaitForChild("MovingPart")
local folder6 = Workspace:WaitForChild("InvisibleKillBrick")

-- Loop through every part inside the folder and bind the kill function
for _, part in folder1:GetChildren() do
	if part:IsA("BasePart") then
		part.Touched:Connect(KillBrickModule.Kill)
	end
end

-- Also bind any new parts added to this folder during gameplay
folder1.ChildAdded:Connect(function(part)
	if part:IsA("BasePart") then
		part.Touched:Connect(KillBrickModule.Kill)
	end
end)

function Treadmill(part, speed)
	RunService.Heartbeat:Connect(function(deltatime)
		for _, character in pairs(Workspace:GetChildren()) do
			if character:IsA("Model") and character:FindFirstChildOfClass("Humanoid") then
				local rootPart = character:FindFirstChild("HumanoidRootPart")
				if rootPart and (rootPart.Position - part.Position).Magnitude < 5 then
					local direction = (part.Position - rootPart.Position).Unit
					rootPart.Velocity = direction * speed
				end
			end
		end
	end)
end

for _, part in folder2:GetChildren() do
	if part:IsA("BasePart") then
		Treadmill(part, 10)
	end
end

function Trampoline(part, bounceForce)
	part.Touched:Connect(function(hit)
		local character = hit.Parent
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local rootPart = character and character:FindFirstChild("HumanoidRootPart")
		if humanoid and rootPart then
			rootPart.Velocity = Vector3.new(rootPart.Velocity.X, bounceForce, rootPart.Velocity.Z)
			print("Bounced " .. character.Name)
		end
	end)
end

for _, part in folder3:GetChildren() do
	if part:IsA("BasePart") then
		Trampoline(part, 50)
	end
end

function DoorPart(door)
	local module = {
		proximityPromptActionText = "Open Door",
		proximityPromptObjectText = "Door",
		proximityPromptHoldDuration = 0.5, -- Time in seconds to hold the prompt before it activates
		proximityPromptEnabled = true,
	}
	local proximityPrompt = Instance.new("ProximityPrompt")
	proximityPrompt.ActionText = module.proximityPromptActionText
	proximityPrompt.ObjectText = module.proximityPromptObjectText
	proximityPrompt.HoldDuration = module.proximityPromptHoldDuration
	proximityPrompt.Enabled = module.proximityPromptEnabled
	proximityPrompt.Parent = door
	proximityPrompt.Triggered:Connect(function(player)
		door.Transparency = 0.5 -- Example: Make the door semi-transparent to indicate it's open
		door.CanCollide = false -- Allow players to pass through the door when it's open
	end)
end

for _, part in folder4:GetChildren() do
	if part:IsA("BasePart") then
		DoorPart(part)
		part.Anchored = true
	end
end

function movingpart(part)
	local function onTouched(hit)
		local char = hit.Parent
		local humanoid = char and char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			RunService.Heartbeat:Connect(function(deltaTime)
				local moveDirection = Vector3.new(1, 0, 0) -- Move along the X-axis
				local moveSpeed = 0.01 -- studs per second
				part.Position = part.Position + moveDirection * moveSpeed * deltaTime
			end)
		end
	end
	part.Touched:Connect(onTouched)
end

for _, part in folder5:GetChildren() do
	if part:IsA("BasePart") then
		movingpart(part)
	end
end

function KillBrickModule2(hit)
	-- 'hit' adalah bagian tubuh character yang menyentuh balok (misal: Kaki/Lengan)
	local explosion = Instance.new("Explosion")
	local character = hit.Parent

	if character then
		-- Mencari komponen 'Humanoid' yang mengatur nyawa di dalam character
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		-- Memastikan Humanoid ditemukan dan player belum mati
		if humanoid and humanoid.Health > 0 then
			-- Mengubah nyawa player menjadi 0 (Karakter otomatis mati)
			--print("Brick touched! Total touches: " .. touchCount)
			humanoid.Health = 0
			explosion.Parent = game.Workspace
			explosion.Position = character
		end
	end
end
for _, part in folder6:GetChildren() do
	if part:IsA("BasePart") then
		part.Touched:Connect(KillBrickModule2)
		part.Transparency = 1
	end
end
for _, part in
	folder1:GetChildren() and folder2:GetChildren() and folder3:GetChildren() and folder4:GetChildren() and folder5:GetChildren() and folder6:GetChildren()
do
	if part:IsA("BasePart") then
		part.Anchored = true
	end
end
