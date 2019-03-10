-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:_InitGameMode()
	if GameMode._reentrantCheck then
		return
	end

	-- Setup game rules
	
	-- Should the heroes automatically respawn on a timer or stay dead until manually respawned?
	GameRules:SetHeroRespawnEnabled(true)
	-- Should the main shop contain Secret Shop items as well as regular items?
	GameRules:SetUseUniversalShopMode(true)
	-- Should we let people select the same hero as each other?
	GameRules:SetSameHeroSelectionEnabled(false)
	-- How long should we let people select their hero?
	GameRules:SetHeroSelectionTime(60)
	-- How long should strategy time last?
	GameRules:SetStrategyTime(0)
	-- How long should showcase time last?
	GameRules:SetShowcaseTime(0)
	-- How long after people select their heroes should the horn blow and the game start?
	GameRules:SetPreGameTime(60)
	-- How long should we let people look at the scoreboard before closing the server automatically?
	GameRules:SetPostGameTime(60)
	-- How long should it take individual trees to respawn after being cut down/destroyed?
	GameRules:SetTreeRegrowTime(180)
	-- Should we use custom XP values to level up heroes, or the default Dota numbers?
	GameRules:SetUseCustomHeroXPValues(false)
	-- How much gold should players get per tick?
	GameRules:SetGoldPerTick(1)
	-- How long should we wait in seconds between gold ticks?
	GameRules:SetGoldTickTime(0.66)
	-- How long in seconds should we wait between rune spawns?
	GameRules:SetRuneSpawnTime(120)
	-- Should we give gold for hero kills the same as in Dota, or allow those values to be changed?
	GameRules:SetUseBaseGoldBountyOnHeroes(true)
	-- What icon size should we use for our heroes?
	GameRules:SetHeroMinimapIconScale(1)
	-- What icon size should we use for creeps?
	GameRules:SetCreepMinimapIconScale(1)
	-- What icon size should we use for runes?
	GameRules:SetRuneMinimapIconScale(1)
	-- Should we enable first blood for the first kill in this game?
	GameRules:SetFirstBloodActive(true)
	-- Should we hide the kill banners that show when a player is killed?
	GameRules:SetHideKillMessageHeaders(false)
	-- How long should we wait after the game winner is set to display the victory banner and End Screen?  Use -1 to keep the default (about 10 seconds)
	GameRules:SetCustomGameEndDelay(-1)
	-- How long should we wait after the victory message displays to show the End Screen?
	GameRules:SetCustomVictoryMessageDuration(5)
	-- How much starting gold should we give to each player?
	GameRules:SetStartingGold(600)


	-- How long should the default team selection launch timer be? The default for custom games is 30.  Setting to 0 will skip team selection.
	GameRules:SetCustomGameSetupAutoLaunchDelay(30)
	-- Should we lock the teams initially? Note that the host can still unlock the teams.
	GameRules:LockCustomGameSetupTeamAssignment(false)
	-- Should we automatically have the game complete team setup after the automatic launch delay?
	GameRules:EnableCustomGameSetupAutoLaunch(true)


	-- Team player count configuration
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 5)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 5)

	-- Team color configuration
	--SetTeamCustomHealthbarColor(DOTA_TEAM_GOODGUYS, 50, 220, 50)

	-- Testing adjustments
	if IsInToolsMode() then
		--GameRules:SetPreGameTime(3)
	end

	print("Game rules (part 1) have been set...")

	-- Event Hooks
	ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(GameMode, 'OnPlayerLevelUp'), self)
	ListenToGameEvent('player_connect_full', Dynamic_Wrap(GameMode, '_OnConnectFull'), self)
	ListenToGameEvent('player_disconnect', Dynamic_Wrap(GameMode, 'OnDisconnect'), self)
	ListenToGameEvent('dota_item_purchased', Dynamic_Wrap(GameMode, 'OnItemPurchased'), self)
	ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(GameMode, 'OnItemPickedUp'), self)
	ListenToGameEvent('last_hit', Dynamic_Wrap(GameMode, 'OnLastHit'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(GameMode, 'OnEntityKilled'), self)
	ListenToGameEvent('player_changename', Dynamic_Wrap(GameMode, 'OnPlayerChangedName'), self)
	ListenToGameEvent('tree_cut', Dynamic_Wrap(GameMode, 'OnTreeCut'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(GameMode, '_OnGameRulesStateChange'), self)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(GameMode, '_OnNPCSpawned'), self)
	ListenToGameEvent('dota_player_pick_hero', Dynamic_Wrap(GameMode, 'OnPlayerPickHero'), self)
	ListenToGameEvent('dota_team_kill_credit', Dynamic_Wrap(GameMode, 'OnTeamKillCredit'), self)
	ListenToGameEvent("player_reconnected", Dynamic_Wrap(GameMode, 'OnPlayerReconnect'), self)
	ListenToGameEvent("dota_illusions_created", Dynamic_Wrap(GameMode, 'OnIllusionsCreated'), self)
	ListenToGameEvent("dota_item_combined", Dynamic_Wrap(GameMode, 'OnItemCombined'), self)
	ListenToGameEvent("player_chat", Dynamic_Wrap(GameMode, 'OnPlayerChat'), self)
	
	--ListenToGameEvent("dota_tutorial_shop_toggled", Dynamic_Wrap(GameMode, 'OnShopToggled'), self)
	--ListenToGameEvent('player_spawn', Dynamic_Wrap(GameMode, 'OnPlayerSpawn'), self)
	--ListenToGameEvent('dota_unit_event', Dynamic_Wrap(GameMode, 'OnDotaUnitEvent'), self)
	--ListenToGameEvent('nommed_tree', Dynamic_Wrap(GameMode, 'OnPlayerAteTree'), self)
	--ListenToGameEvent('player_completed_game', Dynamic_Wrap(GameMode, 'OnPlayerCompletedGame'), self)
	--ListenToGameEvent('dota_match_done', Dynamic_Wrap(GameMode, 'OnDotaMatchDone'), self)
	--ListenToGameEvent('dota_combatlog', Dynamic_Wrap(GameMode, 'OnCombatLogEvent'), self)
	--ListenToGameEvent('dota_player_killed', Dynamic_Wrap(GameMode, 'OnPlayerKilled'), self)
	--ListenToGameEvent('player_team', Dynamic_Wrap(GameMode, 'OnPlayerTeam'), self)

	-- Change random seed
	local timeTxt = string.gsub(string.gsub(GetSystemTime(), ':', ''), '^0+','')
	math.randomseed(tonumber(timeTxt))

	-- Initialized tables for tracking state
	self.bSeenWaitForPlayers = false
	self.vUserIds = {}

	print("Finished loading Barebones modules...")
	GameMode._reentrantCheck = true
	GameMode:InitGameMode()
	GameMode._reentrantCheck = false
end

mode = nil

-- This function is called as the first player loads and sets up the GameMode parameters
function GameMode:_CaptureGameMode()
	if mode == nil then

		-- Setup game rules
		mode = GameRules:GetGameModeEntity()

		-- Should we disable the recommended builds for heroes?
		mode:SetRecommendedItemsDisabled(false)
		-- How far out should we allow the camera to go? Default is 1134.
		mode:SetCameraDistanceOverride(1134)
		-- SHould we use default rune spawn rules?
		mode:SetUseDefaultDOTARuneSpawnLogic(true)

		-- Should we allow people to buyback when they die?
		mode:SetBuybackEnabled(true)
		-- Should we use a custom buyback cost setting?
		mode:SetCustomBuybackCostEnabled(false)
		-- Should we use a custom buyback time?
		mode:SetCustomBuybackCooldownEnabled(false)

		-- Should we do customized top bar values or use the default kill count per team?
		mode:SetTopBarTeamValuesOverride(false)
		-- Should we display the top bar score/count at all?
		mode:SetTopBarTeamValuesVisible(true)

		-- Should we allow heroes to have custom levels?
		mode:SetUseCustomHeroLevels(false)
		-- Insert a custom XP table here if necessary
		--mode:SetCustomXPRequiredToReachNextLevel()

		-- Should we have bots act like they would in Dota? (This requires 3 lanes, normal items, etc)
		mode:SetBotThinkingEnabled(true)
		-- Should we enable backdoor protection for our towers?
		mode:SetTowerBackdoorProtectionEnabled(true)

		-- Should we disable fog of war entirely for both teams?
		mode:SetFogOfWarDisabled(false)
		-- Should we make unseen and fogged areas of the map completely black until uncovered by each team? 
		mode:SetUnseenFogOfWarEnabled(false)

		-- Should we disable the gold sound when players get gold?
		mode:SetGoldSoundDisabled(false)
		-- Should we remove all illusions if the main hero dies?
		mode:SetRemoveIllusionsOnDeath(false)

		-- Should we only allow players to see their own inventory even when selecting other units?
		mode:SetAlwaysShowPlayerInventory(false)
		-- Should we disable the announcer from working in the game?
		mode:SetAnnouncerDisabled(false)

		-- What hero should we force all players to spawn as? (e.g. "npc_dota_hero_axe"). Use nil to allow players to pick their own hero.
		local force_pick_hero = nil
		if force_pick_hero ~= nil then
			mode:SetCustomGameForceHero(force_pick_hero)
		end

		-- What time should we use for a fixed respawn timer? Use -1 to keep the default dota behavior.
		mode:SetFixedRespawnTime(-1)
		-- What should we use for the constant fountain mana regen? Use -1 to keep the default dota behavior.
		mode:SetFountainConstantManaRegen(-1)
		-- What should we use for the percentage fountain health regen? Use -1 to keep the default dota behavior.
		mode:SetFountainPercentageHealthRegen(-1)
		-- What should we use for the percentage fountain mana regen?  Use -1 to keep the default dota behavior.
		mode:SetFountainPercentageManaRegen(-1)

		-- Should we have players lose the normal amount of dota gold on death?
		mode:SetLoseGoldOnDeath(true)

		-- What should we use for the maximum attack speed?
		mode:SetMaximumAttackSpeed(800)
		-- What should we use for the minimum attack speed?
		mode:SetMinimumAttackSpeed(20)

		-- Should we prevent players from being able to buy items into their stash when not at a shop?
		mode:SetStashPurchasingDisabled(false)

		-- Should we disable the day/night cycle from naturally occurring?
		mode:SetDaynightCycleDisabled(false)
		-- Shuold we disable the killing spree announcer?
		mode:SetKillingSpreeAnnouncerDisabled(false)
		-- Should we disable the sticky item button in the quick buy area?
		mode:SetStickyItemDisabled(false)
		-- Should the kill feed be disabled?
		--mode:SetHudCombatEventsDisabled(false)


		self:OnFirstPlayerLoaded()
		print("Game rules (part 2) have been set...")
	end 
end