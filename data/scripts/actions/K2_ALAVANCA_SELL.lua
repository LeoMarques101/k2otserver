local ALAVANCA = {
    [1945] = {usada = 1946},
    [1946] = {usada = 1945},
    [9825] = {usada = 9826},
    [9826] = {usada = 9825},
    [9827] = {usada = 9828},
    [9828] = {usada = 9827},
}

local ITEM_ALAVANCA =
	{    --Potions
	    [0] = {id = 7620, peso = 1.80, cargas = 100, custouni = 50, pesofixo = false},         -- mana potion
	    [1] = {id = 7589, peso = 2.00, cargas = 100, custouni = 90, pesofixo = false},         -- strong mana potion
	    [2] = {id = 7590, peso = 2.20, cargas = 100, custouni = 120, pesofixo = false},        -- great mana potion
	    [3] = {id = 7618, peso = 1.80, cargas = 100, custouni = 50, pesofixo = false},         -- healt potion
	    [4] = {id = 7588, peso = 2.00, cargas = 100, custouni = 90, pesofixo = false},         -- strong healt potion
	    [5] = {id = 7591, peso = 2.20, cargas = 100, custouni = 150, pesofixo = false},        -- great healt potion
	    [6] = {id = 8473, peso = 2.20, cargas = 100, custouni = 300, pesofixo = false},        -- ultimate healt potion
	    [7] = {id = 8472, peso = 2.20, cargas = 100, custouni = 300, pesofixo = false},        -- great spirt potion
	    --Runas
	    [8] = {id = 2268, peso = 0.70, cargas = 100, custouni = 135, pesofixo = false},        -- Sudden Death Rune
	    [9] = {id = 2273, peso = 2.10, cargas = 100, custouni = 175, pesofixo = false},        -- Ultimate Healing Rune
	    [10] = {id = 2278, peso = 2.10, cargas = 10, custouni = 700, pesofixo = false},        -- Paralyze Rune
	    [11] = {id = 2293, peso = 0.70, cargas = 100, custouni = 116, pesofixo = false},       -- Magic Wall Rune
	    [12] = {id = 2269, peso = 1.05, cargas = 100, custouni = 160, pesofixo = false},       -- Wild Growth Rune
	    [13] = {id = 2315, peso = 0.52, cargas = 100, custouni = 47, pesofixo = false},        -- Thunderstorm Rune
	    [14] = {id = 2274, peso = 0.52, cargas = 100, custouni = 57, pesofixo = false},        -- Avalanche Rune
	    [15] = {id = 2288, peso = 0.52, cargas = 100, custouni = 37, pesofixo = false},        -- Stone Shower Rune
	    [16] = {id = 2304, peso = 0.52, cargas = 100, custouni = 57, pesofixo = false},        -- Great Fireball Rune
	    --Treino
	    [17] = {id = 8209, peso = 12, cargas = 200, custouni = 100, pesofixo = true},          -- TREINO DE SWORD
	    [18] = {id = 12661, peso = 12, cargas = 200, custouni = 100, pesofixo = true},         -- TREINO DE AXE
	    [19] = {id = 10152, peso = 12, cargas = 200, custouni = 100, pesofixo = true},         -- TREINO DE CLUB
	    [20] = {id = 12318, peso = 12, cargas = 200, custouni = 100, pesofixo = true},         -- TREINO DE ML
	    [21] = {id = 12662, peso = 12, cargas = 200, custouni = 100, pesofixo = true},         -- TREINO DE DISTANCIA
	    --Distance
	    [22] = {id = 2389, peso = 20, cargas = 10, custouni = 9, pesofixo = false},            -- Spear
	    [23] = {id = 7378, peso = 25, cargas = 10, custouni = 15, pesofixo = false},           -- Royal spear
	    [24] = {id = 3965, peso = 22, cargas = 10, custouni = 25, pesofixo = false},           -- Hunting Spear
	    [25] = {id = 1294, peso = 3.60, cargas = 100, custouni = 10, pesofixo = false},         -- Small Stone
	    [26] = {id = 2410, peso = 5, cargas = 100, custouni = 25, pesofixo = false},            -- Throwing Knife
	    [27] = {id = 2399, peso = 2, cargas = 100, custouni = 42, pesofixo = false},            -- Throwing Star
	    [28] = {id = 7366, peso = 2, cargas = 100, custouni = 50, pesofixo = false},            -- Viper Star
	    [29] = {id = 7368, peso = 2, cargas = 100, custouni = 100, pesofixo = false},           -- Assassin Star
	    --Municao
	    [30] = {id = 2544, peso = 0.70, cargas = 100, custouni = 3, pesofixo = false},         -- Arrow
	    [31] = {id = 2545, peso = 0.80, cargas = 100, custouni = 4, pesofixo = false},         -- Poison Arrow
	    [32] = {id = 2546, peso = 0.90, cargas = 100, custouni = 10, pesofixo = false},        -- Burst Arrow
	    [33] = {id = 7364, peso = 0.70, cargas = 100, custouni = 5, pesofixo = false},         -- Sniper Arrow
	    [34] = {id = 7365, peso = 0.70, cargas = 100, custouni = 7, pesofixo = false},         -- Onyx Arrow
	    [35] = {id = 2543, peso = 0.80, cargas = 100, custouni = 4, pesofixo = false},         -- Bolt
	    [36] = {id = 7363, peso = 0.80, cargas = 100, custouni = 5, pesofixo = false},         -- Piercing Bolt
	    [37] = {id = 2547, peso = 0.80, cargas = 100, custouni = 7, pesofixo = false},         -- Power Bolt
	    [38] = {id = 6529, peso = 0.90, cargas = 100, custouni = 40, pesofixo = false},        -- Infernal Bolt
	    --Rings
	    [39] = {id = 6300, peso = 0.80, cargas = 1, custouni = 3000, pesofixo = false},        -- Death Ring
	    [40] = {id = 2216, peso = 0.80, cargas = 1, custouni = 2000, pesofixo = false},        -- Ring of Healing
	    [41] = {id = 2168, peso = 0.80, cargas = 1, custouni = 900, pesofixo = false},         -- Life Ring
	    [42] = {id = 2169, peso = 0.90, cargas = 1, custouni = 2000, pesofixo = false},        -- Time Ring
	    [43] = {id = 2204, peso = 0.80, cargas = 1, custouni = 2000, pesofixo = false},        -- Energy Ring
	    [44] = {id = 2165, peso = 1, cargas = 1, custouni = 5000, pesofixo = false},           -- Stealth Ring
	    [45] = {id = 2164, peso = 1, cargas = 1, custouni = 5000, pesofixo = false},           -- Might Ring
	    [46] = {id = 2213, peso = 1.10, cargas = 1, custouni = 2000, pesofixo = false},        -- Dwarven Ring
	    [47] = {id = 2212, peso = 0.90, cargas = 1, custouni = 500, pesofixo = false},         -- Club Ring
	    [48] = {id = 2208, peso = 0.90, cargas = 1, custouni = 500, pesofixo = false},         -- Axe Ring
	    [49] = {id = 2207, peso = 0.90, cargas = 1, custouni = 500, pesofixo = false},         -- Sword Ring
	    --Amulets
	    [50] = {id = 10221, peso = 7, cargas = 5, custouni = 600, pesofixo = true},            -- Shockwave Amulet
	    [51] = {id = 10220, peso = 7, cargas = 5, custouni = 600, pesofixo = true},            -- Leviathan's Amulet
	    [52] = {id = 10219, peso = 7, cargas = 5, custouni = 600, pesofixo = true},            -- Sacred Tree Amulet
	    [53] = {id = 10218, peso = 7, cargas = 5, custouni = 600, pesofixo = true},            -- Bonfire Amulet
	    [54] = {id = 7890, peso = 5, cargas = 200, custouni = 15, pesofixo = true},            -- Magma Amulet
	    [55] = {id = 7889, peso = 5, cargas = 200, custouni = 15, pesofixo = true},            -- Lightning pendant
	    [56] = {id = 7888, peso = 5, cargas = 200, custouni = 15, pesofixo = true},            -- Glacier amulet
	    [57] = {id = 7887, peso = 5, cargas = 200, custouni = 15, pesofixo = true},            -- Terra amulet
	    [58] = {id = 2201, peso = 6.30, cargas = 200, custouni = 5, pesofixo = true},          -- Dragon necklace
	    [59] = {id = 2199, peso = 3.80, cargas = 150, custouni = 0.66, pesofixo = true},       -- Garlic Necklace
	    [60] = {id = 2198, peso = 2.70, cargas = 50, custouni = 10, pesofixo = true},          -- Elven Amulet
	    [61] = {id = 2197, peso = 7.60, cargas = 5, custouni = 1000, pesofixo = true},         -- Stone Skin Amulet
	    [62] = {id = 2172, peso = 5, cargas = 200, custouni = 0.5, pesofixo = true},           -- Bronze Amulet
	    [63] = {id = 2170, peso = 5, cargas = 200, custouni = 0.5, pesofixo = true},           -- Silver Amulet
	    [64] = {id = 2161, peso = 2.90, cargas = 200, custouni = 0.5, pesofixo = true},        -- Strange Talisman
	    [65] = {id = 2173, peso = 4.20, cargas = 1, custouni = 50000, pesofixo = true},        -- Amulet of Loss
	    --Gemas
	    [66] = {id = 2150, peso = 0.10, cargas = 1, custouni = 500, pesofixo = false},         -- Small amethysts 
	    [67] = {id = 2149, peso = 0.10, cargas = 1, custouni = 500, pesofixo = false},         -- Small emeralds
	    [68] = {id = 2147, peso = 0.10, cargas = 1, custouni = 500, pesofixo = false},         -- Small rubies
	    [69] = {id = 2146, peso = 0.10, cargas = 1, custouni = 500, pesofixo = false},         -- Small sapphires
	    --Food
	    [70] = {id = 2666, peso = 13, cargas = 10, custouni = 5, pesofixo = false},            -- Meat
	    [71] = {id = 2667, peso = 5.20, cargas = 10, custouni = 5, pesofixo = false},          -- Fish
	    [72] = {id = 2671, peso = 20, cargas = 5, custouni = 10, pesofixo = false},            -- Ham 
	    [73] = {id = 2672, peso = 30, cargas = 5, custouni = 30, pesofixo = false},            -- Dragon Ham 
	    --tools
	    [74] = {id = 2554, peso = 35, cargas = 1, custouni = 100, pesofixo = true},            -- Shovel
	    [75] = {id = 2120, peso = 18, cargas = 1, custouni = 100, pesofixo = true},            -- Rope
	    [76] = {id = 2595, peso = 18, cargas = 1, custouni = 30, pesofixo = true},             -- Parcel 
	    [77] = {id = 2599, peso = 0.10, cargas = 1, custouni = 10, pesofixo = true},           -- Label
	    [78] = {id = 5942, peso = 5, cargas = 1, custouni = 15000, pesofixo = true},           -- blessed wooden stake
	    [79] = {id = 5908, peso = 1, cargas = 1, custouni = 10000, pesofixo = true},           -- obsidian knife
	    [80] = {id = 2004, peso = 18, cargas = 1, custouni = 30, pesofixo = true},             -- golden backpack
	    [81] = {id = 1997, peso = 8, cargas = 1, custouni = 10, pesofixo = true},              -- golden bag
	}


