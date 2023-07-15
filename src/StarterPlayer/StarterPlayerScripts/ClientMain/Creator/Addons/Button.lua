local Button: any = {}

local ReplicatedStorage: any = game:GetService("ReplicatedStorage")

local Fusion: any = require(ReplicatedStorage.Packages.fusion)
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