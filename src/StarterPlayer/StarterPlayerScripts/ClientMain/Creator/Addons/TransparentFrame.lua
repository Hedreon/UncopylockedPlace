local TransparentFrame: any = {}

local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages: Instance? = ReplicatedStorage:FindFirstChild("Packages")

local Fusion: any = if Packages then require(Packages:WaitForChild("fusion")) else nil
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