local MOVEIS_ALAVANCA = 
	{
        [0] = {id = 3903, peso = 25, name = "wooden chair"},
        [1] = {id = 3905, peso = 25, name = "sofa chair"},
        [2] = {id = 3901, peso = 25, name = "red cushioned chair"},
        [3] = {id = 3902, peso = 25, name = "green cushioned chair"},
        [4] = {id = 3906, peso = 25, name = "tusk chair"},
        [5] = {id = 3907, peso = 25, name = "ivory chair"},
        [6] = {id = 3904, peso = 25, name = "rocking chair"},
        [7] = {id = 3908, peso = 25, name = "small table"},
        [8] = {id = 3909, peso = 25, name = "square table"},
        [9] = {id = 3938, peso = 30, name = "small round table"},
        [10] = {id = 3913, peso = 35, name = "tusk table"},
        [11] = {id = 3912, peso = 35, name = "carved stone table"},
        [12] = {id = 3911, peso = 35, name = "big table"},
        [13] = {id = 3914, peso = 35, name = "bamboo table"},
        [14] = {id = 6114, peso = 35, name = "armor rack"},
        [15] = {id = 6115, peso = 35, name = "weapon rack"},
        [16] = {id = 3931, peso = 30, name = "large amphora"},

        [17] = {id = 11205, peso = 75, name = "dragon throne"},
        [18] = {id = 11126, peso = 55, name = "lizard weapon rack"},
        [19] = {id = 11133, peso = 65, name = "dragon statue"},
        [20] = {id = 3933, peso = 35, name = "piano"},
        [21] = {id = 6372, peso = 25, name = "oven"},
        [22] = {id = 8692, peso = 80, name = "chimney"},
        [23] = {id = 3927, peso = 30, name = "pendulum clock"},
        [24] = {id = 3917, peso = 30, name = "locker"},
        [25] = {id = 3921, peso = 35, name = "bamboo drawer"},
        [26] = {id = 6373, peso = 25, name = "bookcase"},

        [27] = {id = 3915, peso = 25, name = "drawer"},
        [28] = {id = 3916, peso = 25, name = "dresser"},
        [29] = {id = 3936, peso = 35, name = "thick trunk"},
        [30] = {id = 3935, peso = 35, name = "small trunk"},
        [31] = {id = 9974, peso = 25, name = "crystal table"},        
        [32] = {id = 3934, peso = 35, name = "harp"},
        [33] = {id = 3923, peso = 20, name = "globe"},
        [34] = {id = 3924, peso = 20, name = "table lamp"},
        [35] = {id = 3932, peso = 35, name = "coal basin"},
        [36] = {id = 3925, peso = 25, name = "telescope"},
        [37] = {id = 3918, peso = 30, name = "trough"},
        [38] = {id = 3920, peso = 35, name = "large trunk"},
        [39] = {id = 3926, peso = 35, name = "rocking horse"},
        [40] = {id = 3919, peso = 35, name = "barrel"},
        [41] = {id = 3937, peso = 30, name = "indoor plant"},
        [42] = {id = 3910, peso = 35, name = "christmas tree"},
        [43] = {id = 3922, peso = 20, name = "birdcage"},

        [44] = {id = 3928, peso = 30, name = "knight statue"},
        [45] = {id = 3929, peso = 30, name = "minotaur statue"},
        [46] = {id = 3930, peso = 25, name = "goblin statue"},
        
        [47] = {id = 5088, peso = 25, name = "monkey statue falar"},
        [48] = {id = 5087, peso = 25, name = "monkey statue escutar"},
        [49] = {id = 5086, peso = 25, name = "monkey statue ver"},

        [50] = {id = 12664, peso = 35, name = "hammock"},
        [51] = {id = 12663, peso = 35, name = "cot"},
        [52] = {id = 7907, peso = 35, name = "blue bed"},
        [53] = {id = 7905, peso = 35, name = "yellow bed"},
        [54] = {id = 7906, peso = 35, name = "red bed"},
        [55] = {id = 7904, peso = 35, name = "green bed"},

    }


