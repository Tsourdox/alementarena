-- This file is used to define data about each level.
-- Kind of like a bluprint for what the current state of the game is.
require('utils')

-- Local version of the default levelsTable
local defaultLevelsTable = {{
    unitName = "npc_dota_creature_level_1",
    unitCount = 2,
    unitsKilled = 0
},{
    unitName = "npc_dota_creature_level_2",
    unitCount = 1,
    unitsKilled = 0,
}, {
    unitName = "npc_dota_creature_level_1",
    unitCount = 7,
    unitsKilled = 0
}, {
    unitName = "npc_dota_creature_level_2",
    unitCount = 3,
    unitsKilled = 0
}}

-- Gives you a copy of the original levels table
function GetDefaultLevelsTable()
    -- Make a copy so we dont accedently modify the original data
    return Merge({}, defaultLevelsTable)
end