local ALAVANCA = {
    [1945] = {usada = 1946},
    [1946] = {usada = 1945},
    [9825] = {usada = 9826},
    [9826] = {usada = 9825},
    [9827] = {usada = 9828},
    [9828] = {usada = 9827},
}


local stone ={
	[2100] = {id = 1304, pos = {x=1099,y=747,z=9,stackpos=1}, move_direction = DIRECTION_EAST},
}



local K2_ALAVANCA_STONE = Action()

function K2_ALAVANCA_STONE.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(ALAVANCA[item.itemid].usada)

	stonepos = Position(stone[item.actionid].pos)
	tilestone = Tile(stonepos)
	tileitens = tilestone:getItems()
	tilecriaturas = tilestone:getCreatures()

	for i,criatura in ipairs(tilecriaturas) do
		criatura:move(stone[item.actionid].move_direction)
	end


	if #tileitens > 0 then
		local count = 0
		for i,item_tile in ipairs(tileitens) do
			if item_tile:getId() == stone[item.actionid].id then
				count = count + 1
			end
			item_tile:remove(item_tile:getCount())
		end
		if count == 0 then
		Game.createItem(stone[item.actionid].id, 1, stonepos)
		end
		stonepos:sendMagicEffect(CONST_ME_GROUNDSHAKER)
		return false
	else
		Game.createItem(stone[item.actionid].id, 1, stonepos)
		stonepos:sendMagicEffect(CONST_ME_GROUNDSHAKER)
		return false
	end
	return true
end

K2_ALAVANCA_STONE:aid(2100)
K2_ALAVANCA_STONE:register()