--!strict
local POI = {}

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local RootPart = Humanoid.RootPart

function POI:Init()
	LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
		Humanoid = NewCharacter:FindFirstChildOfClass("Humanoid")
		RootPart = Humanoid.RootPart
	end)
	
	for _, TaggedChild in CollectionService:GetTagged("PointOfInterest") do
		if TaggedChild:IsA("BasePart") then
			local DistanceGui = Instance.new("BillboardGui")
			DistanceGui.LightInfluence = 1
			DistanceGui.MaxDistance = 100
			DistanceGui.Size = UDim2.new(32, 0, 8, 0)
			DistanceGui.Name = "DistanceGui"
			DistanceGui.Parent = TaggedChild
			
			local DistanceLabel = Instance.new("TextLabel")
			DistanceLabel.BackgroundTransparency = 1
			DistanceLabel.Name = "DistanceLabel"
			DistanceLabel.Size = UDim2.new(1, 0, 1, 0)
			DistanceLabel.FontFace = Font.fromName("BuilderSans", Enum.FontWeight.ExtraBold)
			DistanceLabel.RichText = true
			DistanceLabel.Text = string.upper(TaggedChild.Name)
			DistanceLabel.TextColor3 = Color3.new(1, 1, 1)
			DistanceLabel.TextScaled = true
			DistanceLabel.TextStrokeTransparency = 0
			DistanceLabel.TextXAlignment = Enum.TextXAlignment.Left
			DistanceLabel.TextYAlignment = Enum.TextYAlignment.Top
			DistanceLabel.Parent = DistanceGui
			
			task.spawn(function()
				while task.wait() do
					DistanceLabel.Text = `{string.upper(TaggedChild.Name)}<br />{math.round((RootPart.Position - TaggedChild.Position).Magnitude)} studs`
				end
			end)
		end
	end
end

return POI