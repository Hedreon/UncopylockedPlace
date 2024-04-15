--!strict
local ContainerFrame = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:FindFirstChild("Packages")
local Fusion = require(Packages:FindFirstChild("fusion"))

local Children = Fusion.Children
local New = Fusion.New

function ContainerFrame:Create(Properties: {Name: string, Visible: boolean, Size: UDim2, Position: UDim2, AnchorPoint: Vector2?, [any]: any})
	return New("Frame") {
		Name = `{Properties.Name}Frame`,
		Visible = Properties.Visible,
		Size = Properties.Size,
		Position = Properties.Position,
		AnchorPoint = Properties.AnchorPoint or Vector2.zero,
		
		BackgroundTransparency = 1,

		[Children] = Properties[Children]
	}
end

return ContainerFrame