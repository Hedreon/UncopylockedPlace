local Label = {}

local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages: Instance? = ReplicatedStorage:FindFirstChild("Packages")

local Fusion: any = if Packages then require(Packages:WaitForChild("fusion")) else nil
local New: any = Fusion.New

function Label:Create(Properties: {Name: string, Text: string, Size: UDim2, Position: UDim2})
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