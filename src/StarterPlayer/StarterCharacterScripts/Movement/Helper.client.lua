local UserInputService: UserInputService = game:GetService("UserInputService")

local Movement: any = require(script.Parent)

UserInputService.InputBegan:Connect(function(Input: InputObject)
	if Input.KeyCode == Enum.KeyCode.C or Input.KeyCode == Enum.KeyCode.ButtonX then
		Movement:Crawl()
	end

	if Input.KeyCode == Enum.KeyCode.LeftShift or Input.KeyCode == Enum.KeyCode.ButtonR2 then
		Movement:Sprint(true)
	end
end)

UserInputService.InputEnded:Connect(function(Input: InputObject)
	if Input.KeyCode == Enum.KeyCode.LeftShift or Input.KeyCode == Enum.KeyCode.ButtonR2 then
		Movement:Sprint(false)
	end
end)