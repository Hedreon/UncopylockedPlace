local StarterPlayer: StarterPlayer = game:GetService("StarterPlayer")
local StarterPlayerScripts: Instance? = StarterPlayer:FindFirstChild("StarterPlayerScripts")
local CharacterTools: any = if StarterPlayerScripts then require(StarterPlayerScripts:FindFirstChild("CharacterTools")) else nil

local Debounce: boolean = false

script.Parent.Touched:Connect(function(Hit: BasePart)
	if not Debounce then
		Debounce = true
		CharacterTools:Damage(Hit, 25)
		task.wait(1)
		Debounce = false
	end
end)