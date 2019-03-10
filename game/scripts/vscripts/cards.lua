--	Card abilities

item_starter_deck = class({})

function item_starter_deck:OnSpellStart()
	if IsServer() then
		local player_id = self:GetCaster():GetPlayerID()
		Artifart:InitializeSinglePlayer(player_id)
		Artifart:AddRandomCard(player_id)
		Artifart:AddRandomCard(player_id)
		Artifart:AddRandomCard(player_id)
		self:Destroy()
	end
end

item_booster_pack = class({})

function item_booster_pack:OnSpellStart()
	if IsServer() then
		local player_id = self:GetCaster():GetPlayerID()
		Artifart:InitializeSinglePlayer(player_id)
		Artifart:AddRandomCard(player_id)
		Artifart:AddRandomCard(player_id)
		self:Destroy()
	end
end

card_leather_armor = class({})

function card_leather_armor:IsStealable() return false end
function card_leather_armor:IsHiddenAbilityCastable() return true end

function card_leather_armor:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_leather_armor.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_leather_armor", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "leather_armor")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_leather_armor", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_leather_armor = class({})

function modifier_card_leather_armor:IsDebuff() return false end
function modifier_card_leather_armor:IsHidden() return true end
function modifier_card_leather_armor:IsPurgable() return false end
function modifier_card_leather_armor:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_leather_armor:GetTexture()
	return "custom/card_leather_armor"
end

function modifier_card_leather_armor:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_card_leather_armor:GetModifierPhysicalArmorBonus()
	return 1
end



card_fountain_flask = class({})

function card_fountain_flask:IsStealable() return false end
function card_fountain_flask:IsHiddenAbilityCastable() return true end

function card_fountain_flask:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_fountain_flask.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_fountain_flask", {duration = 10})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "fountain_flask")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_fountain_flask", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_fountain_flask = class({})

function modifier_card_fountain_flask:IsDebuff() return false end
function modifier_card_fountain_flask:IsHidden() return false end
function modifier_card_fountain_flask:IsPurgable() return false end
function modifier_card_fountain_flask:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_fountain_flask:GetEffectName()
	return "particles/econ/events/ti7/fountain_regen_ti7.vpcf"
end

function modifier_card_fountain_flask:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_fountain_flask:GetTexture()
	return "custom/card_fountain_flask"
end

function modifier_card_fountain_flask:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE
	}
	return funcs
end

function modifier_card_fountain_flask:GetModifierHealthRegenPercentage()
	return 10
end

function modifier_card_fountain_flask:GetModifierTotalPercentageManaRegen()
	return 10
end



card_phase_boots = class({})

function card_phase_boots:IsStealable() return false end
function card_phase_boots:IsHiddenAbilityCastable() return true end

function card_phase_boots:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_phase_boots.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_phase_boots", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "phase_boots")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_phase_boots", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_phase_boots = class({})

function modifier_card_phase_boots:IsDebuff() return false end
function modifier_card_phase_boots:IsHidden() return false end
function modifier_card_phase_boots:IsPurgable() return false end
function modifier_card_phase_boots:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_phase_boots:GetTexture()
	return "custom/card_phase_boots"
end

function modifier_card_phase_boots:CheckState()
	local states = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true
	}
	return states
end

function modifier_card_phase_boots:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
	return funcs
end

function modifier_card_phase_boots:GetModifierMoveSpeedBonus_Percentage()
	return 12
end



card_golden_ticket = class({})

function card_golden_ticket:IsStealable() return false end
function card_golden_ticket:IsHiddenAbilityCastable() return true end

function card_golden_ticket:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_golden_ticket.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Grant the random item
		local new_item = CreateItem(Artifart.secret_shop_items[tostring(RandomInt(1, 15))], target, target)
		target:AddItem(new_item)

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "golden_ticket")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end



card_path_of_the_dreamer = class({})

function card_path_of_the_dreamer:IsStealable() return false end
function card_path_of_the_dreamer:IsHiddenAbilityCastable() return true end

function card_path_of_the_dreamer:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_path_of_the_dreamer.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_path_of_the_dreamer", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "path_of_the_dreamer")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_path_of_the_dreamer", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_path_of_the_dreamer = class({})

function modifier_card_path_of_the_dreamer:IsDebuff() return false end
function modifier_card_path_of_the_dreamer:IsHidden() return true end
function modifier_card_path_of_the_dreamer:IsPurgable() return false end
function modifier_card_path_of_the_dreamer:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_path_of_the_dreamer:GetTexture()
	return "custom/card_path_of_the_dreamer"
end

function modifier_card_path_of_the_dreamer:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
	return funcs
end

function modifier_card_path_of_the_dreamer:GetModifierConstantHealthRegen()
	return 5
end



card_grand_melee = class({})

function card_grand_melee:IsStealable() return false end
function card_grand_melee:IsHiddenAbilityCastable() return true end

function card_grand_melee:GetAOERadius()
	return 1000
end

function card_grand_melee:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target_loc = self:GetCursorPosition()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		EmitSoundOnLocationWithCaster(target_loc, "Artifart.UseCard", caster)
		EmitSoundOnLocationWithCaster(target_loc, "Artifart.ForwardCharge", caster)

		-- Find targets
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), target_loc, nil, 1000, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
		for _, target in pairs(targets) do
			target:AddNewModifier(caster, nil, "modifier_card_grand_melee", {x = target_loc.x, y = target_loc.y, duration = 10})

			local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_grand_melee.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
			ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(cast_pfx)
		end

		-- Taunt particle
		local taunt_pfx = ParticleManager:CreateParticle("particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(taunt_pfx, 0, target_loc)
		ParticleManager:SetParticleControl(taunt_pfx, 2, Vector(1000, 0, 0))
		ParticleManager:ReleaseParticleIndex(taunt_pfx)

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "grand_melee")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_grand_melee", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_grand_melee = class({})

function modifier_card_grand_melee:IsDebuff() return true end
function modifier_card_grand_melee:IsHidden() return false end
function modifier_card_grand_melee:IsPurgable() return false end
function modifier_card_grand_melee:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_grand_melee:GetTexture()
	return "custom/card_grand_melee"
end

function modifier_card_grand_melee:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_beserkers_call.vpcf"
end

function modifier_card_grand_melee:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_grand_melee:GetStatusEffectName()
	return "particles/units/heroes/hero_axe/axe_beserkers_call_hero_effect.vpcf"
end

function modifier_card_grand_melee:OnCreated(keys)
	if IsServer() then
		self.origin = Vector(keys.x, keys.y, 0)
		self.target = false
		self:StartIntervalThink(0.03)
	end
end

function modifier_card_grand_melee:OnDestroy()
	if IsServer() then
		self:GetParent():SetForceAttackTarget(nil)
	end
end

function modifier_card_grand_melee:OnIntervalThink()
	if (not self.target) or (not self.target:IsAlive()) then
		self.target = self:LookForTarget(self.origin)
		if self.target then
			self:GetParent():SetForceAttackTarget(self.target)
		else
			self:Destroy()
		end
	end
end

function modifier_card_grand_melee:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
	return funcs
end

function modifier_card_grand_melee:GetModifierAttackSpeedBonus_Constant()
	return 100
end

function modifier_card_grand_melee:LookForTarget(origin)
	local parent = self:GetParent()
	local enemies = FindUnitsInRadius(parent:GetTeamNumber(), origin, nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
	if #enemies > 0 then
		return enemies[1]
	else
		return nil
	end
end



card_apotheosis_blade = class({})

function card_apotheosis_blade:IsStealable() return false end
function card_apotheosis_blade:IsHiddenAbilityCastable() return true end

function card_apotheosis_blade:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_apotheosis_blade.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Grant the item
		local new_item = CreateItem("item_apotheosis_blade", target, target)
		target:AddItem(new_item)

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "apotheosis_blade")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

item_apotheosis_blade = class({})

function item_apotheosis_blade:GetIntrinsicModifierName()
	return "modifier_item_apotheosis_blade"
end

LinkLuaModifier("modifier_item_apotheosis_blade", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_item_apotheosis_blade = class({})

function modifier_item_apotheosis_blade:IsHidden() return true end
function modifier_item_apotheosis_blade:IsDebuff() return false end
function modifier_item_apotheosis_blade:IsPurgable() return false end
function modifier_item_apotheosis_blade:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_apotheosis_blade:GetTexture()
	return "custom/item_apotheosis_blade"
end

function modifier_item_apotheosis_blade:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_DEATH
	}
	return funcs
end

function modifier_item_apotheosis_blade:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_apotheosis_blade:OnDeath(keys)
	if IsServer() then
		if keys.unit == self:GetParent() then
			self:GetAbility():Destroy()
		end
	end
end

