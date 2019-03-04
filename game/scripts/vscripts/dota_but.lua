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
end

function GameMode:OnHeroInGame(hero)
	print(hero:GetUnitName() .. " spawned in game for the first time.")
end

function GameMode:OnGameInProgress()
	if IsServer() then
		print("The game has officially begun")
		Artifart:Initialize()
		Artifart:AddPeriodicCards()
		Artifart:AddPeriodicCards()
		Timers:CreateTimer(0, function()
			Artifart:AddPeriodicCards()
			return 60
		end)
	end
end

-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
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

	print("Initialization tasks done!")
end

-- Game speed change function
function GameMode:IncreaseGameSpeed(keys)
	GAME_SPEED_MULTIPLIER = keys.speed * 0.01
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