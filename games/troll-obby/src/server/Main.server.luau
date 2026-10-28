-- Servidor principal - inicialización única
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- Esperar a que los módulos estén sincronizados antes de requerirlos
local modulesFolder = script.Parent
local MapBuilder = require(modulesFolder:WaitForChild("MapBuilder", 10))
local TrapService = require(modulesFolder:WaitForChild("TrapService", 10))
local CheckpointService = require(modulesFolder:WaitForChild("CheckpointService", 10))

if not MapBuilder or not TrapService or not CheckpointService then
	warn("[TrollObby] Error: No se pudieron cargar los módulos del servidor")
	return
end

-- Crear RemoteEvent para UI solo si no existe
local remote = ReplicatedStorage:FindFirstChild("UpdateUI")
if not remote then
	remote = Instance.new("RemoteEvent")
	remote.Name = "UpdateUI"
	remote.Parent = ReplicatedStorage
end

-- Construir mapa una sola vez y verificar
local map = MapBuilder.Build()
if not map or not Workspace:FindFirstChild("TrollObbyMap") then
	warn("[TrollObby] Error crítico: No se pudo generar el mapa")
	return
end

-- Inicializar servicios solo después de que el mapa esté listo
TrapService.Init()
CheckpointService.Init()

print("[TrollObby] Servidor inicializado - Mapa generado correctamente")
