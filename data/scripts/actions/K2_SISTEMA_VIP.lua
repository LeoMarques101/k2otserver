-- executar o sql antes de tudo
-- ALTER TABLE `accounts` ADD `vipdays` int(11) NOT NULL DEFAULT 0;

function getPlayerVipDays(player)
    local Info = db.storeQuery("SELECT `vipdays` FROM `accounts` WHERE `id` = " .. player:getAccountId() .. " LIMIT 1")
        if Info ~= false then
	        local days = result.getNumber(Info, "vipdays")
	        result.free(Info)
	        return days
    	end
    return LUA_ERROR
	end

function doAddVipDays(player, days)
    db.query("UPDATE `accounts` SET `vipdays` = `vipdays` + " .. days .. " WHERE `id` = " .. player:getAccountId() .. ";")
    player:setStorageValue(20500, 1)
end

function doRemoveVipDays(player, days)
    db.query("UPDATE `accounts` SET `vipdays` = `vipdays` - " .. days .. " WHERE `id` = " .. player:getAccountId() .. ";")
end


local temple_tele = CreatureEvent("TempleTeleporter")
function temple_tele.onLogin(player)

    if getPlayerVipDays(player) > 0 then
    	player:setStorageValue(20500, 1)
    elseif getPlayerVipDays(player) == 0 and player:getStorageValue(20500) == 1 then
        player:teleportTo(player:getTown():getTemplePosition())
        player:setStorageValue(20500, -1)
    end
    return true
end

local vip_check = CreatureEvent("VipCheck")
function vip_check.onLogin(player)
	if getPlayerVipDays(player) >= 1 then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "You have ".. getPlayerVipDays(player) .." vip days left. !efeitovip para ativar ou desativar o efeito VIP.")
	end
	return true
end


local vip_efect = GlobalEvent("vipEffect")
function vip_efect.onThink(interval)

	local storage = 666     --storage vip efect
	for _, player in ipairs(Game.getPlayers()) do
	   if getPlayerVipDays(player) >= 1 and player:getStorageValue(storage) ~= 0 then
	   		player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
	    	Game.sendAnimatedText("VIP!", player:getPosition(), TEXTCOLOR_RED)
	   end
	end
	return true

end


local vip_days_remove = GlobalEvent("VipDaysRemover")
function vip_days_remove.onTime(interval)

	db.query("UPDATE accounts SET vipdays = vipdays - 1 WHERE vipdays > 0;")
	return true
end

local vip_tile = MoveEvent()
function vip_tile.onStepIn(creature, item, position, fromPosition)
	if getPlayerVipDays(creature) == 0 then
		creature:teleportTo(fromPosition, false)
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE,'Only VIP Account can go there.')
	end	
	return true
end

local vip_falcon = Action()
function vip_falcon.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if getPlayerVipDays(player) > 335 then
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can only have 1 year of vip account or less.")
	else
		doAddVipDays(player, 30)
		player:say("VIP!", TALKTYPE_YELL)
		player:popupFYI("We have added 30 vip days to your account!\nEnjoy it!.")
		item:remove(1)
	end
    return true

end

local vip_door = Action()
function vip_door.onUse(player, item, fromPosition, target, topos, isHotkey)

	if getPlayerVipDays(player) >= 1 then
		pos = player:getPosition()
		if pos.x == topos.x then
		   if pos.y < topos.y then
		      pos.y = topos.y + 1
		   else
		      pos.y = topos.y - 1
		   end
		elseif pos.y == topos.y then
	       if pos.x < topos.x then
	          pos.x = topos.x + 1
	       else
	          pos.x = topos.x - 1
	       end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Stand in front of the door.")
		return true
		end
		player:teleportTo(pos)
		topos:sendMagicEffect(CONST_ME_ENERGYHIT)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Only VIP Account can go there.')
	end
	return true
end

local efeitovip = TalkAction("!efeitovip")
function efeitovip.onSay(player)

	local storage = 666         --storage para o efeito vip
    if getPlayerVipDays(player) >= 1 then
        if(player:getStorageValue(storage) ~= 0) then
        	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Efeito VIP desativado!")
        	player:setStorageValue(storage, 0)
            return false
        else
        	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Efeito VIP ativado!")
        	player:setStorageValue(storage, 1)
            return false
        end
    else
    	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Voce nao e VIP!")
        return false
	end
end

local adddays = TalkAction("/adddays")
function adddays.onSay(player, words, param)
	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	local split = param:splitTrimmed(",")

	if not split[2] then
		player:sendCancelMessage("Insufficient parameters.")
		return true
	end

	split[2] = tonumber(split[2])
    if(not split[2]) then
		player:sendCancelMessage("Command requires numeric param.")
        return true
    end
	local target = Player(split[1])

	if not target then
		player:sendCancelMessage("A player with that name is not online.")
		return true
	end

	local dias = split[2]


    total_de_dias = getPlayerVipDays(target) + dias

    if total_de_dias > 365 then

        dias = 365 - getPlayerVipDays(target)
    end
    
    doAddVipDays(target, dias)

    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Voce acabou de adicionar ".. dias .." vip days para ".. target:getName())
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:getName() .." acabou de adicionar ".. dias .." vip days para sua conta.")

    return true

end

local removedays = TalkAction("/removedays")
function removedays.onSay(player, words, param)
	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	local split = param:splitTrimmed(",")

	if not split[2] then
		player:sendCancelMessage("Insufficient parameters.")
		return true
	end

	split[2] = tonumber(split[2])
    if(not split[2]) then
		player:sendCancelMessage("Command requires numeric param.")
        return true
    end
	local target = Player(split[1])

	if not target then
		player:sendCancelMessage("A player with that name is not online.")
		return true
	end

	local dias = split[2]


    total_de_dias = getPlayerVipDays(target) - dias

    if total_de_dias < 0 then
        dias = getPlayerVipDays(target)
    end
    
    doRemoveVipDays(target, dias)

    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Voce acabou de remover ".. dias .." vip days de ".. target:getName())
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:getName() .." acabou de remover ".. dias .." vip days de sua conta.")

    return true
end


local getvipdays = TalkAction("/getvipdays")
function getvipdays.onSay(player, words, param)
	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	local target = Player(param)

	if not target then
		player:sendCancelMessage("A player with that name is not online.")
		return true
	end

    dias = getPlayerVipDays(target)

    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,target:getName().." tem: ".. dias .." dias de VIP")

    return true
end

getvipdays:separator(" ")
getvipdays:register()

removedays:separator(" ")
removedays:register()

adddays:separator(" ")
adddays:register()

efeitovip:register()

vip_door:aid(2112)
vip_door:register()

vip_falcon:id(12424)
vip_falcon:register()

vip_tile:aid(11223)
vip_tile:register()

vip_days_remove:time("00:01")
vip_days_remove:register()

vip_efect:interval(1500)
vip_efect:register()

vip_check:register()
temple_tele:register()