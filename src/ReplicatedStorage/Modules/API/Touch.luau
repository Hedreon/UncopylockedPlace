--!strict
local Touch = {}

local Players = game:GetService("Players")

local Logger = require(script.Parent:FindFirstChild("Logger")).new(`{script.Name}API`)

local Warnings = {
	Part = "No part has been provided",
	Handler = "No function handler has been provided"
}

local Debounces = {}

--[[
	Listens for the specified Part's touch events (with optional DebouncePart and Timeout parameters) and returns the following information:
	Hit - The Object that touched the specified Part.
	Player - The Player that touched the specified Part.
	Character - The Character that touched the specified Part.
	Humanoid - The Humanoid that touched the specified Part.
]]--
function Touch.new(Part: BasePart, Handler: (Hit: BasePart, Player: Player, Character: Model, Humanoid: Humanoid) -> (), DebouncePart: BasePart?, Timeout: number?)
	if Part then
		if Handler then
			Part.Touched:Connect(function(Hit)
				if not Debounces[DebouncePart or Part] then
					Debounces[DebouncePart or Part] = 1

					if Hit then
						local Character = Hit.Parent

						if Character and Character:IsA("Model") then
							local Humanoid = Character:FindFirstChildOfClass("Humanoid")

							if Humanoid and Humanoid.Health > 0 then
								local Player = Players:GetPlayerFromCharacter(Character)

								if Player then
									({Handler})[1](Hit, Player, Character, Humanoid)
								end
							end
						end
					end

					task.wait(Timeout or 1)

					Debounces[DebouncePart or Part] = nil
				end
			end)
		else
			Logger:Warn(Warnings.Handler)
		end
	else
		Logger:Warn(Warnings.Part)
	end
end

return Touch