--!strict
local Laype = {}

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local GetLayout = script:FindFirstChild("GetLayout")
local LayoutChanged = script:FindFirstChild("LayoutChanged")

local CurrentInputLayout = "Unidentified"

function Laype:Init()
	if UserInputService.MouseEnabled then
		CurrentInputLayout = "Desktop"
	elseif #UserInputService:GetConnectedGamepads() > 0 then
		CurrentInputLayout = "Console"
	else
		CurrentInputLayout = "Touch"
	end

	UserInputService.LastInputTypeChanged:Connect(function(LastInputType)
		local PreviousInputLayout = CurrentInputLayout
		
		if string.find(LastInputType.Name, "Gamepad") then
			CurrentInputLayout = "Console"
		elseif LastInputType.Name == "Keyboard" or string.find(LastInputType.Name, "Mouse") then
			CurrentInputLayout = "Desktop"
		elseif LastInputType.Name == "Touch" then
			CurrentInputLayout = "Touch"
		end
		
		if CurrentInputLayout ~= PreviousInputLayout then
			LayoutChanged:Fire(CurrentInputLayout, PreviousInputLayout)
		end
	end)
	
	GetLayout.OnInvoke = function()
		while CurrentInputLayout == "Unidentified" do
			RunService.Heartbeat:Wait()
		end
		
		return CurrentInputLayout
	end
end

return Laype