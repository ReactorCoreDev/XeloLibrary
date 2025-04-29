local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local XeloLibrary = {}
local Tabs = {}

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XeloClientUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner", MainFrame)
FrameCorner.CornerRadius = UDim.new(0, 10)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local HeaderImage = Instance.new("ImageLabel")
HeaderImage.Size = UDim2.new(0, 60, 0, 60)
HeaderImage.Position = UDim2.new(0, 10, 0.5, -30)
HeaderImage.BackgroundTransparency = 1
HeaderImage.Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60)
HeaderImage.Parent = Header

local HeaderText = Instance.new("TextLabel")
HeaderText.Size = UDim2.new(1, -80, 0, 60)
HeaderText.Position = UDim2.new(0, 80, 0.5, -30)
HeaderText.BackgroundTransparency = 1
HeaderText.Font = Enum.Font.GothamBold
HeaderText.TextSize = 22
HeaderText.RichText = true
HeaderText.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderText.TextXAlignment = Enum.TextXAlignment.Left
HeaderText.Text = string.format(
	"<font color='rgb(0,255,255)'><b>%s</b></font> (<font color='rgb(100,255,255)'>%s</font>) ~ <font color='rgb(50,200,255)'>Xelo Library</font>",
	Player.Name,
	Player.DisplayName
)
HeaderText.Parent = Header

-- Tab Buttons Frame
local TabButtons = Instance.new("Frame")
TabButtons.Size = UDim2.new(1, 0, 0, 40)
TabButtons.Position = UDim2.new(0, 0, 0, 70)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = MainFrame

local TabList = Instance.new("UIListLayout", TabButtons)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 6)

-- Content Container
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -20, 1, -120)
ContentContainer.Position = UDim2.new(0, 10, 0, 120)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ClipsDescendants = true
ContentContainer.Parent = MainFrame

function XeloLibrary:CreateTab(TabName, ProfileImageId)
	local Tab = {}
	local TabFrame = Instance.new("Frame")
	TabFrame.Name = TabName
	TabFrame.Size = UDim2.new(1, 0, 1, 0)
	TabFrame.BackgroundTransparency = 1
	TabFrame.Visible = false
	TabFrame.Parent = ContentContainer

	local Layout = Instance.new("UIListLayout", TabFrame)
	Layout.SortOrder = Enum.SortOrder.LayoutOrder
	Layout.Padding = UDim.new(0, 10)

	local Padding = Instance.new("UIPadding", TabFrame)
	Padding.PaddingTop = UDim.new(0, 10)

	local Button = Instance.new("TextButton")
	Button.Name = TabName .. "Tab"
	Button.Text = TabName
	Button.Size = UDim2.new(0, 120, 0, 36)
	Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.Font = Enum.Font.Gotham
	Button.TextSize = 18
	Button.AutoButtonColor = false
	Button.Parent = TabButtons

	local Corner = Instance.new("UICorner", Button)
	Corner.CornerRadius = UDim.new(0, 6)

	local ImageIcon
	if ProfileImageId ~= 0 then
		ImageIcon = Instance.new("ImageLabel")
		ImageIcon.Size = UDim2.new(0, 24, 0, 24)
		ImageIcon.Position = UDim2.new(0, 5, 0.5, -12)
		ImageIcon.Image = "rbxthumb://type=Asset&id=" .. tostring(ProfileImageId) .. "&w=150&h=150"
		ImageIcon.BackgroundTransparency = 1
		ImageIcon.Parent = Button
	end

	Button.MouseButton1Click:Connect(function()
		for _, TabInfo in pairs(Tabs) do
			TabInfo.Frame.Visible = false
			TabInfo.Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		end
		TabFrame.Visible = true
		Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	end)

	if #Tabs == 0 then
		TabFrame.Visible = true
		Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	end

	Tab.Frame = TabFrame
	Tab.Button = Button
	table.insert(Tabs, Tab)

	-- Components
	function Tab:CreateButton(Config)
		local Btn = Instance.new("TextButton")
		Btn.Size = UDim2.new(1, -20, 0, 40)
		Btn.Text = Config.Name or "Button"
		Btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
		Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		Btn.Font = Enum.Font.GothamSemibold
		Btn.TextSize = 20
		Btn.AutoButtonColor = false
		Btn.Parent = TabFrame

		local BtnCorner = Instance.new("UICorner", Btn)
		BtnCorner.CornerRadius = UDim.new(0, 6)

		Btn.MouseEnter:Connect(function()
			TweenService:Create(Btn, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(75, 75, 75) }):Play()
		end)

		Btn.MouseLeave:Connect(function()
			TweenService:Create(Btn, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(55, 55, 55) }):Play()
		end)

		Btn.MouseButton1Click:Connect(function()
			TweenService:Create(Btn, TweenInfo.new(0.1), { Size = UDim2.new(1, -30, 0, 36) }):Play()
			task.wait(0.1)
			TweenService:Create(Btn, TweenInfo.new(0.1), { Size = UDim2.new(1, -20, 0, 40) }):Play()
			if Config.Callback then
				task.defer(Config.Callback)
			end
		end)
	end

	-- TODO: Add CreateToggle, CreateSlider, CreateDropdown, etc.

	return Tab
end

return XeloLibrary
