local KillBrickModule = {}
local explosion = Instance.new("Explosion")

-- Fungsi untuk menghancurkan semua bagian tubuh yang menyentuh balok

-- Di sinilah kita memprogram fungsi "Kill"
function KillBrickModule.Kill(hit)
	-- 'hit' adalah bagian tubuh character yang menyentuh balok (misal: Kaki/Lengan)
	local character = hit.Parent

	if character then
		-- Mencari komponen 'Humanoid' yang mengatur nyawa di dalam character
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		-- Memastikan Humanoid ditemukan dan player belum mati
		if humanoid and humanoid.Health > 0 then
			explosion.Parent = game.Workspace
			explosion.Position = character
			-- Mengubah nyawa player menjadi 0 (Karakter otomatis mati)
			--print("Brick touched! Total touches: " .. touchCount)
			humanoid.Health = 0
		end
	end
end

-- Mengembalikan tabel module agar fungsinya bisa dipakai di script lain
return KillBrickModule
