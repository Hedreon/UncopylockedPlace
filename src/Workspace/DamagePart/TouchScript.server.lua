local StarterPlayer: StarterPlayer = game:GetService("StarterPlayer")
local StarterPlayerScripts: Instance? = StarterPlayer:FindFirstChild("StarterPlayerScripts")
local CharacterTools: any = StarterPlayerScripts and require(StarterPlayerScripts:FindFirstChild("CharacterTools")) or nil

local Debounce: boolean = false

script.Parent.Touched:Connect(function(Hit: BasePart)
	if not Debounce then
		Debounce = true
		CharacterTools:Damage(Hit, 25)
		task.wait(1)
		Debounce = false
	end
end)