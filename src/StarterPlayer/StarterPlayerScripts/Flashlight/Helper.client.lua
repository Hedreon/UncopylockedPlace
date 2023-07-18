local UserInputService: UserInputService = game:GetService("UserInputService")

local Flashlight: any = require(script.Parent)

local FlashlightEnabled: boolean = false

UserInputService.InputBegan:Connect(function(Input: InputObject)
    if Input.KeyCode == Enum.KeyCode.L or Input.KeyCode == Enum.KeyCode.ButtonL3 then
        if not FlashlightEnabled then
			Flashlight:Flash(true)
			FlashlightEnabled = true
		else
			Flashlight:Flash(false)
			FlashlightEnabled = false
		end
    end
end)