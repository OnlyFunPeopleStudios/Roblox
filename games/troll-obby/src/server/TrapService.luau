-- Manejo de plataformas falsas y trampas
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Config = require(ReplicatedStorage.Shared.Config)

local TrapService = {}
local deadPlayers = {}

function TrapService.Init()
	local map = Workspace:FindFirstChild("TrollObbyMap")
	if not map then
		warn("[TrollObby] TrapService: TrollObbyMap no encontrado")
		return
	end

	-- Plataformas falsas
	local geometry = map:FindFirstChild("Geometry")
	if geometry then
		for _, child in ipairs(geometry:GetDescendants()) do
			if child:IsA("BasePart") and child:GetAttribute("Fake") and child:GetAttribute("Fallen") == false then
				local originalCFrame = child:GetAttribute("OriginalCFrame")
				if not originalCFrame then
					warn("[TrollObby] TrapService: Plataforma falsa sin OriginalCFrame válida")
					continue
				end
				local touched = false
				child.Touched:Connect(function(hit)
					if touched then
						return
					end
					local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
					if not humanoid or humanoid.Health <= 0 then
						return
					end
					touched = true
					task.wait(Config.FAKE_PLATFORM_DELAY)
					if child.Parent then
						child.Anchored = false
						child.CanCollide = true
					end
					task.wait(Config.FAKE_PLATFORM_RECOVER)
					if child.Parent then
						local orig = child:GetAttribute("OriginalCFrame")
						if orig then
							child.Anchored = true
							child.CFrame = orig
							child.CanCollide = true
						end
					end
					touched = false
				end)
			end
		end
	end

	-- Trampas killbrick
	local traps = map:FindFirstChild("Traps")
	if traps then
		for _, trap in ipairs(traps:GetChildren()) do
			if trap:IsA("BasePart") and trap:GetAttribute("Kill") then
				trap.Touched:Connect(function(hit)
					local character = hit.Parent
					local humanoid = character:FindFirstChildOfClass("Humanoid")
					if not humanoid or humanoid.Health <= 0 then
						return
					end
					local player = Players:GetPlayerFromCharacter(character)
					if player and deadPlayers[player] then
						return
					end
					if player then
						deadPlayers[player] = true
					end
					humanoid.Health = 0
					-- Limpiar debounce tras respawn
					if player then
						task.delay(3, function()
							deadPlayers[player] = nil
						end)
					end
				end)
			end
		end
	end
end

return TrapService