local ACTION_AID = 1500
local MOVEMENT_AID = 1600

local itens_fromaid = 1500
local itens_toaid = 1581

local precos_fromaid = 1600
local precos_toaid = 1681

local moveis_fromaid = 1400
local moveis_toaid = 1455


local k2_alavanca_moveis = Action()
local k2_alavanca_itens = Action()
local k2_alavanca_precos = MoveEvent()


function k2_alavanca_moveis.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(ALAVANCA[item.itemid].usada)
	local key = item.actionid - moveis_fromaid
	local ShopItem = MOVEIS_ALAVANCA[key]
    local itemType = ItemType(ShopItem.id)
    local freecap = player:getFreeCapacity()/100
    local playermoney = player:getMoney()
    local custo = 500


	if ShopItem then
        if(custo > playermoney) then
            player:sendTextMessage(MESSAGE_INFO_DESCR, 'Voce precisa de '.. custo ..' golds para comprar '.. ShopItem.name .. '.')
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
        	if freecap >= ShopItem.peso then
		        player:addItem(ShopItem.id)
		        player:sendTextMessage(MESSAGE_INFO_DESCR, 'Voce comprou ' .. ShopItem.name .. ' por '.. custo ..' golds.')
		        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		        Game.sendAnimatedText("Comprou", player:getPosition(), 30)
		        player:removeMoney(custo)
		        return true
		    else

		    	player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce precisa de ".. ShopItem.peso .." cap para realizar a compra.")
            	player:getPosition():sendMagicEffect(CONST_ME_POFF)
            	return true

		   	end
        end     
    end
	return true
