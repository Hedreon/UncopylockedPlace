local GUI: any = {}

local ReplicatedStorage: any = game:GetService("ReplicatedStorage")
local Players: Players = game:GetService("Players")

local LocalPlayer: any? = Players.LocalPlayer
local PlayerGui: PlayerGui? = if LocalPlayer then LocalPlayer.PlayerGui else nil
local PlayerScripts: PlayerScripts = if LocalPlayer then LocalPlayer.PlayerScripts else nil

local LayoutHandler: any = PlayerScripts:WaitForChild("LayoutHandler")

local LayoutToDetect: any = {
	["MouseKeyboard"] = "PC",
	["Touch"] = "Touch",
	["Gamepad"] = "Gamepad"
}

local InvokeLayout: any = LayoutHandler.GetLayout:Invoke()
local DetectFromLayout: any = LayoutToDetect[InvokeLayout]

local Fusion: any = require(ReplicatedStorage.Packages.fusion)
local New: any = Fusion.New
local Children: any = Fusion.Children

local Creator: any = require(script.Parent.Creator)

local function FirstTime(Location: Instance?)
	if Location then
		for _, Child: Instance in Location:GetChildren() do
			if Child:IsA("GuiObject") then
				if string.find(Child.Name, DetectFromLayout) then
					Child.Visible = true
				end
			end
		end
	end
end

function GUI:Initialize()
	if PlayerGui then
		local _UI = New "ScreenGui" {
			Name = "MainGui",
			Parent = PlayerGui,

			[Children] = {
				Creator:Initialize()
			}
		}

		FirstTime(PlayerGui:WaitForChild("MainGui"):FindFirstChild("MainFrame"))
	end
end

LayoutHandler.LayoutChanged.Event:Connect(function(CurrentLayout: string, PreviousLayout: string)
	DetectFromLayout = LayoutToDetect[PreviousLayout]
	
	for _, Child: Instance in script.Parent:GetChildren() do
		if Child:IsA("GuiObject") then
			if string.find(Child.Name, DetectFromLayout) then
				Child.Visible = false
			end
		end
	end

	DetectFromLayout = LayoutToDetect[CurrentLayout]
	
	for _, Child: Instance in script.Parent:GetChildren() do
		if Child:IsA("GuiObject") then
			if string.find(Child.Name, DetectFromLayout) then
				Child.Visible = true
			end
		end
	end
end)

return GUI