function modifier_item_apotheosis_blade:OnAttackLanded(keys)
	if IsServer() then
		if keys.attacker == self:GetParent() then

			-- Visual and sound do not repeat if the target is already affected by the debuff
			if not keys.target:HasModifier("modifier_item_apotheosis_blade_debuff") then
				local impact_pfx = ParticleManager:CreateParticle("particles/apotheosis_blade_impact.vpcf", PATTACH_ABSORIGIN, keys.target)
				ParticleManager:SetParticleControl(impact_pfx, 0, keys.target:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(impact_pfx)
				keys.target:EmitSound("Artifart.ApotheosisBlade")
			end

			local duration = self:GetAbility():GetSpecialValueFor("mute_duration")
			local dps = self:GetAbility():GetSpecialValueFor("mute_dps")
			keys.target:AddNewModifier(self:GetParent(), nil, "modifier_item_apotheosis_blade_debuff", {duration = duration, dps = dps})
		end
	end
end

LinkLuaModifier("modifier_item_apotheosis_blade_debuff", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_item_apotheosis_blade_debuff = class({})

function modifier_item_apotheosis_blade_debuff:IsHidden() return false end
function modifier_item_apotheosis_blade_debuff:IsDebuff() return true end
function modifier_item_apotheosis_blade_debuff:IsPurgable() return true end

function modifier_item_apotheosis_blade_debuff:GetTexture()
	return "custom/item_apotheosis_blade"
end

function modifier_item_apotheosis_blade_debuff:GetEffectName()
	return "particles/apotheosis_blade_debuff.vpcf"
end

function modifier_item_apotheosis_blade_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_apotheosis_blade_debuff:CheckState()
	local states = {
		[MODIFIER_STATE_MUTED] = true
	}
	return states
end

function modifier_item_apotheosis_blade_debuff:OnCreated(keys)
	if IsServer() then
		self.dps = self:GetParent():GetMaxHealth() * keys.dps * 0.01
		self:StartIntervalThink(1.0)
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_item_apotheosis_blade_debuff_visual", {})
	end
end

function modifier_item_apotheosis_blade_debuff:OnDestroy(keys)
	if IsServer() then
		self:GetParent():RemoveModifierByName("modifier_item_apotheosis_blade_debuff_visual")
	end
end

function modifier_item_apotheosis_blade_debuff:OnIntervalThink()
	if IsServer() then
		local actual_damage = ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.dps, damage_type = DAMAGE_TYPE_PURE})
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self:GetParent(), actual_damage, nil)
	end
end

LinkLuaModifier("modifier_item_apotheosis_blade_debuff_visual", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_item_apotheosis_blade_debuff_visual = class({})

function modifier_item_apotheosis_blade_debuff_visual:IsHidden() return true end
function modifier_item_apotheosis_blade_debuff_visual:IsDebuff() return true end
function modifier_item_apotheosis_blade_debuff_visual:IsPurgable() return true end

function modifier_item_apotheosis_blade_debuff_visual:GetEffectName()
	return "particles/apotheosis_blade_debuff_mute.vpcf"
end

function modifier_item_apotheosis_blade_debuff_visual:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end



card_forward_charge = class({})

function card_forward_charge:IsStealable() return false end
function card_forward_charge:IsHiddenAbilityCastable() return true end

function card_forward_charge:GetAOERadius()
	return 1000
end

function card_forward_charge:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()
		local target_loc = target:GetAbsOrigin()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")
		target:EmitSound("Artifart.ForwardCharge")

		-- Find targets
		local allies = FindUnitsInRadius(caster:GetTeamNumber(), target_loc, nil, 1000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
		for _, ally in pairs(allies) do
			ally:AddNewModifier(target, nil, "modifier_card_forward_charge", {duration = 10})

			local ally_pfx = ParticleManager:CreateParticle("particles/cards/card_use_forward_charge_ally.vpcf", PATTACH_ABSORIGIN_FOLLOW, ally)
			ParticleManager:SetParticleControl(ally_pfx, 0, ally:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(ally_pfx)
		end

		-- Particles
		local taunt_pfx = ParticleManager:CreateParticle("particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(taunt_pfx, 0, target_loc)
		ParticleManager:SetParticleControl(taunt_pfx, 2, Vector(1000, 0, 0))
		ParticleManager:ReleaseParticleIndex(taunt_pfx)

		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_forward_charge.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target_loc)
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "forward_charge")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_forward_charge", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_forward_charge = class({})

function modifier_card_forward_charge:IsDebuff() return false end
function modifier_card_forward_charge:IsHidden() return false end
function modifier_card_forward_charge:IsPurgable() return false end
function modifier_card_forward_charge:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_forward_charge:GetTexture()
	return "custom/card_forward_charge"
end

function modifier_card_forward_charge:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_beserkers_call.vpcf"
end

function modifier_card_forward_charge:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_forward_charge:GetStatusEffectName()
	return "particles/units/heroes/hero_axe/axe_beserkers_call_hero_effect.vpcf"
end

function modifier_card_forward_charge:OnCreated(keys)
	if IsServer() then
		self.target = self:GetCaster()
		self:GetParent():SetForceAttackTarget(self.target)
		self:StartIntervalThink(0.03)
	end
end

function modifier_card_forward_charge:OnDestroy()
	if IsServer() then
		self:GetParent():SetForceAttackTarget(nil)
	end
end

function modifier_card_forward_charge:OnIntervalThink()
	if IsServer() then
		if (not self.target) or (not self.target:IsAlive()) then
			self:Destroy()
		end
	end
end

function modifier_card_forward_charge:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
	}
	return funcs
end

function modifier_card_forward_charge:GetModifierDamageOutgoing_Percentage()
	return 100
end



card_tower_barrage = class({})

function card_tower_barrage:IsStealable() return false end
function card_tower_barrage:IsHiddenAbilityCastable() return true end

function card_tower_barrage:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local player_id = caster:GetPlayerID()

		-- Enemy team sound cue
		Timers:CreateTimer(1, function()
			EmitGlobalSound("Conquest.Glyph.Cast")
		end)

		-- Find targets
		local buildings = FindUnitsInRadius(caster:GetTeamNumber(), Vector(0, 0, 0), nil, 25000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
		for _, building in pairs(buildings) do
			building:AddNewModifier(caster, nil, "modifier_card_tower_barrage", {duration = 10})

			building:EmitSound("Artifart.UseCard")

			local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_tower_barrage.vpcf", PATTACH_ABSORIGIN_FOLLOW, building)
			ParticleManager:SetParticleControl(cast_pfx, 0, building:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(cast_pfx)
		end

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "tower_barrage")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_tower_barrage", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_tower_barrage = class({})

function modifier_card_tower_barrage:IsDebuff() return false end
function modifier_card_tower_barrage:IsHidden() return false end
function modifier_card_tower_barrage:IsPurgable() return false end
function modifier_card_tower_barrage:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_tower_barrage:GetTexture()
	return "custom/card_tower_barrage"
end

function modifier_card_tower_barrage:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS
	}
	return funcs
end

function modifier_card_tower_barrage:GetModifierAttackRangeBonus()
	return 10000
end

function modifier_card_tower_barrage:GetModifierProjectileSpeedBonus()
	return 1500
end



card_watchtower = class({})

function card_watchtower:IsStealable() return false end
function card_watchtower:IsHiddenAbilityCastable() return true end

function card_watchtower:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_watchtower.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_watchtower", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "watchtower")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_watchtower", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_watchtower = class({})

function modifier_card_watchtower:IsDebuff() return false end
function modifier_card_watchtower:IsHidden() return false end
function modifier_card_watchtower:IsPurgable() return false end
function modifier_card_watchtower:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_watchtower:GetTexture()
	return "custom/card_watchtower"
end

function modifier_card_watchtower:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS
	}
	return funcs
end

function modifier_card_watchtower:GetModifierAttackRangeBonus()
	return 700
end

function modifier_card_watchtower:GetModifierProjectileSpeedBonus()
	return 350
end



card_strafing_run = class({})

function card_strafing_run:IsStealable() return false end
function card_strafing_run:IsHiddenAbilityCastable() return true end

function card_strafing_run:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_strafing_run.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_strafing_run", {duration = 30})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "strafing_run")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_strafing_run", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_strafing_run = class({})

function modifier_card_strafing_run:IsDebuff() return false end
function modifier_card_strafing_run:IsHidden() return false end
function modifier_card_strafing_run:IsPurgable() return false end
function modifier_card_strafing_run:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_strafing_run:GetTexture()
	return "custom/card_strafing_run"
end

function modifier_card_strafing_run:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function modifier_card_strafing_run:GetModifierMoveSpeedBonus_Percentage()
	return 50
end

function modifier_card_strafing_run:OnAttackLanded(keys)
	if IsServer() then
		if keys.attacker == self:GetParent() then
			if not (keys.target:IsHero() or keys.target:IsBuilding() or keys.target:IsBoss()) then
				keys.target:Kill(nil, keys.attacker)
			end
		end
	end
end



card_coup_de_grace = class({})

function card_coup_de_grace:IsStealable() return false end
function card_coup_de_grace:IsHiddenAbilityCastable() return true end

function card_coup_de_grace:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")
		Timers:CreateTimer(2, function()
			target:EmitSound("Artifart.CoupDeGrace")
		end)
		Timers:CreateTimer(5, function()
			target:EmitSound("Artifart.CoupDeGrace2")
		end)
		Timers:CreateTimer(8, function()
			target:EmitSound("Artifart.CoupDeGrace3")
		end)

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_coup_de_grace.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_coup_de_grace", {duration = 10})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "coup_de_grace")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_coup_de_grace", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_coup_de_grace = class({})

function modifier_card_coup_de_grace:IsDebuff() return true end
function modifier_card_coup_de_grace:IsHidden() return false end
function modifier_card_coup_de_grace:IsPurgable() return false end
function modifier_card_coup_de_grace:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_coup_de_grace:GetTexture()
	return "custom/card_coup_de_grace"
end

function modifier_card_coup_de_grace:GetEffectName()
	return "particles/coup_de_grace.vpcf"
end

function modifier_card_coup_de_grace:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_coup_de_grace:OnCreated(keys)
	if IsServer() then
		self.damage_tick = 0.01 * self:GetParent():GetMaxHealth()
		self:StartIntervalThink(0.1)
	end
