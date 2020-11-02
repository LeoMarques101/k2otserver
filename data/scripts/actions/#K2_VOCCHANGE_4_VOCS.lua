local ALAVANCA = {
    [1945] = {usada = 1946},
    [1946] = {usada = 1945},
    [9825] = {usada = 9826},
    [9826] = {usada = 9825},
    [9827] = {usada = 9828},
    [9828] = {usada = 9827},
}

local VOCACOES={
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 1,
    [6] = 2,
    [7] = 3,
    [8] = 4,
}

local VOC_AID ={
	[6601] = 1,
	[6602] = 2,
	[6603] = 3,
	[6604] = 4,
}

local VOCACOES_query = {
	[1] = {nome = "Sorcerer/Druid", id = 1},
	[2] = {nome = "Sorcerer/Druid", id = 1},
	[3] = {nome = "Paladin", id = 3},
	[4] = {nome = "Knight", id = 4},
}

local custo = 10000

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end


local K2_ALAV_VOCCHANGE = Action()
function K2_ALAV_VOCCHANGE.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(ALAVANCA[item.itemid].usada)

	if player:getVocation():getId() == 0 then
		player:sendCancelMessage("Voce ainda nao tem vocacao!.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end


	local voc_atual = Vocation(VOCACOES[player:getVocation():getId()])
	local voc_desejada = Vocation(VOC_AID[item.actionid])
	local max_health = 185+(voc_desejada:getHealthGain()*(player:getLevel()-8))
    local max_mana = 35+(voc_desejada:getManaGain()*(player:getLevel()-8))
    local max_capacity = 47000+(voc_desejada:getCapacityGain()*(player:getLevel()-8))
    local actual_cap = player:getCapacity() - player:getFreeCapacity()
    local playerid = player:getGuid()

    if voc_atual == voc_desejada then

    	player:sendCancelMessage("Esta ja e sua vocacao!")
    	player:getPosition():sendMagicEffect(CONST_ME_POFF)

    elseif actual_cap > max_capacity then

    	local cap_livre = actual_cap - max_capacity
    	player:sendCancelMessage("Voce deve ter ".. cap_livre/1000 .." de capacidade disponivel!")
    	player:getPosition():sendMagicEffect(CONST_ME_POFF)

    elseif custo > player:getMoney() then

    	player:sendCancelMessage("Voce nao tem ".. custo .." golds para realizar a mudanca!")
    	player:getPosition():sendMagicEffect(CONST_ME_POFF)

    else
    	-- inserir na base players_k2vocchange as linhas padrões caso o player nunca tenha mudado de voc
    	if player:getStorageValue(7777) ~= 1 then
    		db.query("INSERT INTO `players_k2vocchange` (`player_id`,`vocation`) VALUES ("..playerid..",1)")
    		db.query("INSERT INTO `players_k2vocchange` (`player_id`,`vocation`) VALUES ("..playerid..",2)")
    		db.query("INSERT INTO `players_k2vocchange` (`player_id`,`vocation`) VALUES ("..playerid..",3)")
    		db.query("INSERT INTO `players_k2vocchange` (`player_id`,`vocation`) VALUES ("..playerid..",4)")
    		player:setStorageValue(7777,1)
    	end

    	-- INSERIR OS SKILS ATUAIS NA BASE players_k2vocchange
    	local player_skills ={
    		[SKILL_FIST] = {skill = player:getSkillLevel(SKILL_FIST), tries = player:getSkillTries(SKILL_FIST)},
    		[SKILL_CLUB] = {skill = player:getSkillLevel(SKILL_CLUB), tries = player:getSkillTries(SKILL_CLUB)},
    		[SKILL_SWORD] = {skill = player:getSkillLevel(SKILL_SWORD), tries = player:getSkillTries(SKILL_SWORD)},
    		[SKILL_AXE] = {skill = player:getSkillLevel(SKILL_AXE), tries = player:getSkillTries(SKILL_AXE)},
    		[SKILL_DISTANCE] = {skill = player:getSkillLevel(SKILL_DISTANCE), tries = player:getSkillTries(SKILL_DISTANCE)},
    		[SKILL_SHIELD] = {skill = player:getSkillLevel(SKILL_SHIELD), tries = player:getSkillTries(SKILL_SHIELD)},
    		[SKILL_MAGLEVEL] = {skill = player:getBaseMagicLevel(), tries = player:getManaSpent()},
    	}

    	local query_k2vocchange ={
    		"UPDATE `players_k2vocchange` SET ",
    		"`maglevel` = ".. player_skills[SKILL_MAGLEVEL].skill ..", `manaspent` = ".. player_skills[SKILL_MAGLEVEL].tries ..", ",
    		"`skill_fist` = ".. player_skills[SKILL_FIST].skill ..", `skill_fist_tries` = ".. player_skills[SKILL_FIST].tries ..", ",
    		"`skill_club` = ".. player_skills[SKILL_CLUB].skill ..", `skill_club_tries` = ".. player_skills[SKILL_CLUB].tries ..", ",
    		"`skill_sword` = ".. player_skills[SKILL_SWORD].skill ..", `skill_sword_tries` = ".. player_skills[SKILL_SWORD].tries ..", ",
    		"`skill_axe` = ".. player_skills[SKILL_AXE].skill ..", `skill_axe_tries` = ".. player_skills[SKILL_AXE].tries ..", ",
    		"`skill_dist` = ".. player_skills[SKILL_DISTANCE].skill ..", `skill_dist_tries` = ".. player_skills[SKILL_DISTANCE].tries ..", ",
    		"`skill_shielding` = ".. player_skills[SKILL_SHIELD].skill ..", `skill_shielding_tries` = ".. player_skills[SKILL_SHIELD].tries .." ",
    		"WHERE `player_id` = ".. playerid .. " and `vocation` = ".. voc_atual:getId(),
    	}

    	local txt_query_k2vocchange = ""
		for i,linha in ipairs(query_k2vocchange) do
			txt_query_k2vocchange = txt_query_k2vocchange .. linha
		end

    	db.query(txt_query_k2vocchange)


    	-- INSERIR OS SKILLS da voc escolhida NA BASE players
	    local Info = db.storeQuery("SELECT * FROM `players_k2vocchange` WHERE `player_id` = ".. playerid .. " and `vocation` = ".. voc_desejada:getId())
        if Info ~= false then

	    	local player_skills_get ={
	    		[SKILL_FIST] = {skill = result.getNumber(Info, "skill_fist"), tries = result.getNumber(Info, "skill_fist_tries")},
	    		[SKILL_CLUB] = {skill = result.getNumber(Info, "skill_club"), tries = result.getNumber(Info, "skill_club_tries")},
	    		[SKILL_SWORD] = {skill = result.getNumber(Info, "skill_sword"), tries = result.getNumber(Info, "skill_sword_tries")},
	    		[SKILL_AXE] = {skill = result.getNumber(Info, "skill_axe"), tries = result.getNumber(Info, "skill_axe_tries")},
	    		[SKILL_DISTANCE] = {skill = result.getNumber(Info, "skill_dist"), tries = result.getNumber(Info, "skill_dist_tries")},
	    		[SKILL_SHIELD] = {skill = result.getNumber(Info, "skill_shielding"), tries = result.getNumber(Info, "skill_shielding_tries")},
	    		[SKILL_MAGLEVEL] = {skill = result.getNumber(Info, "maglevel"), tries = result.getNumber(Info, "manaspent")},
	    	}

	    	result.free(Info)

	    	player:removeMoney(custo)
	    	player:setVocation(voc_desejada:getId())
	    	player:remove()

	    	local query_players ={
	    		"UPDATE `players` SET ",
	    		"`health` = ".. max_health ..", `healthmax` = ".. max_health ..", ",
	    		"`mana` = ".. max_mana ..", `manamax` = ".. max_mana ..", ",
	    		"`cap` = ".. max_capacity/100 ..", ",
	    		"`maglevel` = ".. player_skills_get[SKILL_MAGLEVEL].skill ..", `manaspent` = ".. player_skills_get[SKILL_MAGLEVEL].tries ..", ",
	    		"`skill_fist` = ".. player_skills_get[SKILL_FIST].skill ..", `skill_fist_tries` = ".. player_skills_get[SKILL_FIST].tries ..", ",
	    		"`skill_club` = ".. player_skills_get[SKILL_CLUB].skill ..", `skill_club_tries` = ".. player_skills_get[SKILL_CLUB].tries ..", ",
	    		"`skill_sword` = ".. player_skills_get[SKILL_SWORD].skill ..", `skill_sword_tries` = ".. player_skills_get[SKILL_SWORD].tries ..", ",
	    		"`skill_axe` = ".. player_skills_get[SKILL_AXE].skill ..", `skill_axe_tries` = ".. player_skills_get[SKILL_AXE].tries ..", ",
	    		"`skill_dist` = ".. player_skills_get[SKILL_DISTANCE].skill ..", `skill_dist_tries` = ".. player_skills_get[SKILL_DISTANCE].tries ..", ",
	    		"`skill_shielding` = ".. player_skills_get[SKILL_SHIELD].skill ..", `skill_shielding_tries` = ".. player_skills_get[SKILL_SHIELD].tries .." ",
	    		"WHERE `id` = ".. playerid,
	    	}

	    	local txt_query_players = ""
			for i,linha in ipairs(query_players) do
				txt_query_players = txt_query_players .. linha
			end
			db.query(txt_query_players)
    	else
    		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED,"Algo ocorreu errado :/,: "..playerid)
    	end
    end
	return true
