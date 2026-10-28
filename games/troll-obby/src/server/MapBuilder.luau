-- Genera el mapa prototipo una sola vez para evitar duplicados
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Config = require(ReplicatedStorage.Shared.Config)

local MapBuilder = {}

function MapBuilder.Build()
	if Workspace:FindFirstChild("TrollObbyMap") then
		return Workspace:FindFirstChild("TrollObbyMap")
	end

	local success, result = pcall(function()
		local map = Instance.new("Model")
		map.Name = "TrollObbyMap"
		map.Parent = Workspace

		local folder = Instance.new("Folder")
		folder.Name = "Geometry"
		folder.Parent = map

		local checkpointsFolder = Instance.new("Folder")
		checkpointsFolder.Name = "Checkpoints"
		checkpointsFolder.Parent = map

		local trapsFolder = Instance.new("Folder")
		trapsFolder.Name = "Traps"
		trapsFolder.Parent = map

		-- Piso base
		local base = Instance.new("Part")
		base.Name = "Base"
		base.Anchored = true
		base.CanCollide = true
		base.Material = Enum.Material.SmoothPlastic
		base.Color = Config.COLORS.FLOOR
		base.Size = Vector3.new(24, 1, 24)
		base.CFrame = CFrame.new(0, 0, 0)
		base.Parent = folder

		-- Start - plataforma de inicio segura
		local start = Instance.new("Part")
		start.Name = "StartPlatform"
		start.Anchored = true
		start.CanCollide = true
		start.Material = Enum.Material.Neon
		start.Color = Config.COLORS.START
		start.Size = Config.PLATFORM_SIZE
		start.CFrame = CFrame.new(0, 1, -12)
		start.Parent = folder

		-- Meta
		local meta = Instance.new("Part")
		meta.Name = "MetaPlatform"
		meta.Anchored = true
		meta.CanCollide = true
		meta.Material = Enum.Material.Neon
		meta.Color = Config.COLORS.META
		meta.Size = Config.PLATFORM_SIZE * Vector3.new(1.2, 1, 1.2)
		meta.CFrame = CFrame.new(0, 1, Config.STAGE_SPACING * Config.TOTAL_STAGES + 4)
		meta.Parent = folder

		local metaLabel = Instance.new("BillboardGui")
		metaLabel.Size = UDim2.new(4, 0, 1, 0)
		metaLabel.StudsOffset = Vector3.new(0, 3, 0)
		metaLabel.AlwaysOnTop = true
		metaLabel.Parent = meta
		local metaText = Instance.new("TextLabel")
		metaText.Size = UDim2.new(1, 0, 1, 0)
		metaText.BackgroundTransparency = 1
		metaText.TextScaled = true
		metaText.Font = Enum.Font.GothamBold
		metaText.TextColor3 = Color3.new(1, 1, 1)
		metaText.TextStrokeTransparency = 0.4
		metaText.Text = "META - ¡LO LOGRASTE!"
		metaText.Parent = metaLabel

		-- Generar 12 etapas
		for i = 1, Config.TOTAL_STAGES do
			local z = -4 + i * Config.STAGE_SPACING
			local stageFolder = Instance.new("Folder")
			stageFolder.Name = "Stage" .. i
			stageFolder.Parent = folder

			-- Plataforma principal de etapa
			local platform = Instance.new("Part")
			platform.Name = "Platform"
			platform.Anchored = true
			platform.CanCollide = true
			platform.Material = Enum.Material.SmoothPlastic
			platform.Color = Config.COLORS.STAGE
			platform.Size = Config.PLATFORM_SIZE
			platform.CFrame = CFrame.new(0, 1, z)
			platform.Parent = stageFolder

			-- Checkpoint
			local cp = Instance.new("Part")
			cp.Name = "Checkpoint"
			cp.Anchored = true
			cp.CanCollide = true
			cp.CanQuery = true
			cp.Material = Enum.Material.Neon
			cp.Color = Config.COLORS.CHECKPOINT
			cp.Shape = Enum.PartType.Cylinder
			cp.Size = Vector3.new(0.4, 3, 3)
			cp.CFrame = CFrame.new(0, 2.7, z) * CFrame.Angles(0, 0, math.rad(90))
			cp.Parent = checkpointsFolder
			cp:SetAttribute("Stage", i)

			local cpGui = Instance.new("BillboardGui")
			cpGui.Size = UDim2.new(2, 0, 1, 0)
			cpGui.StudsOffset = Vector3.new(0, 2, 0)
			cpGui.AlwaysOnTop = true
			cpGui.Parent = cp
			local cpText = Instance.new("TextLabel")
			cpText.Size = UDim2.new(1, 0, 1, 0)
			cpText.BackgroundTransparency = 1
			cpText.TextScaled = true
			cpText.Font = Enum.Font.GothamBold
			cpText.TextColor3 = Color3.new(1, 1, 1)
			cpText.TextStrokeTransparency = 0.3
			cpText.Text = "ETAPA " .. i
			cpText.Parent = cpGui

			-- Troll: plataformas falsas en etapas 2, 5, 7, 9, 11
			if i == 2 or i == 5 or i == 7 or i == 9 or i == 11 then
				local fake = Instance.new("Part")
				fake.Name = "FakePlatform"
				fake.Anchored = true
				fake.CanCollide = true
				fake.Material = Enum.Material.ForceField
				fake.Color = Config.COLORS.FAKE
				fake.Size = Config.PLATFORM_SIZE
				fake.CFrame = CFrame.new(4, 1, z)
				fake.Parent = stageFolder
				fake:SetAttribute("Fake", true)
				fake:SetAttribute("OriginalCFrame", fake.CFrame)
				fake:SetAttribute("Fallen", false)
			end

			-- Trampas en etapas 3, 6, 8, 10, 12
			if i == 3 or i == 6 or i == 8 or i == 10 or i == 12 then
				local trap = Instance.new("Part")
				trap.Name = "KillTrap"
				trap.Anchored = true
				trap.CanCollide = false
				trap.Material = Enum.Material.Neon
				trap.Color = Config.COLORS.TRAP
				trap.Size = Vector3.new(Config.PLATFORM_SIZE.X, 0.2, Config.PLATFORM_SIZE.Z)
				trap.CFrame = CFrame.new(-4, 1.1, z)
				trap.Parent = trapsFolder
				trap:SetAttribute("Kill", true)
			end
		end

		-- Luz ambiental para estética colorida
		local light = Instance.new("PointLight")
		light.Brightness = 1.2
		light.Range = 80
		light.Color = Color3.fromRGB(150, 200, 255)
		light.Parent = base

		return map
	end)

	if not success then
		warn("[TrollObby] MapBuilder: Error al construir mapa - " .. tostring(result))
		if Workspace:FindFirstChild("TrollObbyMap") then
			Workspace.TrollObbyMap:Destroy()
		end
		return nil
	end

	return result
end

return MapBuilder
