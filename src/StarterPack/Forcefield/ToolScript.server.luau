--!strict
local FoundCharacter = nil
local FoundHumanoid = nil

local Toggled = false

local function CreateForceField(Enabled: boolean, Character: Model)
	if Enabled then
		local ForceField = Instance.new("ForceField")
		ForceField.Parent = Character
	else
		local ExistingForceField = Character:FindFirstChildOfClass("ForceField")

		if ExistingForceField then
			ExistingForceField:Destroy()
		end
	end
end

script.Parent.Equipped:Connect(function()
	FoundCharacter = script.Parent.Parent
	FoundHumanoid = FoundCharacter:FindFirstChildOfClass("Humanoid")
end)

script.Parent.Activated:Connect(function()
	Toggled = not Toggled

	CreateForceField(Toggled, FoundCharacter)

	while Toggled do
		FoundHumanoid.Health += (task.wait(0.25) * 0.1 * FoundHumanoid.MaxHealth)
	end
end)

script.Parent.Unequipped:Connect(function()
	FoundCharacter = script.Parent.Parent.Parent.Character

	Toggled = false

	CreateForceField(Toggled, FoundCharacter)

	FoundCharacter = nil
	FoundHumanoid = nil
end)