local ALAVANCA = {
    [1945] = {usada = 1946},
    [1946] = {usada = 1945},
    [9825] = {usada = 9826},
    [9826] = {usada = 9825},
    [9827] = {usada = 9828},
    [9828] = {usada = 9827},
}


local ARENA ={
	[4000] = {
		level=3,
		xde=994,xate=1004,
		yde=692,yate=695,
		arenaz=9,
		player1pos = {x=998, y=697, z=9, stackpos=253},
		player2pos = {x=1000, y=697, z=9, stackpos=253},
		nplayer1pos = {x=996, y=694, z=9},
		nplayer2pos = {x=1002, y=694, z=9},
	}
}



local k2_arena = Action()

function k2_arena.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(ALAVANCA[item.itemid].usada)

	arena = ARENA[item.uid]

	P1_POS = Position(arena.player1pos)
	P2_POS = Position(arena.player2pos)

	P1_POS_TELEPORT = Position(arena.nplayer1pos)
	P2_POS_TELEPORT = Position(arena.nplayer2pos)

	P1 = Tile(P1_POS):getTopCreature()
	P2 = Tile(P2_POS):getTopCreature()

	if P1 and P2 then
		if P1:getLevel() >=  arena.level and P2:getLevel() >=  arena.level then

			for arenax = arena.xde,arena.xate do
				for arenay = arena.yde,arena.yate do

					ARENA_POS = Position(arenax, arenay, arena.arenaz, 253)

					arenacreature = Tile(ARENA_POS):getTopCreature()

					if arenacreature then
						player:sendTextMessage(MESSAGE_INFO_DESCR, "Espere o duelo acabar!" )
						return true
					end
				end
			end


			P1:getPosition():sendMagicEffect(CONST_ME_POFF)
			P2:getPosition():sendMagicEffect(CONST_ME_POFF)
			P1:teleportTo(P1_POS_TELEPORT)
			P2:teleportTo(P2_POS_TELEPORT)
			P1:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			P2:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

		else
			P1:sendTextMessage(MESSAGE_INFO_DESCR, "Ambos jogadores devem ter level superior a: ".. arena.level )
		end
		return true
	else

		player:sendTextMessage(MESSAGE_INFO_DESCR, "Dois jogadores sao necessarios para realizar o duelo" )
	end
end

k2_arena:uid(4000,4001,4002,4003)
k2_arena:register()