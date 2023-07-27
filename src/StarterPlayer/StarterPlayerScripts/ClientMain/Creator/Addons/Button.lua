local Button = {}

local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages: Instance? = ReplicatedStorage:FindFirstChild("Packages")

local Fusion: any = if Packages then require(Packages:WaitForChild("fusion")) else nil
local New: any = Fusion.New
local OnEvent: any = Fusion.OnEvent

function Button:Create(Properties: {Name: string, Text: string, Size: UDim2, Position: UDim2, AnchorPoint: Vector2, OnClick: any})
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