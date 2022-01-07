require('utils')

function Activate()
 print('Script is beeing activaded!') -- what does this mean, when is this function called?
end

-- Finds all player heroes and returns them as an indexable table
local function getHeroPool()
    local table = {}
    local nrOfPlayers = PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_GOODGUYS)
	for i=1, nrOfPlayers do
		local playerID = PlayerResource:GetNthPlayerIDOnTeam(DOTA_TEAM_GOODGUYS, i)
		local player = PlayerResource:GetPlayer(playerID)
		table[i] = player:GetAssignedHero()
    end

    return table
end

-- Split the amount of xp given evenly among all player heroes
function SplitExperienceFilter(_, event)
	local heroes = getHeroPool()
	for _,hero in pairs(heroes) do
		local perHeroExp = math.floor(event.experience / NrOf(heroes))
		hero:AddExperience(perHeroExp, event.reason_const, false, false)
		print('TotalXP: ' .. event.experience, 'Gave ' .. NrOf(heroes) .. ' players ' .. perHeroExp .. ' xp each.')
	end
	return false -- disable default exp
end

-- Split the amount of gold given evenly among all players
function SplitGoldFilter(_, event)
    local heroes = getHeroPool()
	for _,hero in pairs(heroes) do
		local perHeroGold =  math.floor(event.gold / NrOf(heroes))
        local isReliable = true
		hero:ModifyGold(perHeroGold, isReliable, event.reason_const)
		print('TotalGold: ' .. event.gold, 'Gave ' .. NrOf(heroes) .. ' players ' .. perHeroGold .. ' gold each.')
	end

    return false -- disable default gold
end