end

function modifier_card_coup_de_grace:OnIntervalThink()
	if IsServer() then
		ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage_tick, damage_type = DAMAGE_TYPE_PURE})
	end
end



card_prey_on_the_weak = class({})

function card_prey_on_the_weak:IsStealable() return false end
function card_prey_on_the_weak:IsHiddenAbilityCastable() return true end

function card_prey_on_the_weak:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		caster:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_prey_on_the_weak_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControl(cast_pfx, 0, caster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Find targets
		local units = FindUnitsInRadius(caster:GetTeamNumber(), Vector(0, 0, 0), nil, 25000, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if unit:GetHealth() ~= unit:GetMaxHealth() then

				local unit_pfx = ParticleManager:CreateParticle("particles/cards/card_use_prey_on_the_weak.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
				ParticleManager:SetParticleControl(unit_pfx, 0, unit:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(unit_pfx)

				local hound = CreateUnitByName("npc_artifart_prey_on_the_weak_summon", unit:GetAbsOrigin() + RandomVector(150), false, caster, caster, caster:GetTeamNumber())
				FindClearSpaceForUnit(hound, hound:GetAbsOrigin(), true)
				hound:SetControllableByPlayer(player_id, true)
				hound:FindAbilityByName("prey_on_the_weak_hound_poison"):SetLevel(1)
				if caster:GetTeam() == DOTA_TEAM_GOODGUYS then
					hound:MoveToPositionAggressive(Vector(7040, 6464, 400))
				elseif caster:GetTeam() == DOTA_TEAM_BADGUYS then
					hound:MoveToPositionAggressive(Vector(-7168, -6656, 400))
				end
			end
		end

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "prey_on_the_weak")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end



card_bristleback = class({})

function card_bristleback:IsStealable() return false end
function card_bristleback:IsHiddenAbilityCastable() return true end

function card_bristleback:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_bristleback.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Grant the item
		target:AddNewModifier(caster, self, "modifier_card_bristleback", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "bristleback")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_bristleback", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_bristleback = class({})

function modifier_card_bristleback:IsHidden() return false end
function modifier_card_bristleback:IsDebuff() return false end
function modifier_card_bristleback:IsPurgable() return false end
function modifier_card_bristleback:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_bristleback:GetTexture()
	return "custom/card_bristleback"
end

function modifier_card_bristleback:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function modifier_card_bristleback:OnAttackLanded(keys)
	if IsServer() then
		if keys.attacker == self:GetParent() then
			if not keys.target:HasModifier("modifier_card_bristleback_debuff") then
				keys.target:EmitSound("Artifart.ViscousNasalGoo")
			end
			keys.target:AddNewModifier(self:GetParent(), nil, "modifier_card_bristleback_debuff", {duration = 3})
			local modifier_goo = keys.target:FindModifierByName("modifier_card_bristleback_debuff")
			modifier_goo:SetStackCount(modifier_goo:GetStackCount() + 1)
		end
	end
end

LinkLuaModifier("modifier_card_bristleback_debuff", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_bristleback_debuff = class({})

function modifier_card_bristleback_debuff:IsHidden() return false end
function modifier_card_bristleback_debuff:IsDebuff() return true end
function modifier_card_bristleback_debuff:IsPurgable() return true end

function modifier_card_bristleback_debuff:GetTexture()
	return "custom/card_bristleback"
end

function modifier_card_bristleback_debuff:GetEffectName()
	return "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo_debuff.vpcf"
end

function modifier_card_bristleback_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_bristleback_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_card_bristleback_debuff:GetModifierPhysicalArmorBonus()
	return (-2) * self:GetStackCount()
end

function modifier_card_bristleback_debuff:GetModifierMoveSpeedBonus_Percentage()
	return (-8) * self:GetStackCount()
end



card_centaur = class({})

function card_centaur:IsStealable() return false end
function card_centaur:IsHiddenAbilityCastable() return true end

function card_centaur:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_centaur.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Grant the modifier
		target:AddNewModifier(caster, self, "modifier_card_centaur", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "centaur")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_centaur", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_centaur = class({})

function modifier_card_centaur:IsHidden() return false end
function modifier_card_centaur:IsDebuff() return false end
function modifier_card_centaur:IsPurgable() return false end
function modifier_card_centaur:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_centaur:GetTexture()
	return "custom/card_centaur"
end

function modifier_card_centaur:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf"
end

function modifier_card_centaur:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_centaur:GetStatusEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_hero_effect.vpcf"
end

function modifier_card_centaur:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
	return funcs
end

function modifier_card_centaur:GetModifierTotalDamageOutgoing_Percentage()
	return 100
end

function modifier_card_centaur:GetModifierIncomingDamage_Percentage()
	return 100
end



card_revtel_investments = class({})

function card_revtel_investments:IsStealable() return false end
function card_revtel_investments:IsHiddenAbilityCastable() return true end

function card_revtel_investments:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_revtel_investments.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Grant the modifier
		target:AddNewModifier(caster, self, "modifier_card_revtel_investments", {duration = 180})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "revtel_investments")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_revtel_investments", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_revtel_investments = class({})

function modifier_card_revtel_investments:IsHidden() return false end
function modifier_card_revtel_investments:IsDebuff() return false end
function modifier_card_revtel_investments:IsPurgable() return false end
function modifier_card_revtel_investments:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_revtel_investments:GetTexture()
	return "custom/card_revtel_investments"
end

function modifier_card_revtel_investments:OnDestroy()
	if IsServer() then
		local gained_gold = self:GetStackCount()
		for player_id = 0, DOTA_MAX_TEAM_PLAYERS do
			if PlayerResource:IsValidPlayer(player_id) and (PlayerResource:GetTeam(player_id) == self:GetParent():GetTeam()) then
				PlayerResource:ModifyGold(player_id, gained_gold, false, DOTA_ModifyGold_CreepKill)
				SendOverheadEventMessage(nil, OVERHEAD_ALERT_GOLD , PlayerResource:GetSelectedHeroEntity(player_id), gained_gold, nil)
			end
		end
	end
end

function modifier_card_revtel_investments:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH
	}
	return funcs
end

function modifier_card_revtel_investments:OnDeath(keys)
	if IsServer() then
		if keys.unit == self:GetParent() then
			self:SetStackCount(0)
		end
	end
end



card_stars_align = class({})

function card_stars_align:IsStealable() return false end
function card_stars_align:IsHiddenAbilityCastable() return true end

function card_stars_align:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_stars_align.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_stars_align", {duration = 10})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "stars_align")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_stars_align", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_stars_align = class({})

function modifier_card_stars_align:IsDebuff() return false end
function modifier_card_stars_align:IsHidden() return false end
function modifier_card_stars_align:IsPurgable() return false end
function modifier_card_stars_align:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_stars_align:GetEffectName()
	return "particles/items_fx/healing_clarity.vpcf"
end

function modifier_card_stars_align:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_stars_align:GetTexture()
	return "custom/card_stars_align"
end

function modifier_card_stars_align:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE
	}
	return funcs
end

function modifier_card_stars_align:GetModifierTotalPercentageManaRegen()
	return 10
end



card_healing_salve = class({})

function card_healing_salve:IsStealable() return false end
function card_healing_salve:IsHiddenAbilityCastable() return true end

function card_healing_salve:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_healing_salve.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_healing_salve", {duration = 10})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "healing_salve")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_healing_salve", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_healing_salve = class({})

function modifier_card_healing_salve:IsDebuff() return false end
function modifier_card_healing_salve:IsHidden() return false end
function modifier_card_healing_salve:IsPurgable() return false end
function modifier_card_healing_salve:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_healing_salve:GetEffectName()
	return "particles/items_fx/healing_flask.vpcf"
end

function modifier_card_healing_salve:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_healing_salve:GetTexture()
	return "custom/card_healing_salve"
end

function modifier_card_healing_salve:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
	}
	return funcs
end

function modifier_card_healing_salve:GetModifierHealthRegenPercentage()
	return 10
end



card_short_sword = class({})

function card_short_sword:IsStealable() return false end
function card_short_sword:IsHiddenAbilityCastable() return true end

function card_short_sword:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_short_sword.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_short_sword", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "short_sword")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_short_sword", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_short_sword = class({})

function modifier_card_short_sword:IsDebuff() return false end
function modifier_card_short_sword:IsHidden() return true end
function modifier_card_short_sword:IsPurgable() return false end
function modifier_card_short_sword:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_short_sword:GetTexture()
	return "custom/card_short_sword"
end

function modifier_card_short_sword:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
	return funcs
end

function modifier_card_short_sword:GetModifierPreAttack_BonusDamage()
	return 10
end



card_fur_lined_mantle = class({})

function card_fur_lined_mantle:IsStealable() return false end
function card_fur_lined_mantle:IsHiddenAbilityCastable() return true end

function card_fur_lined_mantle:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_fur_lined_mantle.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_fur_lined_mantle", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "fur_lined_mantle")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_fur_lined_mantle", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_fur_lined_mantle = class({})

function modifier_card_fur_lined_mantle:IsDebuff() return false end
function modifier_card_fur_lined_mantle:IsHidden() return true end
function modifier_card_fur_lined_mantle:IsPurgable() return false end
function modifier_card_fur_lined_mantle:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_fur_lined_mantle:GetTexture()
	return "custom/card_fur_lined_mantle"
end

function modifier_card_fur_lined_mantle:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
	return funcs
end

