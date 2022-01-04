-- Generated from template
require('game_setup')

if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = CAddonTemplateGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function CAddonTemplateGameMode:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink("OnThink", self, "GlobalThink", 2)

	GameSetup:init()

	-- for i=1, 10 do
	-- 	CreateUnitByName("Ollieboo", Vector(500, -1500, 0), true, nil, nil, DOTA_TEAM_BADGUYS)
	-- end

	-- for i=1, 10 do
	-- 	CreateUnitByName("NinjaMaestro", Vector(-1600, 900, 0), true, nil, nil, DOTA_TEAM_BADGUYS)
	-- end

end

-- Evaluate the state of the game
function CAddonTemplateGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end