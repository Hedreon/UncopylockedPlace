local HealingEnabled: boolean = false

script.Parent.Activated:Connect(function()
	local HealthScript: Instance? = script.Parent.Parent:FindFirstChild("Health")

	if not HealingEnabled then
		local ForceField: ForceField = Instance.new("ForceField")
		ForceField.Visible = true
		ForceField.Parent = script.Parent.Parent
			
		if HealthScript and HealthScript:GetAttribute("RegenerationTime") and HealthScript:GetAttribute("RegenerationRate") then
			HealthScript:SetAttribute("RegenerationTime", 0.25)
			HealthScript:SetAttribute("RegenerationRate", 0.10)
		end

		HealingEnabled = true
	else
		local ExistingForceField: ForceField? = script.Parent.Parent:FindFirstChildOfClass("ForceField")

		if ExistingForceField then
			ExistingForceField:Destroy()
		end

		if HealthScript and HealthScript:GetAttribute("RegenerationTime") and HealthScript:GetAttribute("RegenerationRate") then
			HealthScript:SetAttribute("RegenerationTime", 1)
			HealthScript:SetAttribute("RegenerationRate", 0.01)
		end

		HealingEnabled = false
	end
end)

script.Parent.Unequipped:Connect(function()
	local Player: Player? = script.Parent.Parent.Parent
	local Character: Model? = if Player then Player.Character or Player.CharacterAdded:Wait() else nil
	
	if Character then
		local ExistingForceField: ForceField? = Character:FindFirstChildOfClass("ForceField")

		if ExistingForceField then
			ExistingForceField:Destroy()
		end

		local HealthScript: Instance? = Character:FindFirstChild("Health")

		if HealthScript and HealthScript:GetAttribute("RegenerationTime") and HealthScript:GetAttribute("RegenerationRate") then
			HealthScript:SetAttribute("RegenerationTime", 1)
			HealthScript:SetAttribute("RegenerationRate", 0.01)
		end

		HealingEnabled = false
	end
end)