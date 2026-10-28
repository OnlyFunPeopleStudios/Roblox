-- Gestión de checkpoints y reaparición
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Config = require(ReplicatedStorage.Shared.Config)

local CheckpointService = {}
local playerData = {}
local connections = {}

-- Altura del personaje por encima de la superficie (HRP está en el centro del torso)
local CHARACTER_HEIGHT_OFFSET = 3

local function getStartPlatform(map)
	if not map then
		return nil
	end
	local geometry = map:FindFirstChild("Geometry")
	if not geometry then
		return nil
	end
	return geometry:FindFirstChild("StartPlatform")
end

local function getSpawnCFrame(map)
	local startPlatform = getStartPlatform(map)
	if startPlatform and startPlatform:IsA("BasePart") then
		-- Calcular posición por encima de la superficie de la plataforma
		local platformTop = startPlatform.Position.Y + (startPlatform.Size.Y / 2)
		local spawnY = platformTop + CHARACTER_HEIGHT_OFFSET
		return CFrame.new(startPlatform.Position.X, spawnY, startPlatform.Position.Z)
	end
	-- Fallback solo si no existe la plataforma
	warn("[TrollObby] CheckpointService: StartPlatform no encontrada, usando fallback")
	return CFrame.new(0, 5, -12)
end

local function getCheckpointByStage(map, stage)
	if not map or not map:FindFirstChild("Checkpoints") then
		return nil
	end
	for _, c in ipairs(map.Checkpoints:GetChildren()) do
		if c:IsA("BasePart") and c:GetAttribute("Stage") == stage then
			return c
		end
	end
	return nil
end

local function getCheckpointSpawnCFrame(map, stage)
	local cp = getCheckpointByStage(map, stage)
	if cp and cp:IsA("BasePart") and cp.Parent then
		-- El checkpoint es un cilindro horizontal, spawn por encima de su parte superior
		local cpTop = cp.Position.Y + (cp.Size.Y / 2) + 1.5 -- radio del cilindro aprox
		return CFrame.new(cp.Position.X, cpTop + CHARACTER_HEIGHT_OFFSET, cp.Position.Z)
	end
	return nil
end

local function updateUI(player)
	local data = playerData[player]
	if not data then
		return
	end
	local remote = ReplicatedStorage:FindFirstChild("UpdateUI")
	if remote and remote:IsA("RemoteEvent") then
		remote:FireClient(player, data.Stage or 1, data.Deaths or 0)
	end
end

local function safeRespawn(player, character)
	-- Esperar a que el personaje esté completamente cargado
	local hrp = character:WaitForChild("HumanoidRootPart", 10)
	local humanoid = character:WaitForChild("Humanoid", 10)
	if not hrp or not humanoid then
		warn("[TrollObby] CheckpointService: No se pudo obtener HRP/Humanoid")
		return
	end

	-- Esperar a que el personaje esté parentado en Workspace
	local timeout = 0
	while character.Parent ~= Workspace and timeout < 100 do
		task.wait(0.05)
		timeout = timeout + 1
	end

	-- Esperar un frame adicional para que Roblox termine de posicionar
	task.wait(0.1)

	local data = playerData[player]
	if not data then
		playerData[player] = {Stage = 1, Deaths = 0}
		data = playerData[player]
	end

	local stage = data.Stage or 1
	local map = Workspace:FindFirstChild("TrollObbyMap")

	local targetCFrame
	if stage == 1 or not map then
		targetCFrame = getSpawnCFrame(map)
	else
		local cpCFrame = getCheckpointSpawnCFrame(map, stage)
		if cpCFrame then
			targetCFrame = cpCFrame
		else
			warn(string.format("[TrollObby] CheckpointService: No se encontró checkpoint para Stage %d, usando spawn inicial", stage))
			targetCFrame = getSpawnCFrame(map)
		end
	end

	-- Usar PivotTo para teletransportar todo el personaje de forma confiable
	if character and character.Parent == Workspace then
		character:PivotTo(targetCFrame)
	end

	-- Re-verificar posición después de un frame (Roblox puede sobrescribir)
	task.wait(0.1)
	if character and character.Parent == Workspace and hrp and hrp.Parent then
		-- Solo re-aplicar si el personaje se movió inesperadamente
		local currentPos = hrp.Position
		local targetPos = targetCFrame.Position
		local distance = (currentPos - targetPos).Magnitude
		if distance > 5 then
			character:PivotTo(targetCFrame)
		end
	end

	updateUI(player)