function modifier_card_fur_lined_mantle:GetModifierMagicalResistanceBonus()
	return 15
end



card_burning_oil = class({})

function card_burning_oil:IsStealable() return false end
function card_burning_oil:IsHiddenAbilityCastable() return true end

function card_burning_oil:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_burning_oil.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_burning_oil", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "burning_oil")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_burning_oil", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_burning_oil = class({})

function modifier_card_burning_oil:IsDebuff() return false end
function modifier_card_burning_oil:IsHidden() return false end
function modifier_card_burning_oil:IsPurgable() return false end
function modifier_card_burning_oil:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_burning_oil:GetTexture()
	return "custom/card_burning_oil"
end

function modifier_card_burning_oil:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACKED
	}
	return funcs
end

function modifier_card_burning_oil:OnAttacked(keys)
	if IsServer() then
		if keys.target == self:GetParent() then
			ApplyDamage({victim = keys.attacker, attacker = keys.target, damage = 80, damage_type = DAMAGE_TYPE_PHYSICAL})
			local return_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_return.vpcf", PATTACH_ABSORIGIN, keys.target)
			ParticleManager:SetParticleControlEnt(return_pfx, 0, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(return_pfx, 1, keys.attacker, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.attacker:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(return_pfx)
		end
	end			
end



card_whispers_of_madness = class({})

function card_whispers_of_madness:IsStealable() return false end
function card_whispers_of_madness:IsHiddenAbilityCastable() return true end

function card_whispers_of_madness:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local player_id = caster:GetPlayerID()

		-- Find targets
		local heroes = FindUnitsInRadius(caster:GetTeamNumber(), Vector(0, 0, 0), nil, 25000, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
		for _, hero in pairs(heroes) do
			hero:AddNewModifier(target, nil, "modifier_stunned", {duration = 5})

			hero:EmitSound("Artifart.UseCard")

			local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_whispers_of_madness.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
			ParticleManager:SetParticleControl(cast_pfx, 0, hero:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(cast_pfx)
		end

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "whispers_of_madness")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end



card_heroic_resolve = class({})

function card_heroic_resolve:IsStealable() return false end
function card_heroic_resolve:IsHiddenAbilityCastable() return true end

function card_heroic_resolve:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_heroic_resolve.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_heroic_resolve", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "heroic_resolve")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_heroic_resolve", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_heroic_resolve = class({})

function modifier_card_heroic_resolve:IsDebuff() return false end
function modifier_card_heroic_resolve:IsHidden() return false end
function modifier_card_heroic_resolve:IsPurgable() return false end
function modifier_card_heroic_resolve:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_heroic_resolve:GetTexture()
	return "custom/card_heroic_resolve"
end

function modifier_card_heroic_resolve:OnCreated(keys)
	if IsServer() then
		self:StartIntervalThink(1.0)
	end
end

function modifier_card_heroic_resolve:OnIntervalThink()
	if IsServer() then
		self:SetStackCount(self:GetStackCount() + 3)
		self:GetParent():CalculateStatBonus()
	end
end

function modifier_card_heroic_resolve:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS
	}
	return funcs
end

function modifier_card_heroic_resolve:GetModifierExtraHealthBonus()
	return self:GetStackCount()
end



card_rising_anger = class({})

function card_rising_anger:IsStealable() return false end
function card_rising_anger:IsHiddenAbilityCastable() return true end

function card_rising_anger:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_rising_anger.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_rising_anger", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "rising_anger")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_rising_anger", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_rising_anger = class({})

function modifier_card_rising_anger:IsDebuff() return false end
function modifier_card_rising_anger:IsHidden() return false end
function modifier_card_rising_anger:IsPurgable() return false end
function modifier_card_rising_anger:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_rising_anger:GetTexture()
	return "custom/card_rising_anger"
end

function modifier_card_rising_anger:OnCreated(keys)
	if IsServer() then
		self:StartIntervalThink(1.0)
	end
end

function modifier_card_rising_anger:OnIntervalThink()
	if IsServer() then
		self:SetStackCount(self:GetStackCount() + 1)
	end
end

function modifier_card_rising_anger:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
	return funcs
end

function modifier_card_rising_anger:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount()
end



card_the_oath = class({})

function card_the_oath:IsStealable() return false end
function card_the_oath:IsHiddenAbilityCastable() return true end

function card_the_oath:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_the_oath.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_the_oath", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "the_oath")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_the_oath", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_the_oath = class({})

function modifier_card_the_oath:IsDebuff() return true end
function modifier_card_the_oath:IsHidden() return false end
function modifier_card_the_oath:IsPurgable() return false end
function modifier_card_the_oath:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_the_oath:IsAura()
	return true
end

function modifier_card_the_oath:GetAuraRadius() return 1200 end
function modifier_card_the_oath:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_card_the_oath:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_card_the_oath:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_card_the_oath:GetModifierAura() return "modifier_card_the_oath_buff" end
function modifier_card_the_oath:GetAuraEntityReject(unit)
	if IsServer() then
		if unit == self:GetParent() then
			return true
		else
			return false
		end
	end
end

function modifier_card_the_oath:GetTexture()
	return "custom/card_the_oath"
end

function modifier_card_the_oath:GetEffectName()
	return "particles/cards/the_oath_aura.vpcf"
end

function modifier_card_the_oath:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_the_oath:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_EVENT_ON_DEATH
	}
	return funcs
end

function modifier_card_the_oath:GetModifierTotalDamageOutgoing_Percentage()
	return -200
end

function modifier_card_the_oath:OnDeath(keys)
	if IsServer() then
		if keys.unit == self:GetParent() then
			self:Destroy()
		end
	end
end

LinkLuaModifier("modifier_card_the_oath_buff", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_the_oath_buff = class({})

function modifier_card_the_oath_buff:IsHidden() return false end
function modifier_card_the_oath_buff:IsDebuff() return false end
function modifier_card_the_oath_buff:IsPurgable() return false end
function modifier_card_the_oath_buff:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_the_oath_buff:GetTexture()
	return "custom/card_the_oath"
end

function modifier_card_the_oath_buff:GetEffectName()
	return "particles/cards/the_oath_aura_buff.vpcf"
end

function modifier_card_the_oath_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_the_oath_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
	}
	return funcs
end

function modifier_card_the_oath_buff:GetModifierTotalDamageOutgoing_Percentage()
	return 100
end



card_at_any_cost = class({})

function card_at_any_cost:IsStealable() return false end
function card_at_any_cost:IsHiddenAbilityCastable() return true end

function card_at_any_cost:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_at_any_cost.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_at_any_cost", {duration = 10})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "at_any_cost")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_at_any_cost", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_at_any_cost = class({})

function modifier_card_at_any_cost:IsHidden() return false end
function modifier_card_at_any_cost:IsDebuff() return false end
function modifier_card_at_any_cost:IsPurgable() return false end
function modifier_card_at_any_cost:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_at_any_cost:GetTexture()
	return "custom/card_at_any_cost"
end

function modifier_card_at_any_cost:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE
	}
	return funcs
end

