boss_doom_unstoppable = class({})

function boss_doom_unstoppable:GetIntrinsicModifierName()
	return "modifier_boss_doom_unstoppable"
end

function boss_doom_unstoppable:ShouldUseResources()
	return true
end

modifier_boss_doom_unstoppable = class({})
LinkLuaModifier("modifier_boss_doom_unstoppable", "bosses/boss_doom/boss_doom_unstoppable", LUA_MODIFIER_MOTION_NONE)

if IsServer() then
	function modifier_boss_doom_unstoppable:OnCreated()
		self:StartIntervalThink(0.1)
	end
	
	function modifier_boss_doom_unstoppable:OnIntervalThink()
		if self:GetParent():IsDisabled(true) and self:GetAbility():IsCooldownReady() and not self:GetParent():HasModifier("modifier_spawn_immunity") then
			self:GetAbility():SetCooldown()
			self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_status_immunity", {duration = self:GetSpecialValueFor("duration")})
		end
	end
end


function modifier_boss_doom_unstoppable:IsHidden()
	return true
end