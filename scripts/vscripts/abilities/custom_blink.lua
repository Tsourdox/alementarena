
custom_blink = class ({})
-- LinkLuaModifier( "modifier_sven_warcry_lua", LUA_MODIFIER_MOTION_NONE )


-- When cast time ends, resources have been spent - most abilities begin to do their work in this function. No return type, no parameters.
function custom_blink:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorPosition()

    FindClearSpaceForUnit(caster, target, true)
end

-- function ability:OnAbilityPhaseStart() -- When cast time begins, resources have not been spent. Return true for successful cast, or false for unsuccessful, no parameters.
-- function ability:OnAbilityPhaseInterrupted() -- When cast time is cancelled for any reason. No return type, no parameters.
-- function ability:OnProjectileThink( vLocation ) -- If this ability has created a projectile, this function will be called many times while the projectile is travelling. vLocation is the current projectile location. No return type.
-- function ability:OnProjectileHit( hTarget, vLocation ) -- When a projectile has travelled its max distance OR collided with an NPC that fits its targeting type. If hTarget is null, it means the projectile has expired. Return true to destroy the particle, return false to continue the projectile ( this applies for linear projectiles that can hit multiple NPCs, like Dragon Slave. If the projectile has reached its end, it will expire even if false is passed ) 
-- function ability:GetIntrinsicModifierName() -- Return "modifier_name" of the modifier that is passively added by this ability.
-- function ability:OnChannelFinish( bInterrupted ) -- When channel finishes, bInterrupted parameter notifies if the channel finished or not. No return type.
-- function ability:OnUpgrade() -- When the ability is leveled up. No parameters, no return type.