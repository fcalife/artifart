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
_G.CARD_COUNT = 46

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

	-- We done
	print("Finished pre-load precache")
end

-- Create the game mode when we activate
function Activate()
	GameRules.GameMode = GameMode()
	GameRules.GameMode:_InitGameMode()
end