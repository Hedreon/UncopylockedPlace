--!strict
local Crawl = {}

local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local LocalHumanoid = LocalCharacter:FindFirstChildOfClass("Humanoid")
local LocalRootPart = LocalHumanoid.RootPart

local Modules = ReplicatedStorage:FindFirstChild("Modules")
local AnimatorTools = require(Modules:FindFirstChild("AnimatorTools"))
local Mobiler = require(Modules:FindFirstChild("Mobiler"))

local RunModule = script.Parent:FindFirstChild("Run")

local CrawlAnimation = script:FindFirstChild("CrawlAnimation")
local LoadedAnimation: AnimationTrack = AnimatorTools:LoadAnimation(LocalHumanoid, CrawlAnimation) :: AnimationTrack

local Action = "ACTION_CRAWL"

local Crawling = false

local function HandleAction(ActionName: string, InputState: Enum.UserInputState, _)
	if ActionName == Action then
		if InputState == Enum.UserInputState.Begin then
			Crawling = not Crawling

			script:SetAttribute("Crawling", Crawling)

			AnimatorTools:PlayTrack(LoadedAnimation, Crawling)

			LoadedAnimation:AdjustSpeed(0)

			LocalRootPart.CanCollide = not Crawling

			LocalHumanoid.WalkSpeed = (Crawling and RunModule:GetAttribute("Running") and 6) or (Crawling and 4) or (RunModule:GetAttribute("Running") and 24) or 16

			LocalHumanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
				LoadedAnimation:AdjustSpeed((LocalHumanoid.MoveDirection.Magnitude > 0 and ((RunModule:GetAttribute("Running") and 1.25) or 1)) or 0)
			end)
		end
	end
end

function Crawl:Init()
	LocalPlayer.CharacterAdded:Connect(function(Character)
		LocalHumanoid = Character:FindFirstChildOfClass("Humanoid")
		LoadedAnimation = AnimatorTools:LoadAnimation(LocalHumanoid, CrawlAnimation) :: AnimationTrack
	end)

	ContextActionService:BindAction(Action, HandleAction, true, Enum.KeyCode.C, Enum.KeyCode.ButtonY)
	ContextActionService:SetTitle(Action, "Crawl")
	ContextActionService:SetPosition(Action, UDim2.new(0.55, 0, 0.1, 0))

	Mobiler:ModifyTouchButton(Action)
end

return Crawl