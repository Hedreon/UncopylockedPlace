--!strict
local Label = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:FindFirstChild("Packages")
local Fusion = require(Packages:FindFirstChild("fusion"))

local New = Fusion.New

function Label:Create(Properties: {Name: string, Visible: boolean, Text: string})
	return New("TextLabel") {
		Name = `{Properties.Name}Label`,
		Visible = Properties.Visible,
		Text = Properties.Text,
		
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.5,
		Size = UDim2.new(1, 0, 1, 0),
		FontFace = Font.fromEnum(Enum.Font.BuilderSans),
		RichText = true,
		TextColor3 = Color3.new(1, 1, 1),
		TextScaled = true
	}
end

return Label