-- Barebones-based initialization
BAREBONES_VERSION = "1.00"

if GameMode == nil then
	print("Initializing game mode...")
	_G.GameMode = class({})
end

function GameMode:PostLoadPrecache()
	print("Performing post-load precache...")    
	--PrecacheItemByNameAsync("item_example_item", function(...) end)
	--PrecacheItemByNameAsync("example_ability", function(...) end)
	--PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
end

function GameMode:OnFirstPlayerLoaded()
	print("First player has finished loading the gamemode")
end

function GameMode:OnAllPlayersLoaded()
	print("All players have finished loading the gamemode")
	if IsServer() then
		Artifart:Initialize()
	end
end

function GameMode:OnHeroInGame(hero)
	print(hero:GetUnitName() .. " spawned in game for the first time.")
	if IsServer() then
		if not PlayerResource:IsFakeClient(hero:GetPlayerID()) then
			hero:AddItemByName("item_starter_deck")
		end
	end
end

function GameMode:OnStrategyTimeStart()
	print("Strategy Time has started (hero pick phase has ended)")

end

function GameMode:OnPreGameStart()
	print("Players are in the game (pre-game started)")
end

function GameMode:OnGameInProgress()
	if IsServer() then
		print("The horn has sounded")
		for i = 0, 200 do
			Timers:CreateTimer(i * 45, function()
				Artifart:AddPeriodicCards()
			end)
		end
	end
end

-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
	if IsServer() then
		GameMode = self
		print("Performing initialization tasks...")

		-- Global filter setup
		GameRules:GetGameModeEntity():SetModifyGoldFilter(Dynamic_Wrap(GameMode, "GoldFilter"), self)
		GameRules:GetGameModeEntity():SetModifyExperienceFilter(Dynamic_Wrap(GameMode, "ExpFilter"), self)
		--GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(GameMode, "DamageFilter"), self)
		--GameRules:GetGameModeEntity():SetModifierGainedFilter(Dynamic_Wrap(GameMode, "ModifierFilter"), self)
		--GameRules:GetGameModeEntity():SetExecuteOrderFilter(Dynamic_Wrap(GameMode, "OrderFilter"), self)

		-- Custom console commands
		--Convars:RegisterCommand("runes_on", Dynamic_Wrap(GameMode, 'EnableAllRunes'), "Enables all runes", FCVAR_CHEAT )
		--Convars:RegisterCommand("runes_off", Dynamic_Wrap(GameMode, 'DisableAllRunes'), "Disables all runes", FCVAR_CHEAT )

		-- Custom listeners
		CustomGameEventManager:RegisterListener("increase_game_speed", Dynamic_Wrap(GameMode, "IncreaseGameSpeed"))
		CustomGameEventManager:RegisterListener("set_bot_options", Dynamic_Wrap(GameMode, "SetBotOptions"))
		CustomGameEventManager:RegisterListener("player_discarded_card", Dynamic_Wrap(GameMode, "PlayerDiscardedCard"))

		print("Initialization tasks done!")
	end
end

-- Player intentionally discarded a card
function GameMode:PlayerDiscardedCard(keys)
	Artifart:ConsumeCard(keys.player_id, keys.card_slot)
end

-- Game speed change function
function GameMode:IncreaseGameSpeed(keys)
	GAME_SPEED_MULTIPLIER = keys.speed * 0.01
end

