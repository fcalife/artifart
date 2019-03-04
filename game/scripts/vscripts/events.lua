-- This file contains all barebones-registered events and has already set up the passed-in parameters for your use.

-- Cleanup a player when they leave
function GameMode:OnDisconnect(keys)
	print("Player Disconnected: "..tostring(keys.userid))

	local name = keys.name
	local networkid = keys.networkid
	local reason = keys.reason
	local userid = keys.userid
end

-- The overall game state has changed
function GameMode:OnGameRulesStateChange(keys)
	local new_state = GameRules:State_Get()
	print("GameRules state has changed, new state: "..new_state)
end

-- An NPC has spawned somewhere in game.  This includes heroes
function GameMode:OnNPCSpawned(keys)
	local npc = EntIndexToHScript(keys.entindex)
end

-- An item was picked up off the ground
function GameMode:OnItemPickedUp(keys)
	print("An item was picked off the ground")

	local unitEntity = nil
	if keys.UnitEntitIndex then
		unitEntity = EntIndexToHScript(keys.UnitEntitIndex)
	elseif keys.HeroEntityIndex then
		unitEntity = EntIndexToHScript(keys.HeroEntityIndex)
	end

	local itemEntity = EntIndexToHScript(keys.ItemEntityIndex)
	local player = PlayerResource:GetPlayer(keys.PlayerID)
	local itemname = keys.itemname
end

-- A player has reconnected to the game.
function GameMode:OnPlayerReconnect(keys)
	print("A player has reconnected to the game")
end

-- An item was purchased by a player
function GameMode:OnItemPurchased( keys )
	print("An item was purchased by a player")

	-- The playerID of the hero who is buying something
	local plyID = keys.PlayerID
	if not plyID then return end

	-- The name of the item purchased
	local itemName = keys.itemname 
	
	-- The cost of the item purchased
	local itemcost = keys.itemcost
end

-- A player changed their name
function GameMode:OnPlayerChangedName(keys)
	local new_name = keys.newname
	local old_name = keys.oldName
	print("A player changed their name from "..old_name.." to "..new_name)
end

-- A player leveled up
function GameMode:OnPlayerLevelUp(keys)
	--print("A player leveled up")

	local player = EntIndexToHScript(keys.player)
	local level = keys.level

	-- Fetch player's current hero
	local hero = player:GetAssignedHero()
end

-- A player last hit a creep, a tower, or a hero
function GameMode:OnLastHit(keys)
	--print("A player last hit something")

	local isFirstBlood = keys.FirstBlood == 1
	local isHeroKill = keys.HeroKill == 1
	local isTowerKill = keys.TowerKill == 1
	local player = PlayerResource:GetPlayer(keys.PlayerID)
	local killedEnt = EntIndexToHScript(keys.EntKilled)
end

-- A tree was cut down by tango, quelling blade, etc
function GameMode:OnTreeCut(keys)
	print("A tree was cut down")

	local treeX = keys.tree_x
	local treeY = keys.tree_y
end

-- A player picked a hero
function GameMode:OnPlayerPickHero(keys)
	print("A player picked a hero")

	local hero_class = keys.hero
	local hero_entity = EntIndexToHScript(keys.heroindex)
	local player = EntIndexToHScript(keys.player)
	local player_id = player:GetPlayerID()
end

-- A player killed another player in a multi-team context
function GameMode:OnTeamKillCredit(keys)
	print("A pvp kill happened")

	local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
	local victimPlayer = PlayerResource:GetPlayer(keys.victim_userid)
	local numKills = keys.herokills
	local killerTeamNumber = keys.teamnumber
end

-- An entity died somewhere
function GameMode:OnEntityKilled(keys)

	-- The Unit that was Killed
	local killedUnit = EntIndexToHScript( keys.entindex_killed )

	-- The Killing entity
	local killerEntity = nil

	if keys.entindex_attacker ~= nil then
		killerEntity = EntIndexToHScript( keys.entindex_attacker )
	end
end

-- This function is called once when the player fully connects and becomes "Ready" during Loading
function GameMode:OnConnectFull(keys)
	print("A player has finished the pre-game load")
	
	local entIndex = keys.index+1
	-- The Player entity of the joining user
	local player_ent = EntIndexToHScript(entIndex)
	
	-- The Player ID of the joining player
	local player_id = player_ent:GetPlayerID()
end

-- This function is called whenever illusions are created and tells you which was/is the original entity
function GameMode:OnIllusionsCreated(keys)
	print("An illusion was created")

	local originalEntity = EntIndexToHScript(keys.original_entindex)
end

-- This function is called whenever an item is combined to create a new item
function GameMode:OnItemCombined(keys)
	--print("An item was combined")

	-- The playerID of the hero who is buying something
	local plyID = keys.PlayerID
	if not plyID then return end
	local player = PlayerResource:GetPlayer(plyID)

	-- The name of the item purchased
	local itemName = keys.itemname 
	
	-- The cost of the item purchased
	local itemcost = keys.itemcost
end

-- This function is called whenever any player sends a chat message to team or All
function GameMode:OnPlayerChat(keys)
	local teamonly = keys.teamonly
	local userID = keys.userid
	local playerID = self.vUserIds[userID]:GetPlayerID()

	local text = keys.text
end