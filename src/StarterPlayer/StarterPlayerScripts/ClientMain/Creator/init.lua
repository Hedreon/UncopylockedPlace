local Creator: any = {}

local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players: Players = game:GetService("Players")

local LocalPlayer: Player? = Players.LocalPlayer
local Character: Model? = if LocalPlayer then LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() else nil
local PlayerGui: PlayerGui? = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui") or nil
local PlayerScripts: PlayerScripts? = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerScripts") or nil

local LayoutHandler: Instance? = PlayerScripts and PlayerScripts:WaitForChild("LayoutHandler") or nil
local GetLayout: Instance? = LayoutHandler and LayoutHandler:FindFirstChild("GetLayout") or nil

local LayoutToDetect: any = {
	["MouseKeyboard"] = "PC",
	["Touch"] = "Touch",
	["Gamepad"] = "Gamepad"
}

local InvokeLayout: any = if GetLayout and GetLayout:IsA("BindableFunction") then GetLayout:Invoke() else nil
local DetectFromLayout: any = LayoutToDetect[InvokeLayout]

local Movement: any = Character and require(Character:WaitForChild("Movement")) or nil
local Flashlight: any = PlayerScripts and require(PlayerScripts:WaitForChild("Flashlight")) or nil

local Packages: Instance? = ReplicatedStorage:FindFirstChild("Packages")

local Fusion: any = Packages and require(Packages:WaitForChild("fusion")) or nil
local Children: any = Fusion.Children

local TransparentFrame: any = require(script.Addons.TransparentFrame)
local Button: any = require(script.Addons.Button)
local Label: any = require(script.Addons.Label)

local ClickDebounce: boolean = false

local FlashlightEnabled: boolean = false
local SprintEnabled: boolean = false

local Opened: boolean = false

function Creator:Initialize()
	return TransparentFrame:Create {
		Name = "Main",
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),

		[Children] = {
			Button:Create {
				Name = "PCGamepadControls",
				Text = "Controls",
				Size = UDim2.new(0.15, 0, 0.15, 0),
				Position = UDim2.new(0, 0, 1, 0),
				AnchorPoint = Vector2.new(0, 1),

				OnClick = function()
					local MainFrame: Instance? = PlayerGui and PlayerGui:WaitForChild("MainGui"):WaitForChild("MainFrame") or nil
					local PCGamepadControlsButton: Instance? = MainFrame and MainFrame:WaitForChild("PCGamepadControlsButton") or nil
					local PCControlsLabel: Instance? = MainFrame and MainFrame:WaitForChild("PCControlsLabel") or nil
					local GamepadControlsLabel: Instance? = MainFrame and MainFrame:WaitForChild("GamepadControlsLabel") or nil

					if PCGamepadControlsButton and PCControlsLabel and GamepadControlsLabel then
						if PCGamepadControlsButton:IsA("TextButton") and PCControlsLabel:IsA("TextLabel") and GamepadControlsLabel:IsA("TextLabel") then
							if not Opened then
								PCGamepadControlsButton:TweenPosition(UDim2.new(0, 0, 0.7, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.5)

								if DetectFromLayout == "PC" then
									PCControlsLabel:TweenPosition(UDim2.new(0, 0, 0.7, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.5)
								elseif DetectFromLayout == "Gamepad" then
									GamepadControlsLabel:TweenPosition(UDim2.new(0, 0, 0.7, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.5)
								end

								Opened = true
							else
								PCGamepadControlsButton:TweenPosition(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.5)

								if DetectFromLayout == "PC" then
									PCControlsLabel:TweenPosition(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.5)
								elseif DetectFromLayout == "Gamepad" then
									GamepadControlsLabel:TweenPosition(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.5)
								end

								Opened = false
							end
						end
					end
				end
			},
			
			Button:Create {
				Name = "TouchSprint",
				Text = "Sprint",
				Size = UDim2.new(1, 0, 0.2, 0),
				Position = UDim2.new(1, 0, 0.2, 0),
				AnchorPoint = Vector2.new(1, 0.2),

				OnClick = function()
					if not SprintEnabled then
						Movement:Sprint(true)
						SprintEnabled = true
					else
						Movement:Sprint(false)
						SprintEnabled = false
					end
				end
			},
			
			Button:Create {
				Name = "TouchCrawl",
				Text = "Crawl",
				Size = UDim2.new(1, 0, 0.2, 0),
				Position = UDim2.new(1, 0, 0.5, 0),
				AnchorPoint = Vector2.new(1, 0.5),

				OnClick = function()
					if not ClickDebounce then
						ClickDebounce = true
						Movement:Crawl()
						task.wait(1)
						ClickDebounce = false
					end
				end
			},
			
			Button:Create {
				Name = "TouchFlashlight",
				Text = "Flashlight",
				Size = UDim2.new(1, 0, 0.2, 0),
				Position = UDim2.new(1, 0, 0.8, 0),
				AnchorPoint = Vector2.new(1, 0.8),

				OnClick = function()
					if not FlashlightEnabled then
						Flashlight:Flash(true)
						FlashlightEnabled = true
					else
						Flashlight:Flash(false)
						FlashlightEnabled = false
					end
				end
			},
			
			Label:Create {
				Name = "PCControls",
				Text = "Sprint: <b>Left Shift</b><br />Crawl: <b>C</b><br />Flashlight: <b>L</b>",
				Size = UDim2.new(0.15, 0, 0.3, 0),
				Position = UDim2.new(0, 0, 1, 0)
			},
			
			Label:Create {
				Name = "GamepadControls",
				Text = "Sprint: <b>RT</b><br />Crawl: <font color='#40CCD0'><b>X</b></font><br />Flashlight: <b>>L</b>",
				Size = UDim2.new(0.15, 0, 0.3, 0),
				Position = UDim2.new(0, 0, 1, 0)
			}
		}
	}
end

return Creator