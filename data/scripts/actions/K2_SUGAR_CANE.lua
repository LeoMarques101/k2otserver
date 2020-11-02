local ITEM_IDS = {
	[5469] = 5513,
	[5470] = 5514
}

local BUNCH_OF_SUGAR = Action()
function BUNCH_OF_SUGAR.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if target:getId() == 5469 or target:getId() == 5470 then

		toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
		target:transform(ITEM_IDS[target:getId()])
		item:remove(1)
		target:decay()
		return true

	elseif target:getId() == 5513 or target:getId() == 5514 then
		return player:sendCancelMessage("This machine is processing a bunch already.")
	end
end


local SICKLE = Action()
function SICKLE.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if target:getId() == 5464 then
		target:transform(5463)
		Game.createItem(5467, 1, toPosition)
		target:decay()
		return true
	end
	return destroyItem(player, target, toPosition)

end

local FIRE_BUG = Action()
function FIRE_BUG.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target:getId() == 5466 then
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(5465)
			item:remove()
			target:decay()
			return true
	end
end

FIRE_BUG:id(5468)
FIRE_BUG:register()

SICKLE:id(2405)
SICKLE:register()

BUNCH_OF_SUGAR:id(5467)
BUNCH_OF_SUGAR:register()