local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Camera = workspace.CurrentCamera
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Character, Humanoid, HumanoidPart, Head

local CamPos, TargetCamPos = Camera.CoordinateFrame.p, Camera.CoordinateFrame.p
local AngleX, TargetAngleX = 0, 0
local AngleY, TargetAngleY = 0, 0

local CanToggleMouse = { allowed = true, activationkey = Enum.KeyCode.C } -- Change C to whatever you want your disable key to be.
local CanViewBody = true
local Sensitivity = 0.1
local Smoothness = 0.05
local FieldOfView = 80
local PlayerHeadOffset = CFrame.new(0, 0.7, 0)

local Running = true
local FreeMouse = false
local DefaultFOV = FieldOfView
local W, A, S, D, LShift = false, false, false, false, false
local EasingTime = 0.1

local WalkSpeeds = { -- This is where you're able to adjust the players walks and running speed.
	enabled = true,
	walkingspeed = 16,
	backwardsspeed = 16,
	sidewaysspeed = 16,
	diagonalspeed = 16,
	runningspeed = 25,
	runningFOV = 85,
}

function UpdateCharacter()
	for _, Part in pairs(Character:GetChildren()) do
		if CanViewBody then
			if Part.Name == "Head" then
				Part.LocalTransparencyModifier = 1
				Part.CanCollide = false

				local Face = Part:FindFirstChild("face")
				if Face then
					Face.LocalTransparencyModifier = 1
				end
			end
		else
			if Part:IsA("Part") or Part:IsA("UnionOperation") or Part:IsA("MeshPart") then
				Part.LocalTransparencyModifier = 1
				Part.CanCollide = false
			end
		end

		if Part:IsA("Accessory") or Part:IsA("Hat") then
			local Handle = Part:FindFirstChild("Handle")
			if Handle then
				Handle.LocalTransparencyModifier = 1
				Handle.CanCollide = false
			end
		end
	end
end

function Lerp(a, b, t)
	return a * (1 - t) + (b * t)
end

UserInputService.InputChanged:Connect(function(InputObject)
	if InputObject.UserInputType == Enum.UserInputType.MouseMovement then
		local Delta = Vector2.new(InputObject.Delta.x / Sensitivity, InputObject.Delta.y / Sensitivity) * Smoothness
		local X = TargetAngleX - Delta.y
		TargetAngleX = math.clamp(X, -80, 80)
		TargetAngleY = (TargetAngleY - Delta.x) % 360
	end
end)

UserInputService.InputBegan:Connect(function(InputObject)
	if InputObject.UserInputType == Enum.UserInputType.Keyboard then
		if InputObject.KeyCode == CanToggleMouse.activationkey and CanToggleMouse.allowed then
			FreeMouse = not FreeMouse
		end

		if InputObject.KeyCode == Enum.KeyCode.W then
			W = true
		end
		if InputObject.KeyCode == Enum.KeyCode.A then
			A = true
		end
		if InputObject.KeyCode == Enum.KeyCode.S then
			S = true
		end
		if InputObject.KeyCode == Enum.KeyCode.D then
			D = true
		end
		if InputObject.KeyCode == Enum.KeyCode.LeftShift then
			LShift = true
		end
	end
end)

UserInputService.InputEnded:Connect(function(InputObject)
	if InputObject.UserInputType == Enum.UserInputType.Keyboard then
		if InputObject.KeyCode == Enum.KeyCode.W then
			W = false
		end
		if InputObject.KeyCode == Enum.KeyCode.A then
			A = false
		end
		if InputObject.KeyCode == Enum.KeyCode.S then
			S = false
		end
		if InputObject.KeyCode == Enum.KeyCode.D then
			D = false
		end
		if InputObject.KeyCode == Enum.KeyCode.LeftShift then
			LShift = false
		end
	end
end)

function SetupCharacter(Char)
	Character = Char
	Humanoid = Character:WaitForChild("Humanoid")
	HumanoidPart = Character:WaitForChild("HumanoidRootPart")
	Head = Character:WaitForChild("Head")

	Camera.CameraType = Enum.CameraType.Custom
	wait()
	Camera.CameraType = Enum.CameraType.Scriptable
	FreeMouse = false
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
end

if Player.Character then
	SetupCharacter(Player.Character)
end

Player.CharacterAdded:Connect(SetupCharacter)

RunService.RenderStepped:Connect(function()
	if not Character or not Humanoid or not HumanoidPart or not Head then
		return
	end

	UpdateCharacter()

	CamPos = CamPos + (TargetCamPos - CamPos) * 0.28
	AngleX = AngleX + (TargetAngleX - AngleX) * 0.35

	local Dist = TargetAngleY - AngleY
	if math.abs(Dist) > 180 then
		Dist = Dist - math.sign(Dist) * 360
	end
	AngleY = (AngleY + Dist * 0.35) % 360

	Camera.CameraType = Enum.CameraType.Scriptable
	Camera.CoordinateFrame = CFrame.new(Head.Position)
		* CFrame.Angles(0, math.rad(AngleY), 0)
		* CFrame.Angles(math.rad(AngleX), 0, 0)
		* PlayerHeadOffset

	HumanoidPart.CFrame = CFrame.new(HumanoidPart.Position) * CFrame.Angles(0, math.rad(AngleY), 0)

	if (Camera.Focus.p - Camera.CoordinateFrame.p).magnitude < 1 then
		Running = false
	else
		Running = true
		UserInputService.MouseBehavior = FreeMouse and Enum.MouseBehavior.Default or Enum.MouseBehavior.LockCenter
	end

	if not CanToggleMouse.allowed then
		FreeMouse = false
	end

	Camera.FieldOfView = FieldOfView

	if WalkSpeeds.enabled then
		if W and S then
			return
		end

		if W and not LShift then
			FieldOfView = Lerp(FieldOfView, DefaultFOV, EasingTime)
			Humanoid.WalkSpeed = Lerp(Humanoid.WalkSpeed, WalkSpeeds.walkingspeed, EasingTime)
		elseif W and (A or D) then
			Humanoid.WalkSpeed = Lerp(Humanoid.WalkSpeed, WalkSpeeds.diagonalspeed, EasingTime)
		elseif S then
			Humanoid.WalkSpeed = Lerp(Humanoid.WalkSpeed, WalkSpeeds.backwardsspeed, EasingTime)
		elseif S and (A or D) then
			Humanoid.WalkSpeed = Lerp(
				Humanoid.WalkSpeed,
				WalkSpeeds.backwardsspeed - (WalkSpeeds.diagonalspeed - WalkSpeeds.backwardsspeed),
				EasingTime
			)
		elseif D or A then
			Humanoid.WalkSpeed = Lerp(Humanoid.WalkSpeed, WalkSpeeds.sidewaysspeed, EasingTime)
		end

		if LShift and W then
			FieldOfView = Lerp(FieldOfView, WalkSpeeds.runningFOV, EasingTime)
			Humanoid.WalkSpeed = Lerp(Humanoid.WalkSpeed, WalkSpeeds.runningspeed, EasingTime)
		end
	end
end)
