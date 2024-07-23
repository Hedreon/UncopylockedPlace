--!strict
local Damage = {}

local Debounce = false

local function DamageFromPart(Part: BasePart, DamageToTake: number, DelayTime: number)
	Part.Touched:Connect(function(Hit)
		local Character = Hit.Parent

		if Character then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")

			if Humanoid then
				if not Debounce then
					Debounce = true

					Humanoid:TakeDamage(DamageToTake)

					task.wait(DelayTime)

					Debounce = false
				end
			end
		end
	end)
end

local function KillFromPart(Part: BasePart)
	Part.Touched:Connect(function(Hit)
		local Character = Hit.Parent

		if Character then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")

			if Humanoid then
				Humanoid.Health = 0
			end
		end
	end)
end

function Damage:Init()
	for _, Descendant in workspace:GetDescendants() do
		local DamageAttribute: number = Descendant:GetAttribute("Damage")
		local KillsAttribute: boolean = Descendant:GetAttribute("Kills")
		local TimeoutAttribute: number = Descendant:GetAttribute("Timeout")

		if DamageAttribute and TimeoutAttribute then
			if Descendant:IsA("Model") then
				for _, Child in Descendant:GetChildren() do
					if Child:IsA("BasePart") then
						DamageFromPart(Child, DamageAttribute, TimeoutAttribute)
					end
				end
			elseif Descendant:IsA("BasePart") then
				DamageFromPart(Descendant, DamageAttribute, TimeoutAttribute)
			end
		elseif KillsAttribute then
			if Descendant:IsA("Model") then
				for _, Child in Descendant:GetChildren() do
					if Child:IsA("BasePart") then
						KillFromPart(Child)
					end
				end
			elseif Descendant:IsA("BasePart") then
				KillFromPart(Descendant)
			end
		end
	end
end

return Damage