local StarterPlayer: StarterPlayer = game:GetService("StarterPlayer")
local StarterPlayerScripts: Instance? = StarterPlayer:FindFirstChild("StarterPlayerScripts")
local CharacterTools: any = StarterPlayerScripts and require(StarterPlayerScripts:FindFirstChild("CharacterTools")) or nil

script.Parent.Touched:Connect(function(Hit: BasePart)
	CharacterTools:Kill(Hit)
end)