function modifier_card_at_any_cost:OnTakeDamage(keys)
	if IsServer() then
		if keys.attacker == self:GetParent() then
			if not keys.attacker:HasModifier("modifier_card_at_any_cost_loop_prevention") then
				keys.attacker:AddNewModifier(keys.attacker, nil, "modifier_card_at_any_cost_loop_prevention", {})
				local units = FindUnitsInRadius(keys.attacker:GetTeamNumber(), Vector(0, 0, 0), nil, 25000, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
				for _, unit in pairs(units) do
					if unit ~= keys.attacker and unit ~= keys.unit then
						ApplyDamage({victim = unit, attacker = keys.attacker, damage = keys.original_damage, damage_type = keys.damage_type})
					end
				end
				keys.attacker:RemoveModifierByName("modifier_card_at_any_cost_loop_prevention")
			end
		end
	end
end

LinkLuaModifier("modifier_card_at_any_cost_loop_prevention", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_at_any_cost_loop_prevention = class({})

function modifier_card_at_any_cost_loop_prevention:IsHidden() return true end
function modifier_card_at_any_cost_loop_prevention:IsDebuff() return true end
function modifier_card_at_any_cost_loop_prevention:IsPurgable() return false end
function modifier_card_at_any_cost_loop_prevention:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end



card_murder_plot = class({})

function card_murder_plot:IsStealable() return false end
function card_murder_plot:IsHiddenAbilityCastable() return true end

function card_murder_plot:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_murder_plot.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_murder_plot", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "murder_plot")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_murder_plot", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_murder_plot = class({})

function modifier_card_murder_plot:IsHidden() return false end
function modifier_card_murder_plot:IsDebuff() return false end
function modifier_card_murder_plot:IsPurgable() return false end
function modifier_card_murder_plot:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_murder_plot:GetTexture()
	return "custom/card_murder_plot"
end

function modifier_card_murder_plot:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function modifier_card_murder_plot:GetModifierPreAttack_CriticalStrike()
	return 1000
end

function modifier_card_murder_plot:OnAttackLanded(keys)
	if IsServer() then
		if keys.attacker == self:GetParent() and (not keys.target:IsBuilding()) then
			self:Destroy()
		end
	end
end



card_caught_unprepared = class({})

function card_caught_unprepared:IsStealable() return false end
function card_caught_unprepared:IsHiddenAbilityCastable() return true end

function card_caught_unprepared:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_caught_unprepared.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Stun
		local stun_duration = 13.5
		for i = 0, 5 do
			local item = target:GetItemInSlot(i)
			if item then
				stun_duration = stun_duration -2
			end
		end
		target:AddNewModifier(caster, nil, "modifier_stunned", {duration = stun_duration})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "caught_unprepared")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end



card_revtel_convoy = class({})

function card_revtel_convoy:IsStealable() return false end
function card_revtel_convoy:IsHiddenAbilityCastable() return true end

function card_revtel_convoy:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_revtel_convoy.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_revtel_convoy", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "revtel_convoy")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_revtel_convoy", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_revtel_convoy = class({})

function modifier_card_revtel_convoy:IsHidden() return false end
function modifier_card_revtel_convoy:IsDebuff() return false end
function modifier_card_revtel_convoy:IsPurgable() return false end
function modifier_card_revtel_convoy:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_revtel_convoy:GetTexture()
	return "custom/card_revtel_convoy"
end

function modifier_card_revtel_convoy:OnCreated()
	if IsServer() then
		self:SetStackCount(0)
		self:StartIntervalThink(0.1)
	end
end

function modifier_card_revtel_convoy:OnIntervalThink()
	if IsServer() then
		self:SetStackCount(self:GetParent():GetGold() / 15)
	end
end

function modifier_card_revtel_convoy:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
	return funcs
end

function modifier_card_revtel_convoy:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount()
end



card_corrosive_mist = class({})

function card_corrosive_mist:IsStealable() return false end
function card_corrosive_mist:IsHiddenAbilityCastable() return true end

function card_corrosive_mist:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local player_id = caster:GetPlayerID()

		-- Find targets
		local enemies = FindUnitsInRadius(caster:GetTeamNumber(), Vector(0, 0, 0), nil, 25000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
		for _, enemy in pairs(enemies) do
			enemy:AddNewModifier(caster, nil, "modifier_card_corrosive_mist", {duration = 7})

			enemy:EmitSound("Artifart.UseCard")

			local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_corrosive_mist.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
			ParticleManager:SetParticleControl(cast_pfx, 0, enemy:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(cast_pfx)
		end

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "corrosive_mist")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_corrosive_mist", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_corrosive_mist = class({})

function modifier_card_corrosive_mist:IsHidden() return false end
function modifier_card_corrosive_mist:IsDebuff() return true end
function modifier_card_corrosive_mist:IsPurgable() return true end
function modifier_card_corrosive_mist:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_corrosive_mist:GetTexture()
	return "custom/card_corrosive_mist"
end

function modifier_card_corrosive_mist:GetEffectName()
	return "particles/apotheosis_blade_debuff_mute.vpcf"
end

function modifier_card_corrosive_mist:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_card_corrosive_mist:CheckState()
	local states = {
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true
	}
	return states
end



card_demagicking_maul = class({})

function card_demagicking_maul:IsStealable() return false end
function card_demagicking_maul:IsHiddenAbilityCastable() return true end

function card_demagicking_maul:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_demagicking_maul.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_demagicking_maul", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "demagicking_maul")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_demagicking_maul", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_demagicking_maul = class({})

function modifier_card_demagicking_maul:IsHidden() return false end
function modifier_card_demagicking_maul:IsDebuff() return false end
function modifier_card_demagicking_maul:IsPurgable() return false end
function modifier_card_demagicking_maul:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_demagicking_maul:GetTexture()
	return "custom/card_demagicking_maul"
end

function modifier_card_demagicking_maul:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function modifier_card_demagicking_maul:OnAttackLanded(keys)
	if IsServer() then
		if keys.attacker == self:GetParent() then
			if keys.target:IsHero() then
				keys.target:AddNewModifier(self:GetParent(), nil, "modifier_card_demagicking_maul_debuff", {duration = 1})
			end
		end
	end
end

LinkLuaModifier("modifier_card_demagicking_maul_debuff", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_demagicking_maul_debuff = class({})

function modifier_card_demagicking_maul_debuff:IsHidden() return false end
function modifier_card_demagicking_maul_debuff:IsDebuff() return true end
function modifier_card_demagicking_maul_debuff:IsPurgable() return true end
function modifier_card_demagicking_maul_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_demagicking_maul_debuff:GetTexture()
	return "custom/card_demagicking_maul"
end

function modifier_card_demagicking_maul_debuff:GetEffectName()
	return "particles/apotheosis_blade_debuff_mute.vpcf"
end

function modifier_card_demagicking_maul_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_card_demagicking_maul_debuff:CheckState()
	local states = {
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true
	}
	return states
end



card_coordinated_assault = class({})

function card_coordinated_assault:IsStealable() return false end
function card_coordinated_assault:IsHiddenAbilityCastable() return true end

function card_coordinated_assault:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local player_id = caster:GetPlayerID()

		-- Find targets
		local allies = FindUnitsInRadius(caster:GetTeamNumber(), Vector(0, 0, 0), nil, 25000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
		for _, ally in pairs(allies) do
			ally:AddNewModifier(caster, nil, "modifier_card_coordinated_assault", {})

			ally:EmitSound("Artifart.UseCard")

			local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_coordinated_assault.vpcf", PATTACH_ABSORIGIN_FOLLOW, ally)
			ParticleManager:SetParticleControl(cast_pfx, 0, ally:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(cast_pfx)
		end

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "coordinated_assault")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_coordinated_assault", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_coordinated_assault = class({})

function modifier_card_coordinated_assault:IsHidden() return false end
function modifier_card_coordinated_assault:IsDebuff() return false end
function modifier_card_coordinated_assault:IsPurgable() return false end
function modifier_card_coordinated_assault:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_coordinated_assault:GetTexture()
	return "custom/card_coordinated_assault"
end

function modifier_card_coordinated_assault:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE
	}
	return funcs
end

function modifier_card_coordinated_assault:OnTakeDamage(keys)
	if IsServer() then
		if keys.attacker == self:GetParent() then
			if keys.unit:HasModifier("modifier_card_coordinated_assault_debuff") then
				local debuff = keys.unit:FindModifierByName("modifier_card_coordinated_assault_debuff")
				if debuff:GetCaster() ~= keys.attacker then
					local current_stacks = debuff:GetStackCount()
					keys.unit:RemoveModifierByName("modifier_card_coordinated_assault_debuff")
					keys.unit:AddNewModifier(keys.attacker, nil, "modifier_card_coordinated_assault_debuff", {duration = 1}):SetStackCount(current_stacks + 1)
				end
			else
				keys.unit:AddNewModifier(keys.attacker, nil, "modifier_card_coordinated_assault_debuff", {duration = 1}):SetStackCount(1)
			end				
		end
	end
end

LinkLuaModifier("modifier_card_coordinated_assault_debuff", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_coordinated_assault_debuff = class({})

function modifier_card_coordinated_assault_debuff:IsHidden() return false end
function modifier_card_coordinated_assault_debuff:IsDebuff() return true end
function modifier_card_coordinated_assault_debuff:IsPurgable() return false end
function modifier_card_coordinated_assault_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_coordinated_assault_debuff:GetTexture()
	return "custom/card_coordinated_assault"
end

function modifier_card_coordinated_assault_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
	return funcs
end

function modifier_card_coordinated_assault_debuff:GetModifierIncomingDamage_Percentage()
	return self:GetStackCount() * 10
end



card_chainmail = class({})

function card_chainmail:IsStealable() return false end
function card_chainmail:IsHiddenAbilityCastable() return true end

function card_chainmail:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_chainmail.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_chainmail", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "chainmail")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_chainmail", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_chainmail = class({})

function modifier_card_chainmail:IsDebuff() return false end
function modifier_card_chainmail:IsHidden() return true end
function modifier_card_chainmail:IsPurgable() return false end
function modifier_card_chainmail:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_chainmail:GetTexture()
	return "custom/card_chainmail"
end

function modifier_card_chainmail:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_card_chainmail:GetModifierPhysicalArmorBonus()
	return 2
end



card_platemail = class({})

function card_platemail:IsStealable() return false end
function card_platemail:IsHiddenAbilityCastable() return true end

function card_platemail:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_platemail.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_platemail", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "platemail")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_platemail", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_platemail = class({})

function modifier_card_platemail:IsDebuff() return false end
function modifier_card_platemail:IsHidden() return true end
function modifier_card_platemail:IsPurgable() return false end
function modifier_card_platemail:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_platemail:GetTexture()
	return "custom/card_platemail"
end

function modifier_card_platemail:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_card_platemail:GetModifierPhysicalArmorBonus()
	return 4
end



card_broadsword = class({})

function card_broadsword:IsStealable() return false end
function card_broadsword:IsHiddenAbilityCastable() return true end

function card_broadsword:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_broadsword.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_broadsword", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "broadsword")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_broadsword", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_broadsword = class({})

function modifier_card_broadsword:IsDebuff() return false end
function modifier_card_broadsword:IsHidden() return true end
function modifier_card_broadsword:IsPurgable() return false end
function modifier_card_broadsword:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_broadsword:GetTexture()
	return "custom/card_broadsword"
end

function modifier_card_broadsword:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
	return funcs
end

function modifier_card_broadsword:GetModifierPreAttack_BonusDamage()
	return 20
end



card_claymore = class({})

function card_claymore:IsStealable() return false end
function card_claymore:IsHiddenAbilityCastable() return true end

function card_claymore:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_claymore.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_claymore", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "claymore")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_claymore", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_claymore = class({})

function modifier_card_claymore:IsDebuff() return false end
function modifier_card_claymore:IsHidden() return true end
function modifier_card_claymore:IsPurgable() return false end
function modifier_card_claymore:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_claymore:GetTexture()
	return "custom/card_claymore"
end

function modifier_card_claymore:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
	return funcs
end

function modifier_card_claymore:GetModifierPreAttack_BonusDamage()
	return 40
end



card_hero_cape = class({})

function card_hero_cape:IsStealable() return false end
function card_hero_cape:IsHiddenAbilityCastable() return true end

function card_hero_cape:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_hero_cape.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_hero_cape", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "hero_cape")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_hero_cape", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_hero_cape = class({})

function modifier_card_hero_cape:IsDebuff() return false end
function modifier_card_hero_cape:IsHidden() return true end
function modifier_card_hero_cape:IsPurgable() return false end
function modifier_card_hero_cape:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_hero_cape:GetTexture()
	return "custom/card_hero_cape"
end

function modifier_card_hero_cape:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
	return funcs
end

function modifier_card_hero_cape:GetModifierMagicalResistanceBonus()
	return 30
end



card_assassin_veil = class({})

function card_assassin_veil:IsStealable() return false end
function card_assassin_veil:IsHiddenAbilityCastable() return true end

function card_assassin_veil:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_assassin_veil.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_assassin_veil", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "assassin_veil")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_assassin_veil", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_assassin_veil = class({})

function modifier_card_assassin_veil:IsDebuff() return false end
function modifier_card_assassin_veil:IsHidden() return true end
function modifier_card_assassin_veil:IsPurgable() return false end
function modifier_card_assassin_veil:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_assassin_veil:GetTexture()
	return "custom/card_assassin_veil"
end

function modifier_card_assassin_veil:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT
	}
	return funcs
end

function modifier_card_assassin_veil:GetModifierEvasion_Constant()
	return 20
end



card_keenfolk_musket = class({})

function card_keenfolk_musket:IsStealable() return false end
function card_keenfolk_musket:IsHiddenAbilityCastable() return true end

function card_keenfolk_musket:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_keenfolk_musket.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_keenfolk_musket", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "keenfolk_musket")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_keenfolk_musket", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_keenfolk_musket = class({})

function modifier_card_keenfolk_musket:IsDebuff() return false end
function modifier_card_keenfolk_musket:IsHidden() return true end
function modifier_card_keenfolk_musket:IsPurgable() return false end
function modifier_card_keenfolk_musket:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_keenfolk_musket:GetTexture()
	return "custom/card_keenfolk_musket"
end

function modifier_card_keenfolk_musket:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
	}
	return funcs
end

function modifier_card_keenfolk_musket:GetModifierAttackRangeBonus()
	return 100
end



card_sniper = class({})

function card_sniper:IsStealable() return false end
function card_sniper:IsHiddenAbilityCastable() return true end

function card_sniper:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_sniper.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_sniper", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "sniper")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_sniper", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_sniper = class({})

function modifier_card_sniper:IsDebuff() return false end
function modifier_card_sniper:IsHidden() return false end
function modifier_card_sniper:IsPurgable() return false end
function modifier_card_sniper:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_sniper:GetTexture()
	return "custom/card_sniper"
end

function modifier_card_sniper:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
	}
	return funcs
end

function modifier_card_sniper:GetModifierAttackRangeBonus()
	return 300
end



card_avernus_blessing = class({})

function card_avernus_blessing:IsStealable() return false end
function card_avernus_blessing:IsHiddenAbilityCastable() return true end

function card_avernus_blessing:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_avernus_blessing.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_avernus_blessing", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "avernus_blessing")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_avernus_blessing", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_avernus_blessing = class({})

function modifier_card_avernus_blessing:IsDebuff() return false end
function modifier_card_avernus_blessing:IsHidden() return false end
function modifier_card_avernus_blessing:IsPurgable() return false end
function modifier_card_avernus_blessing:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_avernus_blessing:GetTexture()
	return "custom/card_avernus_blessing"
end

function modifier_card_avernus_blessing:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
	return funcs
end

function modifier_card_avernus_blessing:GetModifierAttackSpeedBonus_Constant()
	return 100
end



card_zeus = class({})

function card_zeus:IsStealable() return false end
function card_zeus:IsHiddenAbilityCastable() return true end

function card_zeus:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_zeus.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_zeus", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "zeus")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_zeus", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_zeus = class({})

function modifier_card_zeus:IsDebuff() return false end
function modifier_card_zeus:IsHidden() return true end
function modifier_card_zeus:IsPurgable() return false end
function modifier_card_zeus:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_zeus:GetTexture()
	return "custom/card_zeus"
end

function modifier_card_zeus:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
	return funcs
end

function modifier_card_zeus:GetModifierSpellAmplify_Percentage()
	return 20
end



card_skywrath_mage = class({})

function card_skywrath_mage:IsStealable() return false end
function card_skywrath_mage:IsHiddenAbilityCastable() return true end

function card_skywrath_mage:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_skywrath_mage.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_skywrath_mage", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "skywrath_mage")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_skywrath_mage", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_skywrath_mage = class({})

function modifier_card_skywrath_mage:IsDebuff() return false end
function modifier_card_skywrath_mage:IsHidden() return true end
function modifier_card_skywrath_mage:IsPurgable() return false end
function modifier_card_skywrath_mage:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_skywrath_mage:GetTexture()
	return "custom/card_skywrath_mage"
end

function modifier_card_skywrath_mage:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING
	}
	return funcs