end

function CheckpointService.Init()
	local map = Workspace:FindFirstChild("TrollObbyMap")
	if not map then
		warn("[TrollObby] CheckpointService: TrollObbyMap no encontrado")
		return
	end

	local checkpoints = map:FindFirstChild("Checkpoints")
	if not checkpoints then
		warn("[TrollObby] CheckpointService: Carpeta Checkpoints no encontrada")
		return
	end

	for _, cp in ipairs(checkpoints:GetChildren()) do
		if cp:IsA("BasePart") then
			local stage = cp:GetAttribute("Stage")
			if type(stage) ~= "number" then
				warn("[TrollObby] CheckpointService: Checkpoint sin atributo Stage válido")
				continue
			end
			cp.Touched:Connect(function(hit)
				local character = hit.Parent
				local player = Players:GetPlayerFromCharacter(character)
				if not player then
					return
				end
				if not playerData[player] then
					playerData[player] = {Stage = 1, Deaths = 0}
				end
				if stage >= (playerData[player].Stage or 1) then
					playerData[player].Stage = stage
					updateUI(player)
				end
			end)
		end
	end

	if connections.playerAdded then
		connections.playerAdded:Disconnect()
	end
	connections.playerAdded = Players.PlayerAdded:Connect(function(player)
		playerData[player] = {Stage = 1, Deaths = 0}

		local function onCharacterAdded(character)
			-- Desconectar Died anterior si existe
			if connections[player] and connections[player].died then
				connections[player].died:Disconnect()
				connections[player].died = nil
			end

			-- Inicializar datos si no existen
			if not playerData[player] then
				playerData[player] = {Stage = 1, Deaths = 0}
			end

			-- Respawn seguro (único procedimiento)
			safeRespawn(player, character)

			-- Conectar muerte (solo una vez por personaje)
			local humanoid = character:WaitForChild("Humanoid", 10)
			if humanoid then
				if not connections[player] then
					connections[player] = {}
				end
				connections[player].died = humanoid.Died:Connect(function()
					if playerData[player] then
						playerData[player].Deaths = (playerData[player].Deaths or 0) + 1
						updateUI(player)
					end
				end)
			end
		end

		if connections[player] and connections[player].charAdded then
			connections[player].charAdded:Disconnect()
		end
		if not connections[player] then
			connections[player] = {}
		end
		connections[player].charAdded = player.CharacterAdded:Connect(onCharacterAdded)

		-- Si el personaje ya existe, llamar manualmente
		if player.Character then
			onCharacterAdded(player.Character)
		end
	end)

	if connections.playerRemoving then
		connections.playerRemoving:Disconnect()
	end
	connections.playerRemoving = Players.PlayerRemoving:Connect(function(player)
		if connections[player] then
			if connections[player].charAdded then
				connections[player].charAdded:Disconnect()
			end
			if connections[player].died then
				connections[player].died:Disconnect()
			end
			connections[player] = nil
		end
		playerData[player] = nil
	end)
end

function CheckpointService.RespawnAtCheckpoint(player, hrp)
	-- Mantener compatibilidad pero delegar a safeRespawn si es posible
	if not hrp or not hrp.Parent then
		return
	end
	local data = playerData[player]
	if not data then
		playerData[player] = {Stage = 1, Deaths = 0}
		data = playerData[player]
	end
	local stage = data.Stage or 1

	local map = Workspace:FindFirstChild("TrollObbyMap")
	if stage == 1 or not map then
		local targetCFrame = getSpawnCFrame(map)
		if hrp and hrp.Parent then
			hrp.Parent:PivotTo(targetCFrame)
		end
		return
	end

	local cpCFrame = getCheckpointSpawnCFrame(map, stage)
	if cpCFrame then
		if hrp and hrp.Parent then
			hrp.Parent:PivotTo(cpCFrame)
		end
	else
		warn(string.format("[TrollObby] CheckpointService: No se encontró checkpoint para Stage %d, usando spawn inicial", stage))
		local targetCFrame = getSpawnCFrame(map)
		if hrp and hrp.Parent then
			hrp.Parent:PivotTo(targetCFrame)
		end
	end
end

function CheckpointService.GetData(player)
	return playerData[player]
end

return CheckpointService
