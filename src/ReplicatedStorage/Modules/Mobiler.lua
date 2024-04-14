--!strict
local Mobiler = {}

local ContextActionService = game:GetService("ContextActionService")

function Mobiler:ModifyTouchButton(ActionName: string)
	local TouchButton: Instance? = ContextActionService:GetButton(ActionName)
	
	if TouchButton and TouchButton:IsA("ImageButton") then
		local Constraint = Instance.new("UIAspectRatioConstraint")
		Constraint.Name = "Constraint"
		Constraint.AspectType = Enum.AspectType.ScaleWithParentSize
		Constraint.Parent = TouchButton
		
		local Scaler = Instance.new("UIScale")
		Scaler.Name = "Scaler"
		Scaler.Scale = 1.25
		Scaler.Parent = TouchButton
		
		TouchButton.Size = UDim2.new(0.2, 0, 0.2, 0)
		TouchButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
		TouchButton.ImageColor3 = Color3.new(0, 0, 0)
		TouchButton.ImageRectOffset = Vector2.new(1, 1)
		TouchButton.ImageRectSize = Vector2.new(144, 144)

		TouchButton.Changed:Connect(function()
			TouchButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
			TouchButton.ImageRectOffset = Vector2.new(1, 1)
			TouchButton.ImageRectSize = Vector2.new(144, 144)
		end)

		TouchButton.MouseButton1Down:Connect(function()
			TouchButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
		end)

		TouchButton.MouseButton1Up:Connect(function()
			TouchButton.ImageColor3 = Color3.new(0, 0, 0)
		end)
		
		local ActionIcon: Instance? = TouchButton:FindFirstChild("ActionIcon")
		
		if ActionIcon then
			ActionIcon:Destroy()
		end
		
		local ActionTitle: Instance? = TouchButton:FindFirstChild("ActionTitle")
		
		if ActionTitle and ActionTitle:IsA("TextLabel") then
			local TextConstraint = Instance.new("UITextSizeConstraint")
			TextConstraint.Name = "TextConstraint"
			TextConstraint.MaxTextSize = 20
			TextConstraint.MinTextSize = 8
			TextConstraint.Parent = ActionTitle
			
			ActionTitle.FontFace = Font.fromEnum(Enum.Font.BuilderSansBold)
			ActionTitle.TextScaled = true
			ActionTitle.TextTransparency = 0.2
		end
	end
end

return Mobiler