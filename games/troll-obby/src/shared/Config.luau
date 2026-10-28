-- Configuración central para Troll Obby: Trust Nothing!
local Config = {}

Config.TOTAL_STAGES = 12
Config.RESPAWN_HEIGHT = -50

Config.COLORS = {
	START = Color3.fromRGB(60, 255, 120),
	STAGE = Color3.fromRGB(90, 200, 255),
	FAKE = Color3.fromRGB(255, 90, 200),
	TRAP = Color3.fromRGB(255, 60, 60),
	CHECKPOINT = Color3.fromRGB(255, 230, 90),
	META = Color3.fromRGB(160, 90, 255),
	FLOOR = Color3.fromRGB(40, 40, 60),
}

Config.STAGE_SPACING = 14
Config.PLATFORM_SIZE = Vector3.new(8, 1, 8)
Config.PATH_WIDTH = 8

Config.FAKE_PLATFORM_DELAY = 0.6
Config.FAKE_PLATFORM_RECOVER = 2.0

return Config
