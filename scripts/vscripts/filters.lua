require('utils')

-- Split the amount of xp given evenly among all player heroes
function SplitExperienceFilter(_, event)
	local nrOfPlayers = PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_GOODGUYS)
	for i=1, nrOfPlayers do
		local playerID = PlayerResource:GetNthPlayerIDOnTeam(DOTA_TEAM_GOODGUYS, i)
		local player = PlayerResource:GetPlayer(playerID)
		local hero = player:GetAssignedHero()
		
		local perHeroExp = math.floor(event.experience / nrOfPlayers)
		hero:AddExperience(perHeroExp, event.reason_const, false, false)
		print('TotalXP: ' .. event.experience, 'Gave ' .. nrOfPlayers .. ' players ' .. perHeroExp .. ' xp each.')
	end
	return false -- disable default exp
end

-- Split the amount of gold given evenly among all players
function SplitGoldFilter(_, event)
    local nrOfPlayers = PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_GOODGUYS)
	for i=1, nrOfPlayers do
		local playerID = PlayerResource:GetNthPlayerIDOnTeam(DOTA_TEAM_GOODGUYS, i)
		local player = PlayerResource:GetPlayer(playerID)
		local hero = player:GetAssignedHero()
		
		local perHeroGold =  math.floor(event.gold / nrOfPlayers)
        local isReliable = true
		hero:ModifyGold(perHeroGold, isReliable, event.reason_const)
		print('TotalGold: ' .. event.gold, 'Gave ' .. nrOfPlayers .. ' players ' .. perHeroGold .. ' gold each.')
	end

    return false -- disable default gold
end