--!strict
local Button = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:FindFirstChild("Packages")
local Fusion = require(Packages:FindFirstChild("fusion"))

local New = Fusion.New
local OnEvent = Fusion.OnEvent

function Button:Create(Properties: {Name: string, Size: UDim2, Text: string, OnClick: any})
	return New("TextButton") {
		Name = `{Properties.Name}Button`,
		Size = Properties.Size,
		Text = Properties.Text,

		AutoButtonColor = true,
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.5,
		FontFace = Font.fromEnum(Enum.Font.BuilderSansBold),
		TextColor3 = Color3.new(1, 1, 1),
		TextScaled = true,

		[OnEvent("Activated")] = Properties.OnClick
	}
end

return Button