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



shopModule:addBuyableItem({'Crossbow'}, 2455, 500, 'Crossbow')
shopModule:addBuyableItem({'Modified Crossbow'}, 8849, 20000, 'Modified Crossbow')
shopModule:addBuyableItem({'Chain Bolter'}, 8850, 50000, 'Chain Bolter')


shopModule:addBuyableItem({'Bow'}, 2456, 400, 'Bow')
shopModule:addBuyableItem({'Elvish Bow'}, 7438, 1000, 'Elvish Bow')
shopModule:addBuyableItem({'Silkweaver Bow'}, 8857, 5000, 'Silkweaver Bow')
shopModule:addBuyableItem({'Composite Hornbow'}, 8855, 25000, 'Composite Hornbow')


shopModule:addBuyableItem({'belted cape'}, 8872, 1300, 1, 'belted cape')
shopModule:addBuyableItem({'ranger cloak'}, 2660, 550, 1, 'ranger cloak')


npcHandler:addModule(FocusModule:new())
