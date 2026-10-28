-- Cliente UI para Troll Obby
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TrollObbyUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 70)
frame.Position = UDim2.new(0.5, -110, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local stageLabel = Instance.new("TextLabel")
stageLabel.Size = UDim2.new(1, 0, 0.5, 0)
stageLabel.Position = UDim2.new(0, 0, 0, 0)
stageLabel.BackgroundTransparency = 1
stageLabel.Font = Enum.Font.GothamBold
stageLabel.TextScaled = true
stageLabel.TextColor3 = Color3.fromRGB(90, 200, 255)
stageLabel.TextStrokeTransparency = 0.3
stageLabel.Text = "ETAPA: 1 / 12"
stageLabel.Parent = frame

local deathLabel = Instance.new("TextLabel")
deathLabel.Size = UDim2.new(1, 0, 0.5, 0)
deathLabel.Position = UDim2.new(0, 0, 0.5, 0)
deathLabel.BackgroundTransparency = 1
deathLabel.Font = Enum.Font.Gotham
deathLabel.TextScaled = true
deathLabel.TextColor3 = Color3.fromRGB(255, 90, 120)
deathLabel.TextStrokeTransparency = 0.3
deathLabel.Text = "MUERTES: 0"
deathLabel.Parent = frame

-- Esperar a que el servidor cree el RemoteEvent (con timeout para evitar yield infinito)
local remote = ReplicatedStorage:WaitForChild("UpdateUI", 10)
if not remote then
	warn("[TrollObby] UI: UpdateUI no encontrado, el servidor puede no haber inicializado")
	return
end

remote.OnClientEvent:Connect(function(stage, deaths)
	stageLabel.Text = "ETAPA: " .. tostring(stage) .. " / 12"
	deathLabel.Text = "MUERTES: " .. tostring(deaths or 0)
end)
