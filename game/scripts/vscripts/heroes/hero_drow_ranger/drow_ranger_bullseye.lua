drow_ranger_bullseye = class({})

function drow_ranger_bullseye:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorPoint()
	
	local direction = CalculateDirection( target, caster )
	local speed = self:GetTalentSpecialValueFor("arrow_speed")
	local distance = self:GetTalentSpecialValueFor("arrow_range")
	local width = self:GetTalentSpecialValueFor("arrow_width")
	
	self:FireLinearProjectile("particles/drow_bullseye_arrow.vpcf", direction * speed, distance, width)
	
	ParticleManager:FireParticle("particles/units/heroes/hero_mirana/mirana_spell_arrow_launch.vpcf", PATTACH_POINT_FOLLOW, caster)
	EmitSoundOn( "Hero_Mirana.ArrowCast", caster )
end

function drow_ranger_bullseye:OnProjectileHit( target, position )
	local caster = self:GetCaster()
	
	target:Break( ability, caster, self:GetTalentSpecialValueFor("break_duration"))
	local damage = caster:GetAgility() * self:GetTalentSpecialValueFor("arrow_agi_multiplier")
	caster:PerformGenericAttack(target, true, damage - caster:GetAttackDamage() )
end