local Label: any = {}

local ReplicatedStorage: any = game:GetService("ReplicatedStorage")

local Fusion: any = require(ReplicatedStorage.Packages.fusion)
local New: any = Fusion.New

function Label:Create(Properties: any)
	return New "TextLabel" {
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.5,
		FontFace = Font.fromEnum(Enum.Font.Gotham),
		TextColor3 = Color3.new(1, 1, 1),
		TextScaled = true,
		RichText = true,
		Visible = false,

		Name = Properties.Name .. "Label",
		Text = Properties.Text,
		Size = Properties.Size,
		Position = Properties.Position,
	}
end

return Label