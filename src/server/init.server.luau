print("Server initialized!")
local Checkpoint = require(game.ReplicatedStorage.Scripts.Checkpoint)
local KillBrick = require(game.ReplicatedStorage.Scripts.KillBrick)
local InvisibleKillBrick = require(game.ReplicatedStorage.Scripts.InvisibleKillBrick)
local SpinningBrick = require(game.ReplicatedStorage.Scripts.SpinningBrick)
local MovingPart = require(game.ReplicatedStorage.Scripts.movingpart)
return {
	Checkpoint = Checkpoint,
	KillBrick = KillBrick,
	InvisibleKillBrick = InvisibleKillBrick,
	SpinningBrick = SpinningBrick,
	MovingPart = MovingPart,
}
--the scripts might not be working because of the way they are set up. You might need to adjust the code to fit your specific game and requirements.
