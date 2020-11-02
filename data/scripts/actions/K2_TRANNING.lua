local staminaTries = 1 --# on minutes
local skillTries = 7 --# tries by blow
local skillSpent = function() return math.random(425, 575) end --# mana consumed by blow
local slotForUse = CONST_SLOT_AMMO

local dummies = {
    [5777] = { skillRate = 1, skillSpeed = 1 },
    [5787] = { skillRate = 1, skillSpeed = 1 }
}

local weapons = {
    [12318] = { shootEffect = CONST_ME_SMALLCLOUDS, shootDistEffect = CONST_ANI_DEATH, skillType = SKILL_MAGLEVEL }, -- magicLevel
    [12662] = { shootEffect = CONST_ME_HITAREA, shootDistEffect = CONST_ANI_HUNTINGSPEAR, skillType = SKILL_DISTANCE }, -- distance
    [8209] = { shootEffect = CONST_ME_HITAREA, skillType = SKILL_SWORD }, -- sword
    [12661] = { shootEffect = CONST_ME_HITAREA, skillType = SKILL_AXE }, -- axe
    [10152] = { shootEffect = CONST_ME_HITAREA, skillType = SKILL_CLUB } -- club
}

---@ EDTE is the global event table to control the system correctly.
if not EDTE then EDTE = {} end

---@ functions to assign or obtain the training status of a player.
function getPlayerExerciseTrain(player) return EDTE[player] or false end
function setPlayerExerciseTrain(player, status) EDTE[player] = status return status end

---@ local training function.
local function exerciseDummyTrainEvent(params, weapon)
    if params.player:isPlayer() then
        local item = params.player:getSlotItem(slotForUse)
        local playerPosition = params.player:getPosition()
        
        if getDistanceBetween(playerPosition, params.currentPos) == 0 and item.itemid == params.itemid then
            local weaponCharges = item:getAttribute("charges")
            local reloadMs = params.player:getVocation():getAttackSpeed() * params.dummy.skillSpeed
            if weaponCharges >= 1 then
            	item:setAttribute("charges",weaponCharges -1)

                if weapon.shootDistEffect then playerPosition:sendDistanceEffect(params.dummyPos, weapon.shootDistEffect) end

                if weapon.shootEffect then params.dummyPos:sendMagicEffect(weapon.shootEffect) end
                if weapon.skillType == SKILL_MAGLEVEL then
                	params.player:addManaSpent((skillSpent() * params.dummy.skillRate) * configManager.getNumber(configKeys.RATE_MAGIC))
                else
                	params.player:addSkillTries(weapon.skillType, (skillTries * params.dummy.skillRate) * configManager.getNumber(configKeys.RATE_SKILL))
                end
                local currentStamina = params.player:getStamina()
                params.player:setStamina(currentStamina + staminaTries)
                if weaponCharges <= 1 then
                    exerciseDummyTrainEvent(params, weapon)
                else
                    setPlayerExerciseTrain(params.player, addEvent(exerciseDummyTrainEvent, reloadMs, params, weapon))
                end
                return true
            else
            	item:remove(1)
                params.player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sua arma de exercicio expirou, portanto seu treinamento tambem.")
            end
        else
            params.player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce terminou seu treinamento.")
        end
    end
    return setPlayerExerciseTrain(params.player, nil)
end

local function k2tranning(player, item, target, toPosition)
	local ammo = player:getSlotItem(slotForUse)
    if ammo.uid ~= item.uid then
        return player:sendCancelMessage("A arma deve estar localizada em sua slot de municao.")
    end
    if not target then
        return player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
    end
    local playerPosition = player:getPosition()
    if not Tile(playerPosition):hasFlag(TILESTATE_PROTECTIONZONE) then
        return player:sendCancelMessage("Voce so pode treinar na zona de protecao.")
    end
    local dummy = dummies[target.itemid]
    local weapon = weapons[item.itemid]
    if not weapon or not dummy then
        return player:sendCancelMessage(RETURNVALUE_CANNOTUSETHISOBJECT)
    end
    local dummyPosition = toPosition
    
    if getDistanceBetween(playerPosition, dummyPosition) > 6 then
        return player:sendCancelMessage(RETURNVALUE_THEREISNOWAY)
    end
    
    if not getPlayerExerciseTrain(player) then
        local params = {}
        params.player = player
        params.currentPos = playerPosition
        params.dummyPos = dummyPosition
        params.itemid = item.itemid
        params.dummy = dummy
        exerciseDummyTrainEvent(params, weapon)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce comecou a treinar.")
    else
        player:sendCancelMessage("Voce nao pode treinar.")
    end
    return true
end

local weapons_long = Action()
function weapons_long.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return k2tranning(player, item, target, toPosition)
end


local weapons_short = Action()
function weapons_short.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    return k2tranning(player, item, target, toPosition)
end

weapons_short:id(8209,12661,10152)
weapons_short:register()


weapons_long:allowFarUse(true)
weapons_long:id(12318,12662)
weapons_long:register()