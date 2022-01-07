-- Generated from template
require('utils')
require('game_setup')
require('filters')

if ArenaGame == nil then
	ArenaGame = class({})
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
	GameRules.AddonTemplate = ArenaGame()
	GameRules.AddonTemplate:InitGameMode()
end

function ArenaGame:InitGameMode()
	print( "Template addon is loaded." )
	
	-- Define levels
	self.currentLevel = 1
	self.levelsTable = {
		[1] = {
			unitName = "npc_dota_creature_level_1",
			unitCount = 2,
			unitsKilled = 0
		}, [2] = {
			unitName = "npc_dota_creature_level_2",
			unitCount = 1,
			unitsKilled = 0,
		}, [3] = {
			unitName = "npc_dota_creature_level_1",
			unitCount = 7,
			unitsKilled = 0
		}, [4] = {
			unitName = "npc_dota_creature_level_2",
			unitCount = 3,
			unitsKilled = 0
		}
	}
	
	local gameMode = GameRules:GetGameModeEntity()
	GameSetup:Init()
	
	-- Delay execution for:
	gameMode:SetThink("OnThink", self, "GlobalThink", 0)
	gameMode:SetThink("StartNextLevel", self, "SNL", 3)
	
	-- Highjack built-in game events to our liking!
	ListenToGameEvent("entity_killed", Dynamic_Wrap(self, "OnEntityKilled"), self)
	
	-- Apply overrides to build-in beviours
	gameMode:SetModifyExperienceFilter(SplitExperienceFilter, self)
	gameMode:SetModifyGoldFilter(SplitGoldFilter, self)
end

function ArenaGame:GetLevel()
	return self.levelsTable[self.currentLevel]
end

function ArenaGame:StartNextLevel()
	print('START LEVEL!')
	local level = self:GetLevel()
	
	-- Open portals?
	-- Add portal sounds
	-- After a short delay we spawn creatures
	-- Or do we spawn directly, or maybe both?
	-- How do we decide where to spawn creatures?
	-- Is it always the same number of units?
	local location = RandomVector(800)
	for i=1, level.unitCount do
		CreateUnitByName(level.unitName, location, true, nil, nil, DOTA_TEAM_BADGUYS)
		print('unit created', location)
	end
end

function ArenaGame:OnEntityKilled(args)
	local unit = EntIndexToHScript(args.entindex_killed)
	if unit ~= nil then
		print('Unit was killed', unit:GetName())
		if unit:GetTeam() == DOTA_TEAM_BADGUYS then
			-- A level unit was killed
			self:GetLevel().unitsKilled = self:GetLevel().unitsKilled + 1
			self:CheckGameState()
		end
	end
end

function ArenaGame:CheckGameState()
	local level = self:GetLevel()
	if (level.unitsKilled == level.unitCount) then
		print('Level Complete')
		self.currentLevel = self.currentLevel + 1
		GameRules:GetGameModeEntity():SetThink("StartNextLevel", self, "SNL", 5)
	end
end

-- Evaluate the state of the game
function ArenaGame:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		-- print( "Template addon script is running.", GameRules:GetGameTime())
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	-- Calls this function again after 1 second
	return 1
end