end

function k2_alavanca_itens.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(ALAVANCA[item.itemid].usada)

	local key = item.actionid - itens_fromaid
	local ShopItem = ITEM_ALAVANCA[key]
    local itemType = ItemType(ShopItem.id)
    local freecap = player:getFreeCapacity()/100
    local custo = ShopItem.custouni * ShopItem.cargas
    local playermoney = player:getMoney()
    local peso = 0

    if ShopItem.pesofixo then
    	peso = ShopItem.peso
    else
    	peso = ShopItem.peso * ShopItem.cargas
    end
    player:sendTextMessage(MESSAGE_INFO_DESCR, freecap)
    if ShopItem then
        if(custo > playermoney) then
            player:sendTextMessage(MESSAGE_INFO_DESCR, 'Voce precisa de '.. custo ..' golds para comprar '.. ShopItem.cargas ..' '.. itemType:getName() .. '.')
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
        	if freecap >= peso then
		        player:addItem(ShopItem.id, ShopItem.cargas)
		        player:sendTextMessage(MESSAGE_INFO_DESCR, 'Voce comprou '.. ShopItem.cargas ..' '.. itemType:getName() .. ' por '.. custo ..' golds.')
		        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		        Game.sendAnimatedText("Comprou", player:getPosition(), 30)
		        player:removeMoney(custo)
		        return true
		    else
		    	player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce precisa de ".. peso .." cap para realizar a compra.")
            	player:getPosition():sendMagicEffect(CONST_ME_POFF)
            	return true
		    end
    	end
    end
	return true
