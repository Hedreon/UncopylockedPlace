--!strict
local Run = {}

local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local LocalHumanoid = LocalCharacter:FindFirstChildOfClass("Humanoid")

local Modules = ReplicatedStorage:FindFirstChild("Modules")
local Mobiler = require(Modules:FindFirstChild("Mobiler"))

local CrawlModule = script.Parent:FindFirstChild("Crawl")

local CurrentCamera = workspace.CurrentCamera
local OriginalFieldOfView = CurrentCamera.FieldOfView

local TweenData = TweenInfo.new(0.2)

local Action = "ACTION_RUN"

local Running = false

local function HandleAction(ActionName: string, InputState: Enum.UserInputState, Input: InputObject)
	if ActionName == Action then
		if Input.UserInputType ~= Enum.UserInputType.Touch and not string.find(Input.UserInputType.Name, "Gamepad") then
			if InputState == Enum.UserInputState.Begin then
				script:SetAttribute("Running", true)

				TweenService:Create(CurrentCamera, TweenData, {FieldOfView = 75}):Play()

				LocalHumanoid.WalkSpeed = (CrawlModule:GetAttribute("Crawling") and 6) or 24

				ContextActionService:SetTitle(Action, "Walk")
			elseif InputState == Enum.UserInputState.End then
				script:SetAttribute("Running", false)

				TweenService:Create(CurrentCamera, TweenData, {FieldOfView = OriginalFieldOfView}):Play()

				LocalHumanoid.WalkSpeed = (CrawlModule:GetAttribute("Crawling") and 4) or 16

				ContextActionService:SetTitle(Action, "Run")
			end
		elseif Input.UserInputType == Enum.UserInputType.Touch or string.find(Input.UserInputType.Name, "Gamepad") then
			if InputState == Enum.UserInputState.Begin then
				Running = not Running

				script:SetAttribute("Running", Running)

				TweenService:Create(CurrentCamera, TweenData, {FieldOfView = (Running and 75) or OriginalFieldOfView}):Play()

				LocalHumanoid.WalkSpeed = (CrawlModule:GetAttribute("Crawling") and Running and 6) or (CrawlModule:GetAttribute("Crawling") and 4) or (Running and 24) or 16

				ContextActionService:SetTitle(Action, (Running and "Walk") or "Run")
			end
		end
	end
end

local function ResetToDefault()
	TweenService:Create(CurrentCamera, TweenData, {FieldOfView = OriginalFieldOfView}):Play()

	LocalHumanoid.WalkSpeed = 16

	ContextActionService:SetTitle(Action, "Run")

	Running = false

	script:SetAttribute("Running", Running)
end

function Run:Init()
	LocalPlayer.CharacterAdded:Connect(function(Character)
		LocalHumanoid = Character:FindFirstChildOfClass("Humanoid")
		CurrentCamera = workspace.CurrentCamera

		ResetToDefault()
	end)

	GuiService.MenuOpened:Connect(ResetToDefault)

	ContextActionService:BindAction(Action, HandleAction, true, Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonL3)
	ContextActionService:SetTitle(Action, "Run")
	ContextActionService:SetPosition(Action, UDim2.new(0.25, 0, 0.3, 0))

	Mobiler:ModifyTouchButton(Action)
end

return Run