end

function modifier_card_skywrath_mage:GetModifierCastRangeBonusStacking()
	return 200
end



card_outworld_devourer = class({})

function card_outworld_devourer:IsStealable() return false end
function card_outworld_devourer:IsHiddenAbilityCastable() return true end

function card_outworld_devourer:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_outworld_devourer.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_outworld_devourer", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "outworld_devourer")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_outworld_devourer", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_outworld_devourer = class({})

function modifier_card_outworld_devourer:IsDebuff() return false end
function modifier_card_outworld_devourer:IsHidden() return true end
function modifier_card_outworld_devourer:IsPurgable() return false end
function modifier_card_outworld_devourer:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_outworld_devourer:GetTexture()
	return "custom/card_outworld_devourer"
end

function modifier_card_outworld_devourer:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_MANA_BONUS
	}
	return funcs
end

function modifier_card_outworld_devourer:GetModifierExtraManaBonus()
	return 500
end



card_tinker = class({})

function card_tinker:IsStealable() return false end
function card_tinker:IsHiddenAbilityCastable() return true end

function card_tinker:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_tinker.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_tinker", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "tinker")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_tinker", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_tinker = class({})

function modifier_card_tinker:IsDebuff() return false end
function modifier_card_tinker:IsHidden() return true end
function modifier_card_tinker:IsPurgable() return false end
function modifier_card_tinker:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_tinker:GetTexture()
	return "custom/card_tinker"
end

function modifier_card_tinker:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE_STACKING
	}
	return funcs
end

function modifier_card_tinker:GetModifierPercentageCooldownStacking()
	return 20
end



card_potion_of_knowledge = class({})

function card_potion_of_knowledge:IsStealable() return false end
function card_potion_of_knowledge:IsHiddenAbilityCastable() return true end

function card_potion_of_knowledge:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_potion_of_knowledge.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_potion_of_knowledge", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "potion_of_knowledge")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_potion_of_knowledge", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_potion_of_knowledge = class({})

function modifier_card_potion_of_knowledge:IsDebuff() return false end
function modifier_card_potion_of_knowledge:IsHidden() return true end
function modifier_card_potion_of_knowledge:IsPurgable() return false end
function modifier_card_potion_of_knowledge:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_potion_of_knowledge:GetTexture()
	return "custom/card_potion_of_knowledge"
end

function modifier_card_potion_of_knowledge:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
	return funcs
end

function modifier_card_potion_of_knowledge:GetModifierBonusStats_Strength()
	return 10
end

function modifier_card_potion_of_knowledge:GetModifierBonusStats_Agility()
	return 10
end

function modifier_card_potion_of_knowledge:GetModifierBonusStats_Intellect()
	return 10
end



card_annihilation = class({})

function card_annihilation:IsStealable() return false end
function card_annihilation:IsHiddenAbilityCastable() return true end

function card_annihilation:GetAOERadius()
	return 400
end