end

function k2_alavanca_precos.onStepIn(creature, item, position, fromPosition)
    local key = item.actionid - precos_fromaid
    local ShopItem = ITEM_ALAVANCA[key]
    local itemType = ItemType(ShopItem.id)
    local custo = ShopItem.cargas * ShopItem.custouni
    local peso = 0
    local str = ""

    if ShopItem.pesofixo then
        peso = ShopItem.peso
        
        str = "um(a) ".. itemType:getName() .." com ".. ShopItem.cargas .." cargas por: ".. custo .." golds. ["..peso.." oz]"
    else
        peso = ShopItem.cargas * ShopItem.peso

        str = ShopItem.cargas .." ".. itemType:getName() .." por: ".. custo .." golds. ["..peso.." oz]"
    end

    creature:sendTextMessage(MESSAGE_STATUS_DEFAULT, str)

	return true
end

for aid = precos_fromaid, precos_toaid do
    k2_alavanca_precos:aid(aid)
end

for aid = itens_fromaid, itens_toaid do
    k2_alavanca_itens:aid(aid)
end

for aid = moveis_fromaid, moveis_toaid do
    k2_alavanca_moveis:aid(aid)
end


k2_alavanca_precos:register()
k2_alavanca_moveis:register()
k2_alavanca_itens:register()