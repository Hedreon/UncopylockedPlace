local CharacterTools: any = {}

local Players: Players = game:GetService("Players")
local LocalPlayer: Player? = Players.LocalPlayer
local LocalCharacter: Model? = if LocalPlayer then LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() else nil

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

function CharacterTools:Teleport(ObjectTouched: BasePart, TargetObject: BasePart)
	print("ready works")
	
	if ObjectTouched then
		print("ready works 2")
		
		ObjectTouched.CFrame = CFrame.new(TargetObject.Position + Vector3.new(0, 10, 0))
	else
		print("ready works 3")
		
		local LowerTorso: Instance? = if LocalCharacter then LocalCharacter:WaitForChild("LowerTorso") else nil
		
		print("ready works 3.5")

		if LowerTorso and LowerTorso:IsA("BasePart") then
			print("ready works 4")
			
			LowerTorso.CFrame = TargetObject.CFrame
		end
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