end

local K2_ALAV_VOCCHANGE_talk = TalkAction("!skill")

function K2_ALAV_VOCCHANGE_talk.onSay(player, words, param)

		local playerid = player:getGuid()

		if player:getVocation():getId() == 0 then
			player:sendCancelMessage("Voce ainda nao tem vocacao!.")
			return false
		end

    	if player:getStorageValue(7777) ~= 1 then
    		db.query("INSERT INTO `players_k2vocchange` (`player_id`,`vocation`) VALUES ("..playerid..",1)")
    		db.query("INSERT INTO `players_k2vocchange` (`player_id`,`vocation`) VALUES ("..playerid..",2)")
    		db.query("INSERT INTO `players_k2vocchange` (`player_id`,`vocation`) VALUES ("..playerid..",3)")
    		db.query("INSERT INTO `players_k2vocchange` (`player_id`,`vocation`) VALUES ("..playerid..",4)")
    		player:setStorageValue(7777,1)
    	end

		local voc_query = {
			[1] = db.storeQuery("SELECT * FROM `players_k2vocchange` WHERE `player_id` = ".. playerid .. " and `vocation` = ".. 1),
			[2] = db.storeQuery("SELECT * FROM `players_k2vocchange` WHERE `player_id` = ".. playerid .. " and `vocation` = ".. 2),
			[3] = db.storeQuery("SELECT * FROM `players_k2vocchange` WHERE `player_id` = ".. playerid .. " and `vocation` = ".. 3),
			[4] = db.storeQuery("SELECT * FROM `players_k2vocchange` WHERE `player_id` = ".. playerid .. " and `vocation` = ".. 4),
		}

		local voc = {
			[1] = Vocation(1),
			[2] = Vocation(2),
			[3] = Vocation(3),
			[4] = Vocation(4),
		}


		local skill = {
			[0] = {name = "Magic", type = SKILL_MAGLEVEL},	--não usa o type
			[1] = {name = "Fist", type = SKILL_FIST},
			[2] = {name = "Club", type = SKILL_CLUB},
			[3] = {name = "Sword", type = SKILL_SWORD},
			[4] = {name = "Axe", type = SKILL_AXE},
			[5] = {name = "Distance", type = SKILL_DISTANCE},
			[6] = {name = "Shield", type = SKILL_SHIELD},
		}

		local voc_atual = Vocation(VOCACOES[player:getVocation():getId()])

		local txt = "|=====| Skills |=====|"

		for i=1,4 do
			
			local player_skills ={}

			if voc_atual:getId() == i then

		    	player_skills ={
					[0] = {skill = player:getBaseMagicLevel(), tries = player:getManaSpent()},
		    		[1] = {skill = player:getSkillLevel(SKILL_FIST), tries = player:getSkillTries(SKILL_FIST)},
		    		[2] = {skill = player:getSkillLevel(SKILL_CLUB), tries = player:getSkillTries(SKILL_CLUB)},
		    		[3] = {skill = player:getSkillLevel(SKILL_SWORD), tries = player:getSkillTries(SKILL_SWORD)},
		    		[4] = {skill = player:getSkillLevel(SKILL_AXE), tries = player:getSkillTries(SKILL_AXE)},
		    		[5] = {skill = player:getSkillLevel(SKILL_DISTANCE), tries = player:getSkillTries(SKILL_DISTANCE)},
		    		[6] = {skill = player:getSkillLevel(SKILL_SHIELD), tries = player:getSkillTries(SKILL_SHIELD)},
		    	}

		    	txt = txt .. "\n\n---> ".. voc[i]:getName() .." [Voc. atual]"

			else

				player_skills ={
		    		[0] = {skill = result.getNumber(voc_query[i], "maglevel"), tries = result.getNumber(voc_query[i], "manaspent")},
		    		[1] = {skill = result.getNumber(voc_query[i], "skill_fist"), tries = result.getNumber(voc_query[i], "skill_fist_tries")},
		    		[2] = {skill = result.getNumber(voc_query[i], "skill_club"), tries = result.getNumber(voc_query[i], "skill_club_tries")},
		    		[3] = {skill = result.getNumber(voc_query[i], "skill_sword"), tries = result.getNumber(voc_query[i], "skill_sword_tries")},
		    		[4] = {skill = result.getNumber(voc_query[i], "skill_axe"), tries = result.getNumber(voc_query[i], "skill_axe_tries")},
		    		[5] = {skill = result.getNumber(voc_query[i], "skill_dist"), tries = result.getNumber(voc_query[i], "skill_dist_tries")},
		    		[6] = {skill = result.getNumber(voc_query[i], "skill_shielding"), tries = result.getNumber(voc_query[i], "skill_shielding_tries")},
		    	}

		    	result.free(voc_query[i])

		    	txt = txt .. "\n\n---> ".. voc[i]:getName()

			end

			for x=0,6 do

				local req_skill_tries = 0

				if x == 0 then
					req_skill_tries = voc[i]:getRequiredManaSpent(player_skills[x].skill+1)
				else
					req_skill_tries = voc[i]:getRequiredSkillTries(skill[x].type, player_skills[x].skill+1)
				end

				local percent = round((1-(player_skills[x].tries/req_skill_tries))*100,2)

				txt = txt .. "\n-" .. skill[x].name .. ": " .. player_skills[x].skill .. " ["..percent.."% to up]"
			end


		end

	player:showTextDialog(7726,txt)
    return false
end


K2_ALAV_VOCCHANGE_talk:separator(" ")
K2_ALAV_VOCCHANGE_talk:register()

K2_ALAV_VOCCHANGE:aid(6601,6602,6603,6604)
K2_ALAV_VOCCHANGE:register()