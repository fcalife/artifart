-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc
require('dota_but')

-- BMD Libraries
require('libraries/timers')
require('libraries/playertables')
require('internal/gamesetup')
require('internal/events')
require('events')
require('artifart')

-- Game files
require('internal/util')

_G.GAME_SPEED_MULTIPLIER = 1
_G.MAX_CARDS = 5
_G.CARD_COUNT = 85

function Precache(context)

	-- Gamemode loading precache
	print("Performing pre-load precache")

	-- Examples
	-- PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
	-- PrecacheResource("model_folder", "particles/heroes/antimage", context)
	-- PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
	-- PrecacheItemByNameSync("example_ability", context)

	-- Main
	PrecacheResource("particle_folder", "particles/cards", context)
	PrecacheResource("soundfile", "soundevents/artifart_soundevents.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/soundevents_conquest.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lich.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_beastmaster.vsndevts", context)

	-- Card-specific
	PrecacheResource("particle", "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_beserkers_call.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_beserkers_call_hero_effect.vpcf", context)
	PrecacheResource("particle", "particles/apotheosis_blade_impact.vpcf", context)
	PrecacheResource("particle", "particles/apotheosis_blade_debuff.vpcf", context)
	PrecacheResource("particle", "particles/apotheosis_blade_debuff_mute.vpcf", context)
	PrecacheResource("particle", "particles/coup_de_grace.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo_debuff.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_ursa/ursa_enrage_hero_effect.vpcf", context)
	PrecacheResource("particle", "particles/econ/events/ti7/fountain_regen_ti7.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_centaur/centaur_return.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/legion/legion_fallen/legion_fallen_press.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_suicide.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_lone_druid_savage_roar.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodrage_eztzhok.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_bloodrage.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/spirit_breaker/spirit_breaker_iron_surge/spirit_breaker_charge_iron.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_defense_stance_shield.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_lich/lich_chain_frost.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/pugna/pugna_ward_ti5/pugna_ward_attack_light_ti_5.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/pugna/pugna_ward_ti5/pugna_ward_attack_medium_ti_5.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/pugna/pugna_ward_ti5/pugna_ward_attack_heavy_ti_5.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_immortal_cast.vpcf", context)

	-- We done
	print("Finished pre-load precache")
end

-- Create the game mode when we activate
function Activate()
	GameRules.GameMode = GameMode()
	GameRules.GameMode:_InitGameMode()
end
