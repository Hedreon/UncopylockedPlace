--!strict
local Modules = script:FindFirstChild("Modules")

for _, Module in Modules:GetChildren() do
	task.spawn(function()
		local LoadedModule = require(Module) :: never
		LoadedModule:Init()
	end)
end