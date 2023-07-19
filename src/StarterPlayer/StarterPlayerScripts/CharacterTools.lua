local CharacterTools: any = {}
	
function CharacterTools:Damage(ObjectTouched: BasePart, DamageAmount: number)
	local Character: Instance? = ObjectTouched.Parent
	local Humanoid: Humanoid? = Character and Character:FindFirstChildOfClass("Humanoid") or nil

	if Humanoid then
		Humanoid:TakeDamage(DamageAmount)
	end
end

function CharacterTools:Kill(ObjectTouched: BasePart)
	local Character: Instance? = ObjectTouched.Parent
	local Humanoid: Humanoid? = Character and Character:FindFirstChildOfClass("Humanoid") or nil

	if Humanoid then
		Humanoid.Health = Humanoid.Health - Humanoid.MaxHealth
	end
end

function CharacterTools:Sit(ObjectTouched: BasePart)
	local Character: Instance? = ObjectTouched.Parent
	local Humanoid: Humanoid? = Character and Character:FindFirstChildOfClass("Humanoid") or nil

	if Humanoid then
		Humanoid.Sit = true
	end
end

return CharacterTools