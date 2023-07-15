local UserInputService: UserInputService = game:GetService("UserInputService")

local Movement: any = require(script.Parent)

UserInputService.InputBegan:Connect(function(Input: InputObject)
	if Input.KeyCode == Enum.KeyCode.C then
		Movement:Crawl()
	end

	if Input.KeyCode == Enum.KeyCode.LeftShift then
		Movement:Sprint(true)
	end
end)

UserInputService.InputEnded:Connect(function(Input: InputObject)
	if Input.KeyCode == Enum.KeyCode.LeftShift then
		Movement:Sprint(false)
	end
end)