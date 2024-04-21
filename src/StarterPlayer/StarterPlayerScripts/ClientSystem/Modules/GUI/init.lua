--!strict
local GUI = {}

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

local Packages = ReplicatedStorage:FindFirstChild("Packages")
local Fusion = require(Packages:FindFirstChild("fusion"))

local Children = Fusion.Children
local New = Fusion.New

local Button = require(script:FindFirstChild("Button"))
local ContainerFrame = require(script:FindFirstChild("ContainerFrame"))
local Label = require(script:FindFirstChild("Label"))

local ControlsGui = nil
local ControlsFrame: Frame = nil
local ContentFrame = nil
local DesktopLabel = nil
local ConsoleLabel = nil

local Laype = script.Parent:FindFirstChild("Laype")
local GetLayout = Laype:FindFirstChild("GetLayout")
local LayoutChanged = Laype:FindFirstChild("LayoutChanged")

local LayoutTags = {
	["Desktop"] = "DesktopUI",
	["Console"] = "ConsoleUI",
	["Touch"] = "TouchUI"
}

local Opened = false

local function FormatKeyCode(KeyCode: Enum.KeyCode)
	return string.sub(UserInputService:GetStringForKeyCode(KeyCode), 7)
end

function GUI:Init()
	ControlsGui = New("ScreenGui") {
		Name = "ControlsGui",
		Parent = PlayerGui,
		
		[Children] = {
			ContainerFrame:Create({
				Name = "Controls",
				Visible = false,
				Size = UDim2.new(0.2, 0, 0.5, 0),
				Position = UDim2.new(0, 0, 1.4, 0),
				AnchorPoint = Vector2.new(0, 1),
				
				[Children] = {
					Button:Create({
						Name = "Controls",
						Size = UDim2.new(1, 0, 0.2, 0),
						Text = "Controls",
						
						OnClick = function()
							Opened = not Opened
							ControlsFrame:TweenPosition((Opened and UDim2.new(0, 0, 1, 0)) or UDim2.new(0, 0, 1.4, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.5)
						end
					}),
					
					ContainerFrame:Create({
						Name = "Content",
						Visible = true,
						Size = UDim2.new(1, 0, 0.8, 0),
						Position = UDim2.new(0, 0, 0.2, 0),
						
						[Children] = {
							Label:Create({
								Name = "Desktop",
								Visible = false,
								Text = "Run: <font color=\"#CCCCCC\"><b>Shift</b></font><br />Crawl: <font color=\"#CCCCCC\"><b>C</b></font>"
							}),
							
							Label:Create({
								Name = "Console",
								Visible = false,
								Text = `Run: <font color="#CCCCCC"><b>>{FormatKeyCode(Enum.KeyCode.ButtonL3)}</b></font><br />Crawl: <font color="#FFDD00"><b>{FormatKeyCode(Enum.KeyCode.ButtonY)}</b></font>`
							})
						}
					})
				}
			})
		}
	}
	
	ControlsFrame = ControlsGui:WaitForChild("ControlsFrame") :: Frame
	ContentFrame = ControlsFrame:WaitForChild("ContentFrame")
	DesktopLabel = ContentFrame:FindFirstChild("DesktopLabel")
	ConsoleLabel = ContentFrame:FindFirstChild("ConsoleLabel")
	
	CollectionService:AddTag(ControlsFrame, "DesktopUI")
	CollectionService:AddTag(ControlsFrame, "ConsoleUI")
	CollectionService:AddTag(DesktopLabel, "DesktopUI")
	CollectionService:AddTag(ConsoleLabel, "ConsoleUI")
	
	local InputLayout = GetLayout:Invoke()
	local TagFromLayout = LayoutTags[InputLayout]
	
	local UIsToToggle = CollectionService:GetTagged(TagFromLayout)
	
	for Index = 1, #UIsToToggle do
		UIsToToggle[Index].Visible = true
	end
	
	LayoutChanged.Event:Connect(function(CurrentInputLayout, PreviousInputLayout)
		TagFromLayout = LayoutTags[PreviousInputLayout]
		
		local UIsToHide = CollectionService:GetTagged(TagFromLayout)
		
		for OldIndex = 1, #UIsToHide do
			UIsToHide[OldIndex].Visible = false
		end

		TagFromLayout = LayoutTags[CurrentInputLayout]
		
		local UIsToShow = CollectionService:GetTagged(TagFromLayout)
		
		for NewIndex = 1, #UIsToShow do
			UIsToShow[NewIndex].Visible = true
		end
	end)
end

return GUI