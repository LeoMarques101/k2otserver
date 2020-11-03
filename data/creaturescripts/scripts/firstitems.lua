local itens ={
	[0] = {},
	[1] = {2182,8820,8819,2649,2643},
	[2] = {2190,8820,8819,2649,2643},
	[3] = {2456,2460,2660,2649,2643},
	[4] = {2383,2460,2465,2478,2643,2511},
	[5] = {2182,8820,8819,2649,2643},
	[6] = {2190,8820,8819,2649,2643},
	[7] = {2456,2460,2660,2649,2643},
	[8] = {2383,2460,2465,2478,2643,2511},
}

local firstItems = {
	[1] = {id = 2120, quant = 1},
	[2] = {id = 2554, quant = 1},
	[3] = {id = 2667, quant = 2},
	[4] = {id = 7618, quant = 10},
	[5] = {id = 7620, quant = 5},
	[6] = {id = 2175, quant = 1},
	[7] = {id = 2050, quant = 1},
}

function onLogin(player)
	if player:getLastLoginSaved() == 0 then

			local BP = player:addItem(2004, 1)

			local vocitens = itens[player:getVocation():getId()]

			for i = 1, #vocitens do
				player:addItem(vocitens[i], 1)
			end

			for i = 1, #firstItems do
				player:addItem(firstItems[i].id, firstItems[i].quant)
			end

			if player:getVocation():getId() == 3 or player:getVocation():getId() == 7 then
				player:addItem(2544, 100) --flechas
			end
	end
	return true
end
