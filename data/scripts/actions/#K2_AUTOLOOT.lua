info = {
        OnlyPremium = true,
        AutomaticDeposit = true,
        BlockMonsters = {},
        BlockItemsList = {}
        }

    function setPlayerStorageTable(player, storage, tab)
        local tabstr = "&"
        for i,x in pairs(tab) do
            tabstr = tabstr .. i .. "," .. x .. ";"
        end
        player:setStorageValue(storage,tabstr:sub(1, #tabstr-1))
    end

    function getPlayerStorageTable(player, storage)
        local tabstr = player:getStorageValue(storage)
        local tab = {}
        if type(tabstr) ~= "string" then
                return {}
        end
        if tabstr:sub(1,1) ~= "&" then
                return {}
        end
        local tabstr = tabstr:sub(2, #tabstr)
        local a = string.explode(tabstr, ";")
        for i,x in pairs(a) do
                local b = string.explode(x, ",")
                tab[tonumber(b[1]) or b[1]] = tonumber(b[2]) or b[2]
        end
        return tab
    end

    function isInTable(player, item)
        for _,i in pairs(getPlayerStorageTable(player, 27000))do
         if tonumber(i) == tonumber(item) then
            return true
         end
        end
        return false
    end

    function addItemTable(player, item)
        local x = {}
        for i = 1,#getPlayerStorageTable(player, 27000) do
            table.insert(x,getPlayerStorageTable(player, 27000)[i])
        end
        if x ~= 0 then
          table.insert(x,tonumber(item))
          setPlayerStorageTable(player, 27000, x)
        else
           setPlayerStorageTable(player, 27000, {item})
        end
    end

    function removeItemTable(player, item)
        local x = {}
            for i = 1,#getPlayerStorageTable(player, 27000) do
                table.insert(x,getPlayerStorageTable(player, 27000)[i])
            end
            for i,v in ipairs(x) do
                if tonumber(v) == tonumber(item) then
                    table.remove(x,i)
                end
            end
        return setPlayerStorageTable(player, 27000, x)
    end

    function ShowItemsTabble(player)
        local str,n = "-- My Loot List --\n\n",0
        for i = 1,#getPlayerStorageTable(player, 27000) do
            n = n + 1
            str = str..""..n.." - "..ItemType(getPlayerStorageTable(player, 27000)[i]):getname().."\n"
        end
        return doShowTextDialog(cid, 2529, str)
    end


    function getContainerItems(containeruid)
        local items = {}
        local containers = {}

        local container = Container(containeruid)

        --??
        if type(container:getSize()) ~= "number" then
                return false
        end

        for slot = 0, container:getSize()-1 do
                local item = container:getItem(slot)
                if item.getId() == 0 then
                        break
                end

                if Container(item.uid) then
                    table.insert(containers, item.uid)
                end

                table.insert(items, item)
        end

        if #containers > 0 then
                for i,x in ipairs(getContainerItems(containers[1])) do
                        table.insert(items, x)
                end
                table.remove(containers, 1)
        end    
        return items
    end

--[[
    function getItemsInContainerById(containeruid, itemid) -- Function By Kydrai
        local items = {}
        local container = Container(containeruid)
        if container and container:getSize() > 0 then
            for slot=0, (container:getSize()-1) do
                local item = container:getItem(slot)
                if Container(item.uid) then
                    local itemsbag = getItemsInContainerById(item.uid, itemid)
                    for i=0, #itemsbag do
                        table.insert(items, itemsbag[i])
                    end
                else
                    if itemid == item.getId() then
                        table.insert(items, item.uid)
                    end
                end
            end
        end
        return items
    end

    function doPlayerAddItemStacking(player, itemid, quant) -- by mkalo
        local items = getItemsInContainerById(player:getSlotItem(3).uid, itemid)
        local piles = 0
        if #items > 0 then
                for i,id in pairs(items) do

                    local tmp_item = ItemType(id)

                        if ItemType(id):getType() < 100 then
                                local it = ItemType(id)

                                doTransformItem(it.uid, itemid, it.type+quant)
                                if it.type+quant > 100 then
                                        doPlayerAddItem(cid, itemid, it.type+quant-100)
                                end
                        else
                               piles = piles+1
                        end
                end
        else
                return doPlayerAddItem(cid, itemid, quant)
        end
        if piles == #items then
                doPlayerAddItem(cid, itemid, quant)
        end
    end
]]
    
    --refazer
    function AutomaticDeposit(cid,item,n)
        local deposit = item == tonumber(2160) and (n*10000) or tonumber(item) == 2152 and (n*100) or (n*1)
        return doPlayerDepositMoney(cid, deposit)
    end

    function corpseRetireItems(player, corpose)

        local items = getContainerItems(corpose.uid)

        for i,item in pairs(items) do
            if table.contains(getPlayerStorageTable(player, 27000), item:getId()) then
                --player:addItem(itemId[, count = 1[, canDropOnMap = true[, subType = 1[, slot = CONST_SLOT_WHEREEVER]]]])
                player:addItem(item:getId(),item:getCount())
                item:remove(item:getCount())

            end
        end

    end
--[[
    function corpseRetireItems(player, pos)
        local check = false

        for i = 0, 255 do
            pos.stackpos = i
            tile = getTileThingByPos(pos)
            if tile.uid > 0 and isCorpse(tile.uid) then
                check = true break
            end
        end

        if check == true then
            local items = getContainerItems(tile.uid)
            for i,x in pairs(items) do
                if isInArray(getPlayerStorageTable(cid, 27000), tonumber(x.itemid)) then
                    if isItemStackable(x.itemid) then
                        doPlayerAddItemStacking(cid, x.itemid, x.type)
                        if info.AutomaticDeposit == true and isInArray({"2148","2152","2160"},tonumber(x.itemid)) then
                            AutomaticDeposit(cid,x.itemid,x.type)
                        end
                    else
                        doPlayerAddItem(cid, x.itemid)
                    end
                    doRemoveItem(x.uid)
                end
            end
        end
        
    end

]]

local creatureevent = CreatureEvent("example")
function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)

    corpseRetireItems(mostDamageKiller, corpse)

    return true
end

local autoloot = TalkAction("!autoloot")
function autoloot.onSay(player, words, param)

    local split = param:splitTrimmed(",")

    if not split[2] then
        ShowItemsTabble(player)
        return false
    end

    local item = ItemType(split[2])
    if item then
        if split[1] == "add" then
            addItemTable(player, item:getId())
        elseif split[1] == "remove" then
            removeItemTable(player, item:getId())
        else

        end
    else
        player:sendCancelMessage("Item nao existe.")
    end
end


autoloot:separator(" ")
autoloot:register()


creatureevent:register()