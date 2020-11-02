local ALAVANCA_BLESS = {
    [1301] = {number = 1, nome = "The Wisdom of Solitude"},
    [1302] = {number = 2, nome = "The Spark of the Phoenix"},
    [1303] = {number = 3, nome = "The Fire of the Suns"},
    [1304] = {number = 4, nome = "The Spiritual Shielding"},
    [1305] = {number = 5, nome = "The Embrace of Tibia"}
    }

    --venda de bless
local CUSTO_BLESS = 20000

local k2_alavanca_bless = Action()

function k2_alavanca_bless.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(ALAVANCA[item.itemid].usada)
	local playermoney = player:getMoney()

    if(player:hasBlessing(ALAVANCA_BLESS[item.actionid].number)) then
        player:sendTextMessage(MESSAGE_INFO_DESCR,"Voce ja tem essa bless!")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    else
        if playermoney >= CUSTO_BLESS then
            player:sendTextMessage(MESSAGE_INFO_DESCR,ALAVANCA_BLESS[item.actionid].nome.." concedida!!!")
            player:removeMoney(CUSTO_BLESS)
            player:addBlessing(ALAVANCA_BLESS[item.actionid].number)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR,"Voce nao tem ".. CUSTO_BLESS .." gps para comprar essa bless!")
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
        end
    end

end


local k2_alavanca_bless_talk = TalkAction("!bless")

function k2_alavanca_bless_talk.onSay(player, words, param)

	texto = "|=================| Bless |=================|\n\n"
    bless1 = "\n1-The Wisdom of Solitude: ".. (player:hasBlessing(1) and "Possui +8%" or "Nao Possui")
    bless2 = "\n2-The Spark of the Phoenix: "..(player:hasBlessing(2) and "Possui +8%" or "Nao Possui")
    bless3 = "\n3-The Fire of the Suns: "..(player:hasBlessing(3) and "Possui +8%" or "Nao Possui")
    bless4 = "\n4-The Spiritual Shielding: "..(player:hasBlessing(4) and "Possui +8%" or "Nao Possui")
    bless5 = "\n5-The Embrace of Tibia: "..(player:hasBlessing(5) and "Possui +8%" or "Nao Possui")

    Promoted ="0-Promoted: ".. ( (player:getStorageValue(STORAGEVALUE_PROMOTION) >= 1 and player:isPremium()) and "Possui +30%" or "Nao Possui")

    -- calculo de bonus
    valbless1 = (player:hasBlessing(1) and 1 or 0)
    valbless2 = (player:hasBlessing(2) and 1 or 0)
    valbless3 = (player:hasBlessing(3) and 1 or 0)
    valbless4 = (player:hasBlessing(4) and 1 or 0)
    valbless5 = (player:hasBlessing(5) and 1 or 0)
    valpromoted = ((player:getStorageValue(STORAGEVALUE_PROMOTION) >= 1 and player:isPremium()) and 1 or 0)

    bonus = valbless1*8 + valbless2*8 + valbless3*8 + valbless4*8 + valbless5*8 + valpromoted*30

    -- calculo de perda de equipamentos

    somabless = valbless1 + valbless2 + valbless3 + valbless4 + valbless5

    local bp = ""
    local equip = ""

    if somabless == 0 then
        bp = "100%"
        equip = "10%"
    elseif somabless == 1 then
        bp = "70%"
        equip = "7%"
    elseif somabless == 2 then
        bp = "45%"
        equip = "4.5%"
    elseif somabless == 3 then
        bp = "25%"
        equip = "2.5%"
    elseif somabless == 4 then
        bp = "10%"
        equip = "1%"
    elseif somabless == 5 then
        bp = "0%"
        equip = "0%"
    end


    totaldebonus = "\n----------------------------------\nTotal de Bonus: "..bonus.."% de reducao em perda de EXP e SKILL"
    perdadeitens = "\n----------------------------------\nChance de perda de itens:\n    -Backpack: "..bp.."\n    -Equipamentos: "..equip

    texto = texto..Promoted..bless1..bless2..bless3..bless4..bless5..totaldebonus..perdadeitens


    --player:showTextDialog(7726, texto)
    player:popupFYI(texto)

    return false

end


k2_alavanca_bless_talk:separator(" ")
k2_alavanca_bless_talk:register()


k2_alavanca_bless:aid(1301,1302,1303,1304,1305)
k2_alavanca_bless:register()