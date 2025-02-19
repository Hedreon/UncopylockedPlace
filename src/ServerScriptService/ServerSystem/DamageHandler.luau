--!strict
local _DamageHandler = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:FindFirstChild("Modules")
local API = Modules:FindFirstChild("API")
local TouchAPI = require(API:FindFirstChild("Touch"))

local function DamageHandler()
	for _, Descendant in workspace:GetDescendants() do
		local DamageAttribute: number = Descendant:GetAttribute("Damage")
		local DeadlyAttribute: boolean = Descendant:GetAttribute("Deadly")
		local TimeoutAttribute: number = Descendant:GetAttribute("Timeout")

		if DamageAttribute and TimeoutAttribute then
			if Descendant:IsA("Model") then
				for _, Child in Descendant:GetChildren() do
					if Child:IsA("BasePart") then
						TouchAPI.new(Child, function(_, _, _, Humanoid)
							Humanoid:TakeDamage(DamageAttribute)
						end, Child, TimeoutAttribute)
					end
				end
			elseif Descendant:IsA("BasePart") then
				TouchAPI.new(Descendant, function(_, _, _, Humanoid)
					Humanoid:TakeDamage(DamageAttribute)
				end, Descendant, TimeoutAttribute)
			end
		elseif DeadlyAttribute then
			if Descendant:IsA("Model") then
				for _, Child in Descendant:GetChildren() do
					if Child:IsA("BasePart") then
						TouchAPI.new(Child, function(_, _, _, Humanoid)
							Humanoid.Health = 0
						end)
					end
				end
			elseif Descendant:IsA("BasePart") then
				TouchAPI.new(Descendant, function(_, _, _, Humanoid)
					Humanoid.Health = 0
				end)
			end
		end
	end
end

return DamageHandler