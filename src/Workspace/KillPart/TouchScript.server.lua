local StarterPlayer: StarterPlayer = game:GetService("StarterPlayer")
local StarterPlayerScripts: Instance? = StarterPlayer:FindFirstChild("StarterPlayerScripts")
local CharacterTools: any = if StarterPlayerScripts then require(StarterPlayerScripts:FindFirstChild("CharacterTools")) else nil

script.Parent.Touched:Connect(function(Hit: BasePart)
	CharacterTools:Kill(Hit)
end)