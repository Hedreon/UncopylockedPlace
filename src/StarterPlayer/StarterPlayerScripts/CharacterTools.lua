local CharacterTools = {}

local function Warning(...: string)
	warn("[CharacterTools]", ...)
end

function CharacterTools:Damage(ObjectTouched: BasePart, DamageAmount: number)
	local Character: Instance? = ObjectTouched.Parent
	local Humanoid: Humanoid? = if Character then Character:FindFirstChildOfClass("Humanoid") else nil

	if Humanoid then
		if DamageAmount < Humanoid.MaxHealth then
			Humanoid:TakeDamage(DamageAmount)
		elseif DamageAmount > Humanoid.MaxHealth then
			Warning("DamageAmount (" .. DamageAmount .. ") is set too high!")
		elseif DamageAmount == Humanoid.MaxHealth then
			Warning("DamageAmount is equal to Maximum Health (" .. Humanoid.MaxHealth .. "), use CharacterTools:Kill() instead!")
		end
	end
end

function CharacterTools:Kill(ObjectTouched: BasePart)
	local Character: Instance? = ObjectTouched.Parent
	local Humanoid: Humanoid? = if Character then Character:FindFirstChildOfClass("Humanoid") else nil

	if Humanoid then
		Humanoid.Health = Humanoid.Health - Humanoid.MaxHealth
	end
end

function CharacterTools:Sit(ObjectTouched: BasePart)
	local Character: Instance? = ObjectTouched.Parent
	local Humanoid: Humanoid? = if Character then Character:FindFirstChildOfClass("Humanoid") else nil

	if Humanoid then
		Humanoid.Sit = true
	end
end

return CharacterTools