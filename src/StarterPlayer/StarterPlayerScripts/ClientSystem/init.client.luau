--!strict
for _, Module in script:GetChildren() do
	task.spawn(function()
		local LoadedModule = require(Module) :: never
		LoadedModule:Init()
	end)
end