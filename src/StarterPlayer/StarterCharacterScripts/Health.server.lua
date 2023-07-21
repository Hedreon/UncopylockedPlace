local Character: Instance? = script.Parent
local Humanoid: Humanoid? = if Character then Character:FindFirstChildOfClass("Humanoid") else nil

while true do
	if Humanoid then
		while Humanoid.Health < Humanoid.MaxHealth do
			local RegenerationTime = task.wait(script:GetAttribute("RegenerationTime"))
			local RegenerationRate = RegenerationTime * script:GetAttribute("RegenerationRate") * Humanoid.MaxHealth
			
			Humanoid.Health = math.min(Humanoid.Health + RegenerationRate, Humanoid.MaxHealth)
		end
		
		Humanoid.HealthChanged:Wait()
	end
end