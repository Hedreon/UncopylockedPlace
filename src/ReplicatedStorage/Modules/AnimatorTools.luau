--!strict
local AnimatorTools = {}

function AnimatorTools:LoadAnimation(Humanoid: Humanoid?, Animation: Animation) : AnimationTrack?
	if Humanoid then
		local Animator = Humanoid:FindFirstChildOfClass("Animator")

		if Animator then
			return Animator:LoadAnimation(Animation)
		end
	end

	return nil
end

function AnimatorTools:PlayTrack(Track: AnimationTrack?, Playing: boolean)
	if Track then
		if Playing then
			Track:Play()
		else
			Track:Stop()
		end
	end
end

return AnimatorTools