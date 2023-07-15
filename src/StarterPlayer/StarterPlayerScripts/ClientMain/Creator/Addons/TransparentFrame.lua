local TransparentFrame: any = {}

local ReplicatedStorage: any = game:GetService("ReplicatedStorage")

local Fusion: any = require(ReplicatedStorage.Packages.fusion)
local New: any = Fusion.New
local Children: any = Fusion.Children

function TransparentFrame:Create(Properties: any)
	return New "Frame" {
		BackgroundTransparency = 1,

		Name = Properties.Name .. "Frame",
		Size = Properties.Size,
		Position = Properties.Position,

		[Children] = Properties[Children]
	}
end

return TransparentFrame