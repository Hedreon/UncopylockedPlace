--!strict
local ContainerFrame = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:FindFirstChild("Packages")
local Fusion = require(Packages:FindFirstChild("fusion"))

local Children = Fusion.Children
local New = Fusion.New

function ContainerFrame:Create(Properties: {Name: string, Size: UDim2?, Position: UDim2?, AnchorPoint: Vector2?, Visible: boolean?, [any]: any})
	return New("Frame") {
		Name = `{Properties.Name}Frame`,
		Size = Properties.Size or UDim2.new(1, 0, 1, 0),
		Position = Properties.Position or UDim2.new(0, 0, 0, 0),
		AnchorPoint = Properties.AnchorPoint or Vector2.zero,
		Visible = Properties.Visible or true,
		
		BackgroundTransparency = 1,

		[Children] = Properties[Children]
	}
end

return ContainerFrame