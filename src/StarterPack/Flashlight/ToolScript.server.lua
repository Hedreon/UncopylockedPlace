--!strict
local Handle = script.Parent:FindFirstChild("Handle")
local ClickSound = Handle:FindFirstChild("ClickSound")
local Light = Handle:FindFirstChild("Light")

local Toggled = false

script.Parent.Activated:Connect(function()
	Toggled = not Toggled
	
	ClickSound.PlaybackSpeed = (Toggled and 1) or 0.8
	
	ClickSound:Play()

	Light.Enabled = Toggled

	Handle.TextureID = (Toggled and "rbxassetid://115984370") or "rbxassetid://115955343"
end)

script.Parent.Unequipped:Connect(function()
	Toggled = false
	
	ClickSound.PlaybackSpeed = 1

	Light.Enabled = Toggled

	Handle.TextureID = "rbxassetid://115955343"
end)