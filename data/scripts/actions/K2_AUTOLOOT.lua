--[[
https://otland.net/threads/simple-auto-loot-system-tfs-1-3.273071/
https://github.com/otland/forgottenserver/compare/master...rookgaard:feature/autoloot

CREATE TABLE IF NOT EXISTS `player_autoloot` (
  `player_id` int(11) NOT NULL,
  `list` blob,
  UNIQUE KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

]]


local k2_autoloot = TalkAction("!autoloot")
function k2_autoloot.onSay(player, words, param)

    info = {
        Money_ids = {2148, 2152, 2160}, -- id das moedas do ot
    }


    local str = {
        "|=======| Commands |=======|\n",
        "!autoloot [add/remove], [itemID/name]\n",
        "!autoloot money\n",
        "!autoloot clear\n",
    }


    if (param == '') then
        local list = player:getAutoLootList()

        if (not list) then
            player:sendCancelMessage("Sua lista de AutoLoot esta vazia, use: !autoloot [add/remove], [itemID/name]")
            return false
        end

        local text = "|=======| Loot List |=======|\n"

        for _, itemID in ipairs(list) do
            local itemType = ItemType(itemID)
            text = text .."\n".._.." - ".. itemType:getName() .. ' [ID: ' .. itemID .. '] '
        end

        player:showTextDialog(7726, text)
        return false
        --return player:sendTextMessage(MESSAGE_INFO_DESCR, text:sub(1, -3) .. '.')
    end

    local params = param:split(",")

    if (not params[2]) then
        player:sendCancelMessage("faltando itemID ou nome, use: !autoloot [add/remove], [itemID/name]")
        return false
    end

    if (params[1] == 'add' or params[1] == 'remove') then
        local itemType = ItemType(params[2]:trim())

        if (itemType:getId() == 0) then
            itemType = ItemType(tonumber(params[2]:trim()))
        end

        if (itemType:getName() == '') then
            player:sendCancelMessage("Nao existe nenhum item com esse ID ou nome.")
            return false
        end

        if (params[1] == 'add') then
            if (player:addAutoLootItem(itemType:getId())) then
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce adicionou " .. itemType:getName() .. ' para o seu AutoLoot!')
                return false
            end

            return not player:sendCancelMessage("Este item ja esta na sua lista!")
        elseif (params[1] == 'remove') then
            if (player:removeAutoLootItem(itemType:getId())) then
                player:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce removeu " .. itemType:getName() .. ' de seu AutoLoot!')
                return false
            end

            player:sendCancelMessage("Este item nao esta na sua lista!")
            return false
        end
    end

    player:sendCancelMessage("Parametro incorreto, use: !autoloot [add/remove], [itemID/name]")
    return false

end


k2_autoloot:separator(" ")
k2_autoloot:register()