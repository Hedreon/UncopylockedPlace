local UserInputService: UserInputService = game:GetService("UserInputService")
local RunService: RunService = game:GetService("RunService")

local CurrentLayout: string = "Unidentified"

if UserInputService.MouseEnabled then
	CurrentLayout = "MouseKeyboard"
elseif #UserInputService:GetConnectedGamepads() > 0 then
	CurrentLayout = "Gamepad"
else
	CurrentLayout = "Touch"
end

UserInputService.LastInputTypeChanged:Connect(function(UserInputType: Enum.UserInputType)
	local PreviousLayout: string = CurrentLayout
	
	if string.find(UserInputType.Name, "Gamepad") ~= nil then
		CurrentLayout = "Gamepad"
	elseif UserInputType.Name == "Keyboard" or string.find(UserInputType.Name, "Mouse") ~= nil then
		CurrentLayout = "MouseKeyboard"
	elseif UserInputType.Name == "Touch" then
		CurrentLayout = "Touch"
	end
	
	if CurrentLayout ~= PreviousLayout then
		script.LayoutChanged:Fire(CurrentLayout, PreviousLayout)
	end
end)

script.GetLayout.OnInvoke = function()
	while CurrentLayout == "Unidentified" do
		RunService.Heartbeat:Wait()
	end
	
	return CurrentLayout
end