-- Spawn bots according to selected bot options
function GameMode:SetBotOptions(keys)
	if IsServer() then
		-- No bots option
		if keys.option == "4" then
			return false
		end

		-- Count players
		local radiant_player_count = 0
		local dire_player_count = 0
		for i = 0, DOTA_MAX_TEAM_PLAYERS do
			if PlayerResource:IsValidPlayer(i) then
				if PlayerResource:GetTeam(i) == DOTA_TEAM_GOODGUYS then
					radiant_player_count = radiant_player_count + 1
				elseif PlayerResource:GetTeam(i) == DOTA_TEAM_BADGUYS then
					dire_player_count = dire_player_count + 1
				end
			end
		end

		print("Number of radiant players:", radiant_player_count)
		print("Number of dire players:", dire_player_count)

		-- Enable bots and fill empty slots according to the chosen option
		local radiant_bot_count = 0
		local dire_bot_count = 0
		if keys.option == "1" then
			radiant_bot_count = 5 - radiant_player_count
			dire_bot_count = 5 - dire_player_count
		elseif keys.option == "2" then
			radiant_bot_count = math.max(radiant_player_count, dire_player_count) - radiant_player_count
			dire_bot_count = math.max(radiant_player_count, dire_player_count) - dire_player_count
		elseif keys.option == "3" then
			if dire_player_count == 0 then
				dire_bot_count = 5
			elseif radiant_player_count == 0 then
				radiant_bot_count = 5
			end
		end
		local current_bot_hero = 1
		local bot_heroes = {}
		bot_heroes[1] = "npc_dota_hero_sven"
		bot_heroes[2] = "npc_dota_hero_skeleton_king"
		bot_heroes[3] = "npc_dota_hero_lina"
		bot_heroes[4] = "npc_dota_hero_lion"
		bot_heroes[5] = "npc_dota_hero_luna"
		bot_heroes[6] = "npc_dota_hero_dragon_knight"
		bot_heroes[7] = "npc_dota_hero_tiny"
		bot_heroes[8] = "npc_dota_hero_bloodseeker"
		bot_heroes[9] = "npc_dota_hero_vengefulspirit"
		if radiant_bot_count > 0 then
			print("Adding bots to radiant team")
			for i = 1, radiant_bot_count do
				Tutorial:AddBot(bot_heroes[current_bot_hero], "", "", true)
				current_bot_hero = current_bot_hero + 1
			end
		end
		if dire_bot_count > 0 then
			print("Adding bots to dire team")
			for i = 1, dire_bot_count do
				Tutorial:AddBot(bot_heroes[current_bot_hero], "", "", false)
				current_bot_hero = current_bot_hero + 1
			end
		end
		Tutorial:StartTutorialMode()
	end
end

-- Global gold filter function
function GameMode:GoldFilter(keys)
	keys.gold = keys.gold * GAME_SPEED_MULTIPLIER

	-- Revtel investments
	local hero = PlayerResource:GetSelectedHeroEntity(keys.player_id_const)
	if hero:HasModifier("modifier_card_revtel_investments") then
		local gold_modifier = hero:FindModifierByName("modifier_card_revtel_investments")
		gold_modifier:SetStackCount(gold_modifier:GetStackCount() + keys.gold)
		keys.gold = 0
	end

	return true
end

-- Global experience filter function
function GameMode:ExpFilter(keys)
	--keys.experience: 40
	--keys.player_id_const: 1
	--keys.reason_const: 1
	keys.experience = keys.experience * GAME_SPEED_MULTIPLIER

	--local hero = PlayerResource:GetSelectedHeroEntity(keys.player_id_const)

	return true
end

-- Global damage filter function
function GameMode:DamageFilter(keys)
	-- keys.damage: 5
	-- keys.damagetype_const: 1
	-- keys.entindex_inflictor_const: 801	--optional
	-- keys.entindex_attacker_const: 172
	-- keys.entindex_victim_const: 379

	return true
end

-- Global modifier filter function
function GameMode:ModifierFilter(keys)
	--keys.duration: -1
	--keys.entindex_ability_const: 164	--optional
	--keys.entindex_caster_const: 163
	--keys.entindex_parent_const: 163
	--keys.name_const: modifier_kobold_taskmaster_speed_aura

	--local victim = EntIndexToHScript(keys.entindex_parent_const)

	return true
end

-- Global order filter function
function GameMode:OrderFilter(keys)

	-- keys.entindex_ability	 ==> 	0
	-- keys.sequence_number_const	 ==> 	20
	-- keys.queue	 ==> 	0
	-- keys.units	 ==> 	table: 0x031d5fd0
	-- keys.entindex_target	 ==> 	0
	-- keys.position_z	 ==> 	384
	-- keys.position_x	 ==> 	-5694.3334960938
	-- keys.order_type	 ==> 	1
	-- keys.position_y	 ==> 	-6381.1127929688
	-- keys.issuer_player_id_const	 ==> 	0

	local order_type = keys.order_type

	return true
end