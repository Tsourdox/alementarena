-- This file contains functions to help with common things in lua

-- Since this function is local it can only be called from this script file
local function printTable(table, nrOfTabs)
    if (nrOfTabs == 0) then
        print('|------TABLE------')
    end

    local tabs = ''
    for i=1, nrOfTabs do
        tabs = tabs .. '\t'
    end

	for k,v in pairs(table) do
        if (IsTable(v)) then
            print('|' .. tabs, k, '|---SUBTABLE---')
            printTable(v, nrOfTabs + 1)
            print('|')
        else
            print('|' .. tabs, k, v)
        end
	end

    if (nrOfTabs == 0) then
        print('|-----------------')
    end
end

-- Helper function to print tables, even prints tables within tables
function PrintTable(table) printTable(table, 0) end

-- Helper function to get the length of a table
function NrOf(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-- Helper function to find out if a variable is a table or not
function IsTable(t)
    return type(t) == 'table'
end