function card_annihilation:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target_loc = self:GetCursorPosition()
		local player_id = caster:GetPlayerID()

		-- Cast sounds
		EmitSoundOnLocationWithCaster(target_loc, "Artifart.UseCard", caster)
		Timers:CreateTimer(1, function()
			EmitGlobalSound("conquest.stinger.capture_dire")
		end)

		-- Find targets
		local units = FindUnitsInRadius(caster:GetTeamNumber(), target_loc, nil, 400, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if not unit:IsBoss() then
				local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_annihilation.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
				ParticleManager:SetParticleControl(cast_pfx, 0, unit:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(cast_pfx)
				unit:Kill(nil, caster)
			end
		end

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "annihilation")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end



card_time_of_triumph = class({})

function card_time_of_triumph:IsStealable() return false end
function card_time_of_triumph:IsHiddenAbilityCastable() return true end

function card_time_of_triumph:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local player_id = caster:GetPlayerID()

		caster:EmitSound("Artifart.UseCard")

		-- Find targets
		local allies = FindUnitsInRadius(caster:GetTeamNumber(), Vector(0, 0, 0), nil, 25000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
		for _, ally in pairs(allies) do

			ally:AddNewModifier(caster, nil, "modifier_card_time_of_triumph", {}):SetStackCount(50)
			ally:EmitSound("Artifart.MomentOfTriumph")

			local target_pfx = ParticleManager:CreateParticle("particles/cards/card_use_time_of_triumph.vpcf", PATTACH_ABSORIGIN_FOLLOW, ally)
			ParticleManager:SetParticleControl(target_pfx, 0, ally:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(target_pfx)
		end

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "time_of_triumph")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_time_of_triumph", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_time_of_triumph = class({})

function modifier_card_time_of_triumph:IsDebuff() return false end
function modifier_card_time_of_triumph:IsHidden() return false end
function modifier_card_time_of_triumph:IsPurgable() return false end
function modifier_card_time_of_triumph:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_time_of_triumph:GetTexture()
	return "custom/card_time_of_triumph"
end

function modifier_card_time_of_triumph:GetEffectName()
	return "particles/econ/items/legion/legion_fallen/legion_fallen_press.vpcf"
end

function modifier_card_time_of_triumph:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_time_of_triumph:OnCreated(keys)
	if IsServer() then
		self:StartIntervalThink(1.0)
	end
end

function modifier_card_time_of_triumph:OnIntervalThink()
	if IsServer() then
		self:SetStackCount(self:GetStackCount() - 1)
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end

function modifier_card_time_of_triumph:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
	return funcs
end

function modifier_card_time_of_triumph:GetModifierTotalDamageOutgoing_Percentage()
	return self:GetStackCount()
end

function modifier_card_time_of_triumph:GetModifierIncomingDamage_Percentage()
	return (-1) * self:GetStackCount()
end

function modifier_card_time_of_triumph:GetModifierMoveSpeedBonus_Percentage()
	return self:GetStackCount()
end

function modifier_card_time_of_triumph:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount()
end

function modifier_card_time_of_triumph:GetModifierConstantHealthRegen()
	return self:GetStackCount()
end



card_bracers_of_sacrifice = class({})

function card_bracers_of_sacrifice:IsStealable() return false end
function card_bracers_of_sacrifice:IsHiddenAbilityCastable() return true end

function card_bracers_of_sacrifice:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_bracers_of_sacrifice.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_bracers_of_sacrifice", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "bracers_of_sacrifice")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_bracers_of_sacrifice", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_bracers_of_sacrifice = class({})

function modifier_card_bracers_of_sacrifice:IsDebuff() return false end
function modifier_card_bracers_of_sacrifice:IsHidden() return false end
function modifier_card_bracers_of_sacrifice:IsPurgable() return false end
function modifier_card_bracers_of_sacrifice:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_bracers_of_sacrifice:GetTexture()
	return "custom/card_bracers_of_sacrifice"
end

function modifier_card_bracers_of_sacrifice:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH
	}
	return funcs
end

function modifier_card_bracers_of_sacrifice:OnDeath(keys)
	if IsServer() then
		if keys.unit == self:GetParent() then
			
			-- Sound + effect
			keys.unit:EmitSound("Artifart.BracersOfSacrifice")

			local blast_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_suicide.vpcf", PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControl(blast_pfx, 0, keys.unit:GetAbsOrigin())
			ParticleManager:SetParticleControl(blast_pfx, 1, Vector(500, 0, 0))
			ParticleManager:ReleaseParticleIndex(blast_pfx)

			-- Damage
			local enemies = FindUnitsInRadius(keys.unit:GetTeamNumber(), keys.unit:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
			for _, enemy in pairs(enemies) do
				ApplyDamage({victim = enemy, attacker = keys.unit, damage = 1000, damage_type = DAMAGE_TYPE_MAGICAL})
			end
		end
	end
end



card_nyctashas_guard = class({})

function card_nyctashas_guard:IsStealable() return false end
function card_nyctashas_guard:IsHiddenAbilityCastable() return true end

function card_nyctashas_guard:GetAOERadius()
	return 1000
end

function card_nyctashas_guard:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target_loc = self:GetCursorPosition()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		EmitSoundOnLocationWithCaster(target_loc, "Artifart.UseCard", caster)
		EmitSoundOnLocationWithCaster(target_loc, "Artifart.NyctashasGuard", caster)

		-- Find targets
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), target_loc, nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
		for _, target in pairs(targets) do
			target:AddNewModifier(caster, nil, "modifier_card_nyctashas_guard", {duration = 10})

			local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_nyctashas_guard.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
			ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(cast_pfx)
		end

		-- Taunt particle
		local taunt_pfx = ParticleManager:CreateParticle("particles/cards/nyctashas_guard_effect.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(taunt_pfx, 0, target_loc)
		ParticleManager:SetParticleControl(taunt_pfx, 2, Vector(1000, 0, 0))
		ParticleManager:ReleaseParticleIndex(taunt_pfx)

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "nyctashas_guard")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_nyctashas_guard", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_nyctashas_guard = class({})

function modifier_card_nyctashas_guard:IsDebuff() return true end
function modifier_card_nyctashas_guard:IsHidden() return false end
function modifier_card_nyctashas_guard:IsPurgable() return false end
function modifier_card_nyctashas_guard:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_nyctashas_guard:GetTexture()
	return "custom/card_nyctashas_guard"
end

function modifier_card_nyctashas_guard:GetStatusEffectName()
	return "particles/status_fx/status_effect_lone_druid_savage_roar.vpcf"
end

function modifier_card_nyctashas_guard:OnCreated(keys)
	if IsServer() then
		if self:GetParent():GetTeam() == DOTA_TEAM_GOODGUYS then
			self:GetParent():MoveToPosition(Vector(-7168, -6656, 400))
		else
			self:GetParent():MoveToPosition(Vector(7040, 6464, 400))
		end
	end
end

function modifier_card_nyctashas_guard:CheckState()
	local states = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true
	}
	return states
end

function modifier_card_nyctashas_guard:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
	return funcs
end

function modifier_card_nyctashas_guard:GetModifierMoveSpeedBonus_Percentage()
	return 100
end



card_blood_rage = class({})

function card_blood_rage:IsStealable() return false end
function card_blood_rage:IsHiddenAbilityCastable() return true end

function card_blood_rage:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_blood_rage.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_blood_rage", {duration = 30})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "blood_rage")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_blood_rage", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_blood_rage = class({})

function modifier_card_blood_rage:IsDebuff() return false end
function modifier_card_blood_rage:IsHidden() return false end
function modifier_card_blood_rage:IsPurgable() return false end
function modifier_card_blood_rage:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_blood_rage:GetTexture()
	return "custom/card_blood_rage"
end

function modifier_card_blood_rage:GetEffectName()
	return "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodrage_eztzhok.vpcf"
end

function modifier_card_blood_rage:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_card_blood_rage:GetStatusEffectName()
	return "particles/status_fx/status_effect_bloodrage.vpcf"
end

function modifier_card_blood_rage:CheckState()
	local states = {
		[MODIFIER_STATE_SILENCED] = true
	}
	return states
end

function modifier_card_blood_rage:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
	}
	return funcs
end

function modifier_card_blood_rage:GetModifierDamageOutgoing_Percentage()
	return 100
end



card_ignite = class({})

function card_ignite:IsStealable() return false end
function card_ignite:IsHiddenAbilityCastable() return true end

function card_ignite:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_ignite.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_ignite", {damage = 1}):SetStackCount(1)

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "ignite")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_ignite", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_ignite = class({})

function modifier_card_ignite:IsDebuff() return true end
function modifier_card_ignite:IsHidden() return false end
function modifier_card_ignite:IsPurgable() return false end
function modifier_card_ignite:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_ignite:GetTexture()
	return "custom/card_ignite"
end

function modifier_card_ignite:GetEffectName()
	return "particles/units/heroes/hero_ogre_magi/ogre_magi_ignite_debuff.vpcf"
end

function modifier_card_ignite:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_ignite:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOOLTIP
	}
	return funcs
end

function modifier_card_ignite:OnTooltip()
	return self:GetStackCount()
end

function modifier_card_ignite:OnCreated(keys)
	if IsServer() then
		self.damage = keys.damage
		self:StartIntervalThink(1.0)
	end
end

function modifier_card_ignite:OnIntervalThink()
	if IsServer() then

		-- Deal damage
		local parent = self:GetParent()
		ApplyDamage({victim = parent, attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL})
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, parent, self.damage, nil)

		-- Spread, if appropriate
		local targets = FindUnitsInRadius(parent:GetTeamNumber(), parent:GetAbsOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, target in pairs(targets) do
			if target ~= parent then
				target:AddNewModifier(self:GetCaster(), nil, "modifier_card_ignite", {damage = self.damage * 2}):SetStackCount(self.damage * 2)
				self:Destroy()
				break
			end
		end
	end
end



card_enrage = class({})

function card_enrage:IsStealable() return false end
function card_enrage:IsHiddenAbilityCastable() return true end

function card_enrage:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_enrage.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		target:AddNewModifier(caster, self, "modifier_card_enrage", {duration = 15})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "enrage")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_enrage", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_enrage = class({})

function modifier_card_enrage:IsDebuff() return false end
function modifier_card_enrage:IsHidden() return false end
function modifier_card_enrage:IsPurgable() return false end
function modifier_card_enrage:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_enrage:GetTexture()
	return "custom/card_enrage"
end

function modifier_card_enrage:OnDestroy()
	if IsServer() then
		self:GetParent():AddNewModifier(self:GetCaster(), nil, "modifier_card_enrage_debuff", {duration = 30})
	end
end

function modifier_card_enrage:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf"
end

function modifier_card_enrage:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_enrage:GetStatusEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_hero_effect.vpcf"
end

