local toolteste = Action()

function toolteste.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED,configManager.getNumber(configKeys.KILLS_TO_RED))

--[[
player:setStorageValue(storage,"&221,223")
local container = Container(target.uid)

if container then

	local txt = ""
	local testes = {
		"getSize: "..container:getSize(),
		"\ngetCapacity: "..container:getCapacity(),
		"\ngetEmptySlots: "..container:getEmptySlots(),
		"\ngetContentDescription: "..container:getContentDescription(),
		"\ngetItemHoldingCount: "..container:getItemHoldingCount(),
	}

	for i,linha in ipairs(testes) do
		txt = txt..linha
	end

	if container:addItem(2160,50) then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,"funcionou!")
	else
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED,"nao deu :/")
	end

	player:showTextDialog(7726,txt)
else
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED,"nao e um container")
end

	
	--local itemx = Item(target.uid)
	--local item_target = ItemType(itemx:getId())

	--player:showTextDialog(7726,"tipo: "..itemx:getId())
	]]
end

toolteste:id(10511)
toolteste:register()