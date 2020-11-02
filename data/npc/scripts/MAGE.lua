local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'spellbook'}, 2175, 150, 'spellbook')
shopModule:addBuyableItem({'Spellbook of Enlightenment'}, 8900, 8000, 'Spellbook of Enlightenment')
shopModule:addBuyableItem({'Spellbook of Warding'}, 8900, 15000, 'Spellbook of Warding')
shopModule:addBuyableItem({'Spellbook of Mind Control'}, 8900, 30000, 'Spellbook of Mind Control')

shopModule:addBuyableItem({'Ethno Coat'}, 8892, 750, 'Ethno Coat')
shopModule:addBuyableItem({'Spirit Cloak'}, 8870, 1000, 'Spirit Cloak')
shopModule:addBuyableItem({'Focus Cape'}, 8871, 8000, 'Focus Cape')

shopModule:addBuyableItem({'Hat of the Mad'}, 2323, 30000, 'Hat of the Mad')



shopModule:addBuyableItem({'health potion'}, 7618, 50, 1, 'health potion')
shopModule:addBuyableItem({'mana potion'}, 7620, 50, 1, 'mana potion')
shopModule:addBuyableItem({'strong health'}, 7588, 90, 1, 'strong health potion')
shopModule:addBuyableItem({'strong mana'}, 7589, 90, 1, 'strong mana potion')
shopModule:addBuyableItem({'great health'}, 7591, 150, 1, 'great health potion')
shopModule:addBuyableItem({'great mana'}, 7590, 120, 1, 'great mana potion')
shopModule:addBuyableItem({'great spirit'}, 8472, 300, 1, 'great spirit potion')
shopModule:addBuyableItem({'ultimate health'}, 8473, 300, 1, 'ultimate health potion')

shopModule:addSellableItem({'normal potion flask', 'normal flask'}, 7636, 5, 'empty small potion flask')
shopModule:addSellableItem({'strong potion flask', 'strong flask'}, 7634, 10, 'empty strong potion flask')
shopModule:addSellableItem({'great potion flask', 'great flask'}, 7635, 15, 'empty great potion flask')

shopModule:addBuyableItem({'instense healing'}, 2265, 95, 1, 'intense healing rune')
shopModule:addBuyableItem({'destroy field'}, 2261, 45, 3, 'destroy field rune')
shopModule:addBuyableItem({'light magic missile'}, 2287, 40, 10, 'light magic missile rune')
shopModule:addBuyableItem({'heavy magic missile'}, 2311, 120, 10, 'heavy magic missile rune')
shopModule:addBuyableItem({'explosion'}, 2313, 250, 6, 'explosion rune')
shopModule:addBuyableItem({'animate dead'}, 2316, 375, 1, 'animate dead rune')
shopModule:addBuyableItem({'convince creature'}, 2290, 80, 1, 'convince creature rune')
shopModule:addBuyableItem({'chameleon'}, 2291, 210, 1, 'chameleon rune')
shopModule:addBuyableItem({'desintegrate'}, 2310, 80,  3, 'desintegreate rune')

shopModule:addBuyableItem({'Fire Field'}, 2301, 80,  3, 'Fire Field Rune')
shopModule:addBuyableItem({'Energy Field'}, 2277, 80,  3, 'Energy Field Rune')
shopModule:addBuyableItem({'Poison Field'}, 2285, 80,  3, 'Poison Field Rune')

shopModule:addBuyableItem({'Fire Bomb'}, 2305, 200,  2, 'Fire Bomb Rune')
shopModule:addBuyableItem({'Energy Bomb'}, 2262, 200,  2, 'Energy Bomb Rune')
shopModule:addBuyableItem({'Poison Bomb'}, 2286, 200,  2, 'Poison Bomb Rune')

shopModule:addBuyableItem({'Fire Wall'}, 2303, 200,  4, 'Fire Wall Rune')
shopModule:addBuyableItem({'Energy Wall'}, 2279, 200,  4, 'Energy Wall Rune')
shopModule:addBuyableItem({'Poison Wall'}, 2289, 200,  4, 'Poison Wall Rune')

shopModule:addBuyableItem({'wand of vortex', 'vortex'}, 2190, 500, 'wand of vortex')
shopModule:addBuyableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 1000, 'wand of dragonbreath')
shopModule:addBuyableItem({'wand of decay', 'decay'}, 2188, 5000, 'wand of decay')
shopModule:addBuyableItem({'wand of draconia', 'draconia'}, 8921, 7500, 'wand of draconia')
shopModule:addBuyableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 10000, 'wand of cosmic energy')
shopModule:addBuyableItem({'wand of inferno', 'inferno'}, 2187, 15000, 'wand of inferno')
shopModule:addBuyableItem({'wand of starstorm', 'starstorm'}, 8920, 18000, 'wand of starstorm')
shopModule:addBuyableItem({'wand of voodoo', 'voodoo'}, 8922, 22000, 'wand of voodoo')

shopModule:addBuyableItem({'snakebite rod', 'snakebite'}, 2182, 500, 'snakebite rod')
shopModule:addBuyableItem({'moonlight rod', 'moonlight'}, 2186, 1000, 'moonlight rod')
shopModule:addBuyableItem({'necrotic rod', 'necrotic'}, 2185, 5000, 'necrotic rod')
shopModule:addBuyableItem({'northwind rod', 'northwind'}, 8911, 7500, 'northwind rod')
shopModule:addBuyableItem({'terra rod', 'terra'}, 2181, 10000, 'terra rod')
shopModule:addBuyableItem({'hailstorm rod', 'hailstorm'}, 2183, 15000, 'hailstorm rod')
shopModule:addBuyableItem({'springsprout rod', 'springsprout'}, 8912, 18000, 'springsprout rod')
shopModule:addBuyableItem({'underworld rod', 'underworld'}, 8910, 22000, 'underworld rod')

--[[
shopModule:addSellableItem({'wand of vortex', 'vortex'}, 2190, 250, 'wand of vortex')
shopModule:addSellableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 500, 'wand of dragonbreath')
shopModule:addSellableItem({'wand of decay', 'decay'}, 2188, 2500, 'wand of decay')
shopModule:addSellableItem({'wand of draconia', 'draconia'}, 8921, 3750, 'wand of draconia')
shopModule:addSellableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 5000, 'wand of cosmic energy')
shopModule:addSellableItem({'wand of inferno', 'inferno'},2187, 7500, 'wand of inferno')
shopModule:addSellableItem({'wand of starstorm', 'starstorm'}, 8920, 9000, 'wand of starstorm')
shopModule:addSellableItem({'wand of voodoo', 'voodoo'}, 8922, 11000, 'wand of voodoo')

shopModule:addSellableItem({'snakebite rod', 'snakebite'}, 2182, 250,'snakebite rod')
shopModule:addSellableItem({'moonlight rod', 'moonlight'}, 2186, 500,   'moonlight rod')
shopModule:addSellableItem({'necrotic rod', 'necrotic'}, 2185, 2500, 'necrotic rod')
shopModule:addSellableItem({'northwind rod', 'northwind'}, 8911, 3750, 'northwind rod')
shopModule:addSellableItem({'terra rod', 'terra'}, 2181, 5000, 'terra rod')
shopModule:addSellableItem({'hailstorm rod', 'hailstorm'}, 2183, 7500, 'hailstorm rod')
shopModule:addSellableItem({'springsprout rod', 'springsprout'}, 8912, 9000, 'springsprout rod')
shopModule:addSellableItem({'underworld rod', 'underworld'}, 8910, 11000, 'underworld rod')
]]--
npcHandler:addModule(FocusModule:new())