function modifier_card_enrage:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
	return funcs
end

function modifier_card_enrage:GetModifierTotalDamageOutgoing_Percentage()
	return 50
end

function modifier_card_enrage:GetModifierIncomingDamage_Percentage()
	return -50
end

LinkLuaModifier("modifier_card_enrage_debuff", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_enrage_debuff = class({})

function modifier_card_enrage_debuff:IsDebuff() return true end
function modifier_card_enrage_debuff:IsHidden() return false end
function modifier_card_enrage_debuff:IsPurgable() return false end
function modifier_card_enrage_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_enrage_debuff:GetTexture()
	return "custom/card_enrage"
end

function modifier_card_enrage_debuff:GetStatusEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_hero_effect.vpcf"
end

function modifier_card_enrage_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
	return funcs
end

function modifier_card_enrage_debuff:GetModifierTotalDamageOutgoing_Percentage()
	return -50
end

function modifier_card_enrage_debuff:GetModifierIncomingDamage_Percentage()
	return 50
end



card_relentless_pursuit = class({})

function card_relentless_pursuit:IsStealable() return false end
function card_relentless_pursuit:IsHiddenAbilityCastable() return true end

function card_relentless_pursuit:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_relentless_pursuit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Apply modifier
		caster:RemoveModifierByName("modifier_card_relentless_pursuit")
		caster:AddNewModifier(caster, self, "modifier_card_relentless_pursuit", {target_index = target:entindex()})
		target:AddNewModifier(caster, self, "modifier_card_relentless_pursuit_debuff", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "relentless_pursuit")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_relentless_pursuit", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_relentless_pursuit = class({})

function modifier_card_relentless_pursuit:IsDebuff() return false end
function modifier_card_relentless_pursuit:IsHidden() return false end
function modifier_card_relentless_pursuit:IsPurgable() return false end
function modifier_card_relentless_pursuit:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_relentless_pursuit:GetTexture()
	return "custom/card_relentless_pursuit"
end

function modifier_card_relentless_pursuit:GetEffectName()
	return "particles/econ/items/spirit_breaker/spirit_breaker_iron_surge/spirit_breaker_charge_iron.vpcf"
end

function modifier_card_relentless_pursuit:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_card_relentless_pursuit:CheckState()
	local states = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
	}
	return states
end

function modifier_card_relentless_pursuit:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE
	}
	return funcs
end

function modifier_card_relentless_pursuit:GetModifierIgnoreMovespeedLimit()
	return 1
end

function modifier_card_relentless_pursuit:GetModifierMoveSpeed_Absolute()
	return 600 + 25 * self:GetStackCount()
end

function modifier_card_relentless_pursuit:OnCreated(keys)
	if IsServer() then
		self.target = EntIndexToHScript(keys.target_index)
		self:GetParent():MoveToNPC(self.target)
		self:GetParent():SetRenderColor(0, 0, 0)
		self:StartIntervalThink(0.25)
	end
end

function modifier_card_relentless_pursuit:OnDestroy()
	if IsServer() then
		self:GetParent():SetRenderColor(255, 255, 255)
	end
end

function modifier_card_relentless_pursuit:OnIntervalThink()
	if IsServer() then
		self:SetStackCount(self:GetStackCount() + 1)

		-- Stop, if appropriate
		local parent = self:GetParent()
		if not self.target:IsAlive() then
			self:Destroy()
		else
			local targets = FindUnitsInRadius(parent:GetTeamNumber(), parent:GetAbsOrigin(), nil, 200, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
			for _, target in pairs(targets) do
				if target == self.target then
					target:AddNewModifier(parent, nil, "modifier_stunned", {duration = 2})
					target:EmitSound("Artifart.RelentlessPursuitEnd")
					self:Destroy()
					break
				end
			end
		end
	end
end

LinkLuaModifier("modifier_card_relentless_pursuit_debuff", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_relentless_pursuit_debuff = class({})

function modifier_card_relentless_pursuit_debuff:IsDebuff() return true end
function modifier_card_relentless_pursuit_debuff:IsHidden() return true end
function modifier_card_relentless_pursuit_debuff:IsPurgable() return false end
function modifier_card_relentless_pursuit_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_relentless_pursuit_debuff:CheckState()
	local states = {
		[MODIFIER_STATE_PROVIDES_VISION] = true
	}
	return states
end



card_mana_drain = class({})

function card_mana_drain:IsStealable() return false end
function card_mana_drain:IsHiddenAbilityCastable() return true end

function card_mana_drain:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sounds
		target:EmitSound("Artifart.UseCard")
		target:EmitSound("Artifart.ManaBurn")

		-- Cast particles
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_mana_drain.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		local burn_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(burn_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(burn_pfx)

		-- Apply effect
		local mana_drained = target:GetMaxMana() * 0.5
		target:ReduceMana(mana_drained)
		caster:GiveMana(mana_drained)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_LOSS, target, mana_drained, nil)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, caster, mana_drained, nil)

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "mana_drain")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end



card_defensive_stance = class({})

function card_defensive_stance:IsStealable() return false end
function card_defensive_stance:IsHiddenAbilityCastable() return true end

function card_defensive_stance:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_defensive_stance.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Grant the modifier
		target:AddNewModifier(caster, self, "modifier_card_defensive_stance", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "defensive_stance")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_defensive_stance", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_defensive_stance = class({})

function modifier_card_defensive_stance:IsHidden() return false end
function modifier_card_defensive_stance:IsDebuff() return false end
function modifier_card_defensive_stance:IsPurgable() return false end
function modifier_card_defensive_stance:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_defensive_stance:GetTexture()
	return "custom/card_defensive_stance"
end

function modifier_card_defensive_stance:GetEffectName()
	return "particles/units/heroes/hero_pangolier/pangolier_defense_stance_shield.vpcf"
end

function modifier_card_defensive_stance:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_card_defensive_stance:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
	return funcs
end

function modifier_card_defensive_stance:GetModifierTotalDamageOutgoing_Percentage()
	return -50
end

function modifier_card_defensive_stance:GetModifierIncomingDamage_Percentage()
	return -50
end



card_selemenes_favor = class({})

function card_selemenes_favor:IsStealable() return false end
function card_selemenes_favor:IsHiddenAbilityCastable() return true end

function card_selemenes_favor:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_selemenes_favor.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Grant the modifier
		target:AddNewModifier(caster, self, "modifier_card_selemenes_favor", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "selemenes_favor")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_selemenes_favor", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_selemenes_favor = class({})

function modifier_card_selemenes_favor:IsHidden() return false end
function modifier_card_selemenes_favor:IsDebuff() return false end
function modifier_card_selemenes_favor:IsPurgable() return false end
function modifier_card_selemenes_favor:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_selemenes_favor:GetTexture()
	return "custom/card_selemenes_favor"
end

function modifier_card_selemenes_favor:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE
	}
	return funcs
end

function modifier_card_selemenes_favor:GetModifierTotalPercentageManaRegen()
	return 2
end



card_ristul_emblem = class({})

function card_ristul_emblem:IsStealable() return false end
function card_ristul_emblem:IsHiddenAbilityCastable() return true end

function card_ristul_emblem:OnSpellStart()
	if IsServer() then

		-- Parameters
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local player_id = caster:GetPlayerID()

		-- Cast sound
		target:EmitSound("Artifart.UseCard")

		-- Cast particle
		local cast_pfx = ParticleManager:CreateParticle("particles/cards/card_use_ristul_emblem.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(cast_pfx, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(cast_pfx)

		-- Grant the modifier
		target:AddNewModifier(caster, self, "modifier_card_ristul_emblem", {})

		-- Consume card
		local card_slot = Artifart:HasCard(player_id, "ristul_emblem")
		if card_slot then
			Artifart:ConsumeCard(player_id, card_slot)
		end
	end
end

LinkLuaModifier("modifier_card_ristul_emblem", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_ristul_emblem = class({})

function modifier_card_ristul_emblem:IsHidden() return false end
function modifier_card_ristul_emblem:IsDebuff() return true end
function modifier_card_ristul_emblem:IsPurgable() return false end
function modifier_card_ristul_emblem:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_ristul_emblem:IsAura()
	return true
end

function modifier_card_ristul_emblem:GetAuraRadius() return 1200 end
function modifier_card_ristul_emblem:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_card_ristul_emblem:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_BOTH end
function modifier_card_ristul_emblem:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING end
function modifier_card_ristul_emblem:GetModifierAura() return "modifier_card_ristul_emblem_debuff" end

function modifier_card_ristul_emblem:GetTexture()
	return "custom/card_ristul_emblem"
end

function modifier_card_ristul_emblem:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH
	}
	return funcs
end

function modifier_card_ristul_emblem:OnDeath(keys)
	if IsServer() then
		if keys.unit == self:GetParent() then
			self:Destroy()
		end
	end
end

LinkLuaModifier("modifier_card_ristul_emblem_debuff", "cards", LUA_MODIFIER_MOTION_NONE)

modifier_card_ristul_emblem_debuff = class({})

function modifier_card_ristul_emblem_debuff:IsHidden() return false end
function modifier_card_ristul_emblem_debuff:IsDebuff() return true end
function modifier_card_ristul_emblem_debuff:IsPurgable() return false end
function modifier_card_ristul_emblem_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_card_ristul_emblem_debuff:GetTexture()
	return "custom/card_ristul_emblem"
end

function modifier_card_ristul_emblem_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_card_ristul_emblem_debuff:GetModifierPhysicalArmorBonus()
	return -10
end