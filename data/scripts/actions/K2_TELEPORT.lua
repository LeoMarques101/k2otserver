local teleports = {
    [7801] = {pos = Position(1016, 854, 7)}, -- FIRE
    [7802] = {pos = Position(991, 832, 7)},	 -- ENERGY
	[7803] = {pos = Position(989, 860, 7)},	 -- ICE
	[7804] = {pos = Position(1010, 834, 7)}, -- EARTH
}
local fromaid = 7801
local toaid = 7804

local k2_teleport = MoveEvent()

function k2_teleport.onStepIn(creature, item, position, fromPosition)
	
	position:sendMagicEffect(CONST_ME_POFF)
	creature:teleportTo(teleports[item.actionid].pos)
	teleports[item.actionid].pos:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end


for aid=fromaid,toaid do
	k2_teleport:aid(aid)
end

k2_teleport:register()