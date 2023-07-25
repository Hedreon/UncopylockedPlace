local GUI = {}

local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players: Players = game:GetService("Players")

local LocalPlayer: Player? = Players.LocalPlayer
local PlayerGui: PlayerGui? = if LocalPlayer then LocalPlayer:FindFirstChildOfClass("PlayerGui") else nil
local PlayerScripts: PlayerScripts? = if LocalPlayer then LocalPlayer:FindFirstChildOfClass("PlayerScripts") else nil

local LayoutHandler: Instance? = if PlayerScripts then PlayerScripts:WaitForChild("LayoutHandler") else nil
local LayoutChanged: Instance? = if LayoutHandler then LayoutHandler:FindFirstChild("LayoutChanged") else nil
local GetLayout: Instance? = if LayoutHandler then LayoutHandler:FindFirstChild("GetLayout") else nil

local LayoutToDetect: any = {
	["MouseKeyboard"] = "PC",
	["Touch"] = "Touch",
	["Gamepad"] = "Gamepad"
}

local InvokeLayout: any = if GetLayout and GetLayout:IsA("BindableFunction") then GetLayout:Invoke() else nil
local DetectFromLayout: any = LayoutToDetect[InvokeLayout]

local Packages: Instance? = ReplicatedStorage:FindFirstChild("Packages")

local Fusion: any = if Packages then require(Packages:WaitForChild("fusion")) else nil
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
		local _UI: any = New "ScreenGui" {
			Name = "MainGui",
			Parent = PlayerGui,

			[Children] = {
				Creator:Initialize()
			}
		}

		FirstTime(PlayerGui:WaitForChild("MainGui"):FindFirstChild("MainFrame"))
	end
end

if LayoutChanged and LayoutChanged:IsA("BindableEvent") then
	LayoutChanged.Event:Connect(function(CurrentLayout: string, PreviousLayout: string)
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
end

return GUI