--!strict
local _Crawler = {}

local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local LocalHumanoid = LocalCharacter:FindFirstChildOfClass("Humanoid")
local LocalAnimator = LocalHumanoid:FindFirstChildOfClass("Animator")
local LocalRootPart = LocalHumanoid.RootPart

local Modules = ReplicatedStorage:FindFirstChild("Modules")
local ActionTools = require(Modules:FindFirstChild("ActionTools"))

local Runner = script.Parent:FindFirstChild("Runner")

local CrawlAnimation = script:FindFirstChild("CrawlAnimation")
local LoadedAnimation = LocalAnimator:LoadAnimation(CrawlAnimation)

local Action = "ACTION_CRAWL"

local Crawling = false

local function PlayTrack(Track: AnimationTrack, Playing: boolean)
	if Playing then
		Track:Play()
	else
		Track:Stop()
	end
end

local function HandleAction(ActionName: string, InputState: Enum.UserInputState, _)
	if ActionName == Action then
		if InputState == Enum.UserInputState.Begin then
			Crawling = not Crawling

			LocalHumanoid:UnequipTools()

			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not Crawling)

			script:SetAttribute("Crawling", Crawling)

			PlayTrack(LoadedAnimation, Crawling)

			LoadedAnimation:AdjustSpeed(0)

			LocalRootPart.CanCollide = not Crawling

			LocalHumanoid.WalkSpeed = (Crawling and Runner:GetAttribute("Running") and 6) or (Crawling and 4) or (Runner:GetAttribute("Running") and 24) or 16

			LocalHumanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
				LoadedAnimation:AdjustSpeed((LocalHumanoid.MoveDirection.Magnitude > 0 and ((Runner:GetAttribute("Running") and 1.25) or 1)) or 0)
			end)
		end
	end
end

local function Crawler()
	LocalPlayer.CharacterAdded:Connect(function(Character)
		LocalHumanoid = Character:FindFirstChildOfClass("Humanoid")
		LocalAnimator = LocalHumanoid:FindFirstChildOfClass("Animator")
		LoadedAnimation = LocalAnimator:LoadAnimation(CrawlAnimation)
	end)

	ContextActionService:BindAction(Action, HandleAction, true, Enum.KeyCode.C, Enum.KeyCode.ButtonY)
	ContextActionService:SetTitle(Action, "Crawl")
	ContextActionService:SetPosition(Action, UDim2.new(0.55, 0, 0.1, 0))

	ActionTools:ModifyTouchButton(Action)
end

return Crawler