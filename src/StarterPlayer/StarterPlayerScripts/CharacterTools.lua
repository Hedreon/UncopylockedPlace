local CharacterTools: any = {}

function CharacterTools:Damage(ObjectTouched: BasePart, DamageAmount: number)
	local Character: Instance? = ObjectTouched.Parent
	local Humanoid: Humanoid? = if Character then Character:FindFirstChildOfClass("Humanoid") else nil

	if Humanoid then
		Humanoid:TakeDamage(DamageAmount)
	end
end

function CharacterTools:Kill(ObjectTouched: BasePart)
    local Character: Instance? = ObjectTouched.Parent
	local Humanoid: Humanoid? = if Character then Character:FindFirstChildOfClass("Humanoid") else nil

	if Humanoid then
		Humanoid.Health = Humanoid.Health - Humanoid.MaxHealth
	end
end

return CharacterTools