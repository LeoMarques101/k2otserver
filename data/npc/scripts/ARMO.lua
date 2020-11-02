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

shopModule:addBuyableItem({'brass helmet'}, 2460, 120, 1, 'brass helmet')
shopModule:addBuyableItem({'chain helmet'}, 2458, 52, 1, 'chain helmet')
shopModule:addBuyableItem({'dark helmet'}, 2490, 1000, 1, 'dark helmet')
shopModule:addBuyableItem({'helmet of the deep'}, 5461, 5000, 1, 'helmet of the deep')
shopModule:addBuyableItem({'iron helmet'}, 2459, 390, 1, 'iron helmet')
shopModule:addBuyableItem({'leather helmet'}, 2461, 12, 1, 'leather helmet')
shopModule:addBuyableItem({'party hat'}, 6578, 600, 1, 'party hat')
shopModule:addBuyableItem({'steel helmet'}, 2457, 580, 1, 'steel helmet')
shopModule:addBuyableItem({'soldier helmet'}, 2481, 110, 1, 'soldier helmet')
shopModule:addBuyableItem({'studded helmet'}, 2482, 63, 1, 'studded helmet')
shopModule:addBuyableItem({'viking helmet'}, 2473, 265, 1, 'viking helmet')

--shopModule:addBuyableItem({'belted cape'}, 8872, 1300, 1, 'belted cape')
shopModule:addBuyableItem({'brass armor'}, 2465, 450, 1, 'brass armor')
shopModule:addBuyableItem({'cape'}, 2654, 9, 1, 'cape')
shopModule:addBuyableItem({'chain armor'}, 2464, 200, 1, 'chain armor')
shopModule:addBuyableItem({'coat'}, 2651, 8, 1, 'coat')	
shopModule:addBuyableItem({'dark armor'}, 2489, 1500, 1, 'dark armor')
--shopModule:addBuyableItem({'ethno coat'}, 8892, 35000, 1, 'ethno coat')
shopModule:addBuyableItem({'green tunic'}, 2652, 25, 1, 'green tunic')
shopModule:addBuyableItem({'jacket'}, 2650, 12, 1, 'jacket')
shopModule:addBuyableItem({'leather armor'}, 2467, 25, 1, 'leather armor')
shopModule:addBuyableItem({'magician robe'}, 8819, 450, 1, 'magician robe')	
shopModule:addBuyableItem({'noble armor'}, 2486, 8000, 1, 'noble armor')	
shopModule:addBuyableItem({'plate armor'}, 2463, 1200, 1, 'plate armor')
--shopModule:addBuyableItem({'ranger cloak'}, 2660, 550, 1, 'ranger cloak')
shopModule:addBuyableItem({'scale armor'}, 2483, 260, 1, 'scale armor')	
--shopModule:addBuyableItem({'spirit cloak'}, 8870, 1000, 1, 'spirit cloak')
shopModule:addBuyableItem({'studded armor'}, 2484, 90, 1, 'studded armor')

shopModule:addBuyableItem({'brass legs'}, 2478, 195, 1, 'brass legs')
shopModule:addBuyableItem({'chain legs'}, 2648, 80, 1, 'chain legs')
shopModule:addBuyableItem({'leather legs'}, 2649, 10, 1, 'leather legs')
shopModule:addBuyableItem({'studded legs'}, 2468, 60, 1, 'studded legs')
shopModule:addBuyableItem({'plate legs'}, 2647, 500, 1,'plate legs')

shopModule:addBuyableItem({'leather boots'}, 2643, 2, 1,'leather boots')

shopModule:addBuyableItem({'ancient shield'}, 2532, 5000, 1, 'ancient shield')
shopModule:addBuyableItem({'bonelord shield'}, 2518, 7000, 1, 'beholder shield')
shopModule:addBuyableItem({'brass shield'}, 2511, 65, 1, 'brass shield')
shopModule:addBuyableItem({'dwarven shield'}, 2525, 500, 1, 'dwarven shield')
shopModule:addBuyableItem({'plate shield'}, 2510, 125, 1, 'plate shield')	
shopModule:addBuyableItem({'steel shield'}, 2509, 240, 1, 'steel shield')
shopModule:addBuyableItem({'studded shield'}, 2526, 50, 1, 'studded shield')
shopModule:addBuyableItem({'viking shield'}, 2531, 260, 1, 'viking shield')
shopModule:addBuyableItem({'wooden shield'}, 2512, 15, 1, 'wooden shield')

npcHandler:addModule(FocusModule:new())
