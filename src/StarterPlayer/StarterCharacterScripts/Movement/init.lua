local Movement = {}

local Players: Players = game:GetService("Players")

local LocalPlayer: Player? = Players.LocalPlayer
local Character: Model? = if LocalPlayer then LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() else nil
local Humanoid: Humanoid? = if Character then Character:FindFirstChildOfClass("Humanoid") else nil

local SprintMultiplier: number = script:GetAttribute("SprintMultiplier")

local Crawling: boolean = false
local Sprinting: boolean = false

local CrawlAnimation: Animation = Instance.new("Animation")
CrawlAnimation.AnimationId = "rbxassetid://6247060826"
CrawlAnimation.Parent = Character

local function LoadAnimation(Animation: Animation)
	if Humanoid then
		local Animator: Animator? = Humanoid:FindFirstChildOfClass("Animator")

		if Animator then
			local AnimationTrack: AnimationTrack = Animator:LoadAnimation(Animation)
			return AnimationTrack
		end
	end

	return nil
end

local LoadedAnimation: AnimationTrack = LoadAnimation(CrawlAnimation)

function Movement:Crawl()
	if Humanoid then
		if not Crawling then
			LoadedAnimation:Play()
			
			Humanoid.WalkSpeed = 4

			Crawling = true
		else
			LoadedAnimation:Stop()

			Humanoid.WalkSpeed = 16

			Crawling = false
		end
	end
end

function Movement:Sprint(Enabled: boolean)
	if Humanoid then
		if Enabled then
			if Crawling then
				Humanoid.WalkSpeed = 6
			else
				Humanoid.WalkSpeed = math.round(Humanoid.WalkSpeed * SprintMultiplier)
			end

			Sprinting = true
		else
			if Crawling then
				Humanoid.WalkSpeed = 4
			else
				Humanoid.WalkSpeed = 16
			end

			Sprinting = false
		end
	end
end

task.spawn(function()
	while task.wait() do
		if Humanoid then
			if Humanoid.MoveDirection.Magnitude == 0 then
				LoadedAnimation:AdjustSpeed(0)
			else
				if Sprinting then
					LoadedAnimation:AdjustSpeed(1.25)
				else
					LoadedAnimation:AdjustSpeed(1)
				end
			end
		end
	end
end)

return Movement