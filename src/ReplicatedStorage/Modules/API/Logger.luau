--!strict
local Logger = {}

Logger.__index = Logger

--[[
	Initializes the Logger object with the specified Source parameter.
]]--
function Logger.new(Source: string)
	local self = setmetatable({
		Source = Source
	}, Logger)

	return self
end

--[[
	Prints information to the output in the following format:
	[SOURCE]: MESSAGE
]]--
function Logger:Inform(...)
	print(`[{self.Source}]: {...}`)
end

--[[
	Prints a warning to the output in the following format:
	[SOURCE]: MESSAGE
]]--
function Logger:Warn(...)
	warn(`[{self.Source}]: {...}`)
end

--[[
	Prints a level 2 error to the output in the following format:
	MESSAGE
]]--
function Logger:Error(...)
	error(..., 2)
end

return Logger