-- Core initialization
if Artifart == nil then
	print("Initializing artifart core...")
	_G.Artifart = class({})
end

-- Initialize card list and inventory for each player
function Artifart:Initialize()
	Artifart.card_list = LoadKeyValues("scripts/npc/KV/cardlist.kv")
	Artifart.secret_shop_items = LoadKeyValues("scripts/npc/KV/secret_shop_items.kv")
	Artifart.valid_players = {}
	for player_id = 0, DOTA_MAX_TEAM_PLAYERS  do
		if PlayerResource:IsValidPlayer(player_id) then
			self:InitializeSinglePlayer(player_id)
		end
	end
end

-- Initialize card list for a single player
function Artifart:InitializeSinglePlayer(player_id)
	if Artifart.valid_players[player_id] then
		print("Player"..player_id.." already set up!")
		return false
	end
	local initial_hand = {}
	for i = 1, MAX_CARDS do
		initial_hand[i] = "blank"
	end
	Artifart.valid_players[player_id] = true
	CustomNetTables:SetTableValue("player_cards", "player_"..player_id.."_cards", initial_hand)
	print("Set up deck for player "..player_id)
	return true
end

-- Periodic card giving
function Artifart:AddPeriodicCards()
	for player_id = 0, DOTA_MAX_TEAM_PLAYERS  do
		if PlayerResource:IsValidPlayer(player_id) and Artifart.valid_players[player_id] then
			self:AddRandomCard(player_id)
		end
	end
	print("Added cards for all players")
end


-- Card handling functions
function Artifart:GetPlayerCards(player_id)
	return CustomNetTables:GetTableValue("player_cards", "player_"..player_id.."_cards")
end

function Artifart:AddCard(player_id, card_name)
	local player_cards = self:GetPlayerCards(player_id)
	local deck_full = true
	
	for i = 1, MAX_CARDS do
		if player_cards[tostring(i)] == "blank" then
			player_cards[tostring(i)] = card_name
			deck_full = false
			break
		end
	end

	if deck_full then
		print("Player "..player_id.."'s hand is full! Can't add more cards.")
		return false
	end

	if self:AddCardAbility(player_id, card_name) then
		CustomNetTables:SetTableValue("player_cards", "player_"..player_id.."_cards", player_cards)
		print("Added "..card_name.." to player "..player_id.."'s deck")
		print("Current deck:")
		PrintTable(self:GetPlayerCards(player_id))
		PlayerResource:GetSelectedHeroEntity(player_id):EmitSound("Artifart.GainCard")
		return true
	else
		return false
	end
end

function Artifart:AddRandomCard(player_id)
	self:AddCard(player_id, self.card_list[tostring(RandomInt(1, CARD_COUNT))])
end

function Artifart:ConsumeCard(player_id, card_slot)
	local player_cards = self:GetPlayerCards(player_id)
	local removed_card = player_cards[tostring(card_slot)]
	if removed_card ~= "blank" then
		for i = card_slot, (MAX_CARDS - 1) do
			player_cards[tostring(i)] = player_cards[tostring(i+1)]
		end
		player_cards[tostring(MAX_CARDS)] = "blank"
		CustomNetTables:SetTableValue("player_cards", "player_"..player_id.."_cards", player_cards)
		print("Used card "..card_slot.." from player"..player_id.."'s deck")
		print("Current deck:")
		PrintTable(player_cards)
		self:RemoveCardAbility(player_id, removed_card)
	else
		print("No card to use on slot "..card_slot.." of player"..player_id.."'s deck")
	end
end

function Artifart:HasCard(player_id, card_name)
	local player_cards = self:GetPlayerCards(player_id)
	for card_slot, existing_card_name in pairs(player_cards) do
		if card_name == existing_card_name then
			return card_slot
		end
	end
	return false
end

function Artifart:DiscardHand(player_id)
	local player_cards = self:GetPlayerCards(player_id)
	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	for i = 1, MAX_CARDS do
		local ability_name = "card_"..player_cards[tostring(i)]
		if hero:HasAbility(ability_name) then
			hero:RemoveAbility(ability_name)
		end
		player_cards[tostring(i)] = "blank"
	end
	CustomNetTables:SetTableValue("player_cards", "player_"..player_id.."_cards", player_cards)
	print("Discarded player"..player_id.."'s deck")
	print("Current deck:")
	PrintTable(player_cards)
end


-- Ability handling functions
function Artifart:AddCardAbility(player_id, card_name)
	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if hero:FindAbilityByName("card_"..card_name) then
		print("Hero already has "..card_name.." ability!")
		return true
	else
		local added_ability = hero:AddAbility("card_"..card_name)
		if added_ability then
			added_ability:SetLevel(1)
			return true
		else
			print("ERROR: Couldn't add "..card_name.."'s ability!")
			return false
		end
	end
end

function Artifart:RemoveCardAbility(player_id, card_name)
	if self:HasCard(player_id, card_name) then
		print("Duplicate card used, "..card_name.." ability not removed")
		return false
	else
		PlayerResource:GetSelectedHeroEntity(player_id):RemoveAbility("card_"..card_name)
		print("Removed "..card_name.." ability from player"..player_id.."'s hero")
		return true
	end
end