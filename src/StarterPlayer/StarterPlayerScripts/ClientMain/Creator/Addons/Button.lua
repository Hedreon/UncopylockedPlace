local Button: any = {}

local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages: Instance? = ReplicatedStorage:FindFirstChild("Packages")

local Fusion: any = Packages and require(Packages:WaitForChild("fusion")) or nil
local New: any = Fusion.New
local OnEvent: any = Fusion.OnEvent

function Button:Create(Properties: any)
	return New "TextButton" {
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.5,
		TextColor3 = Color3.new(1, 1, 1),
		TextScaled = true,
		FontFace = Font.fromEnum(Enum.Font.GothamMedium),
		AutoButtonColor = true,
		Visible = false,

		Name = Properties.Name .. "Button",
		Text = Properties.Text,
		Size = Properties.Size,
		Position = Properties.Position,
		AnchorPoint = Properties.AnchorPoint,

		[OnEvent "Activated"] = Properties.OnClick
	}
end

return Button