-- Boss teleport spawn script by mdwilliams.
-- https://otland.net/threads/tfs-1-2-portal-created-on-monster-death.265567/#post-2567024
-- Converted to TFS 1.3 Revscriptsys by Evil Hero.

local teleportToPosition = Position(1000, 1000, 7)
local teleportCreatePosition = Position(2000, 2000, 7)
local bossName = "boss monster"

local monstro = {
    ['k2 assassin'] = {teleport_pos = Position(1009,706,3),teleport_to = Position(1035,713,7),time_min=5},
}


-- Function that will remove the teleport after a given time
local function removeTeleport(position)
    local teleportItem = Tile(position):getItemById(1387)
    if teleportItem then
        teleportItem:remove()
        position:sendMagicEffect(CONST_ME_POFF)
    end
end

local event_boss = CreatureEvent("BossKill")
function event_boss.onKill(creature, target)
    if target:isPlayer() or target:getMaster() then
        print("é player ou summon")
        return false
    end

    local boss = monstro[target:getName():lower()]

    if boss then

        boss.teleport_pos:sendMagicEffect(CONST_ME_TELEPORT)
        local item = Game.createItem(1387, 1, boss.teleport_pos)

        if item:isTeleport() then
            item:setDestination(boss.teleport_to)
        end
        local killMessage = "You have killed Boss Monster! A teleport has been created but it will disappear in ".. boss.time_min .." minutes!"
        target:say(killMessage, TALKTYPE_MONSTER_SAY, 0, 0, target:getPosition())

        -- Remove portal after 5 minutes
        addEvent(removeTeleport, boss.time_min * 60 * 1000, boss.teleport_pos)
        print("é boss")
        return true

    else
        print("nao é boss")
        return false
    end
end

event_boss:register()

local login = CreatureEvent("RegisterBossKill")
function login.onLogin(player)
    player:registerEvent("BossKill")
    return true
end

login:register()