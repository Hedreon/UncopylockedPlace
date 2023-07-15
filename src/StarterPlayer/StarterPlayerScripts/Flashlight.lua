local Flashlight: any = {}

local UserInputService: UserInputService = game:GetService("UserInputService")
local TweenService: TweenService = game:GetService("TweenService")
local Players: Players = game:GetService("Players")

local LocalPlayer: Player? = Players.LocalPlayer
local Character: Model? = if LocalPlayer then LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() else nil
local HumanoidRootPart: Instance? = if Character then Character:WaitForChild("HumanoidRootPart") else nil

local TweenData: TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)

local LightRange: number = script:GetAttribute("LightRange")

local FlashlightEnabled: boolean = false

function Flashlight:Flash(Enabled: boolean)
	if HumanoidRootPart then
		if Enabled then
			local RootLight: PointLight = Instance.new("PointLight")
			RootLight.Name = "RootLight"
			RootLight.Range = 0
			RootLight.Parent = HumanoidRootPart

			TweenService:Create(RootLight, TweenData, {Range = LightRange}):Play()
		else
			local Light: Instance = HumanoidRootPart:WaitForChild("RootLight")

			local DisabledTween: Tween = TweenService:Create(Light, TweenData, {Range = 0})
			DisabledTween:Play()
			DisabledTween.Completed:Wait()

			Light:Destroy()
		end
	end
end

UserInputService.InputBegan:Connect(function(Input: InputObject)
	if Input.KeyCode == Enum.KeyCode.L then
		if not FlashlightEnabled then
			Flashlight:Flash(true)
			FlashlightEnabled = true
		else
			Flashlight:Flash(false)
			FlashlightEnabled = false
		end
	end
end)

return Flashlight