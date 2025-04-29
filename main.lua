--// XeloLibrary.lua
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local XeloLibrary = {}

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XeloClientUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Create Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 240)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 8)
FrameCorner.Parent = MainFrame

-- Container to place items vertically
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = MainFrame

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 12)
Padding.Parent = MainFrame

-- Create Toggle Function
function XeloLibrary:CreateToggle(Config)
	local Toggle = Instance.new("TextButton")
	Toggle.Name = Config.Name or "Toggle"
	Toggle.Size = UDim2.new(0, 260, 0, 40)
	Toggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
	Toggle.Text = "OFF"
	Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.Font = Enum.Font.GothamSemibold
	Toggle.TextSize = 20
	Toggle.AutoButtonColor = false
	Toggle.Parent = MainFrame

	local Corner = Instance.new("UICorner", Toggle)
	Corner.CornerRadius = UDim.new(0, 6)

	local ToggleState = false
	local LastToggle = 0

	Toggle.MouseEnter:Connect(function()
		TweenService:Create(Toggle, TweenInfo.new(0.1), {
			BackgroundColor3 = ToggleState and Color3.fromRGB(0, 170, 0):Lerp(Color3.fromRGB(180, 180, 180), 0.15)
				or Color3.fromRGB(180, 0, 0):Lerp(Color3.fromRGB(180, 180, 180), 0.15)
		}):Play()
	end)

	Toggle.MouseLeave:Connect(function()
		TweenService:Create(Toggle, TweenInfo.new(0.1), {
			BackgroundColor3 = ToggleState and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(180, 0, 0)
		}):Play()
	end)

	Toggle.MouseButton1Click:Connect(function()
		if tick() - LastToggle < 0.2 then return end
		LastToggle = tick()

		TweenService:Create(Toggle, TweenInfo.new(0.1), {
			Size = UDim2.new(0, 250, 0, 36)
		}):Play()
		task.wait(0.1)
		TweenService:Create(Toggle, TweenInfo.new(0.1), {
			Size = UDim2.new(0, 260, 0, 40)
		}):Play()

		ToggleState = not ToggleState

		TweenService:Create(Toggle, TweenInfo.new(0.2), {
			BackgroundColor3 = ToggleState and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(180, 0, 0)
		}):Play()

		Toggle.Text = ToggleState and "ON" or "OFF"
		if Config.Callback then
			task.defer(Config.Callback, ToggleState)
		end
	end)
end

-- Create Button Function (no toggle)
function XeloLibrary:CreateButton(Config)
	local Button = Instance.new("TextButton")
	Button.Name = Config.Name or "Button"
	Button.Size = UDim2.new(0, 260, 0, 40)
	Button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	Button.Text = Config.Name or "Button"
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.Font = Enum.Font.GothamSemibold
	Button.TextSize = 20
	Button.AutoButtonColor = false
	Button.Parent = MainFrame

	local Corner = Instance.new("UICorner", Button)
	Corner.CornerRadius = UDim.new(0, 6)

	Button.MouseEnter:Connect(function()
		TweenService:Create(Button, TweenInfo.new(0.1), {
			BackgroundColor3 = Color3.fromRGB(75, 75, 75)
		}):Play()
	end)

	Button.MouseLeave:Connect(function()
		TweenService:Create(Button, TweenInfo.new(0.1), {
			BackgroundColor3 = Color3.fromRGB(55, 55, 55)
		}):Play()
	end)

	Button.MouseButton1Click:Connect(function()
		TweenService:Create(Button, TweenInfo.new(0.1), {
			Size = UDim2.new(0, 250, 0, 36)
		}):Play()
		task.wait(0.1)
		TweenService:Create(Button, TweenInfo.new(0.1), {
			Size = UDim2.new(0, 260, 0, 40)
		}):Play()

		if Config.Callback then
			task.defer(Config.Callback)
		end
	end)
end

return XeloLibrary
