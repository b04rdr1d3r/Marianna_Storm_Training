-- Spawn 2 Random Air traffic
-- based on groups placed on template // 
-- two choppers and two transports
local blackhawk=RAT:New("blackhawk_rat")
local hercules=RAT:New("hercules_rat")

blackhawk:Spawn(2)
hercules:Spawn(2)