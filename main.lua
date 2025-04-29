local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local XeloLibrary = {}
local Gui = Instance.new("ScreenGui")
Gui.Name = "XeloLibraryUI"
Gui.ResetOnSpawn = false
Gui.Parent = game:GetService("CoreGui")

local DraggableFrame = Instance.new("Frame")
DraggableFrame.Size = UDim2.new(0, 300, 0, 200)
DraggableFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
DraggableFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DraggableFrame.BorderSizePixel = 0
DraggableFrame.Parent = Gui
DraggableFrame.AnchorPoint = Vector2.new(0.5, 0.5)
DraggableFrame.Active = true
DraggableFrame.Draggable = true
DraggableFrame.Name = "XeloMainFrame"
DraggableFrame.ClipsDescendants = true
DraggableFrame.BackgroundTransparency = 0.1
DraggableFrame.AutomaticSize = Enum.AutomaticSize.Y

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = DraggableFrame

function XeloLibrary:CreateButton(Data)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -20, 0, 30)
    Button.Position = UDim2.new(0, 10, 0, 0)
    Button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 16
    Button.Text = Data.Name or "Button"
    Button.Font = Enum.Font.Gotham
    Button.Parent = DraggableFrame
    Button.BorderSizePixel = 0

    local HoverTween = TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)})
    local UnhoverTween = TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)})

    Button.MouseEnter:Connect(function()
        HoverTween:Play()
    end)
    Button.MouseLeave:Connect(function()
        UnhoverTween:Play()
    end)

    Button.MouseButton1Down:Connect(function()
        local PressTween = TweenService:Create(Button, TweenInfo.new(0.05), {Size = UDim2.new(1, -20, 0, 28)})
        PressTween:Play()
    end)
    Button.MouseButton1Up:Connect(function()
        local ReleaseTween = TweenService:Create(Button, TweenInfo.new(0.05), {Size = UDim2.new(1, -20, 0, 30)})
        ReleaseTween:Play()
        if Data.Callback then
            Data.Callback()
        end
    end)
end

function XeloLibrary:CreateToggle(Data)
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 20, 0, 20)
    Toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Toggle.Text = ""
    Toggle.BorderSizePixel = 0
    Toggle.Parent = DraggableFrame

    local State = false

    local function UpdateColor()
        local Color = State and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
        TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color}):Play()
    end

    Toggle.MouseButton1Click:Connect(function()
        if not Toggle:GetAttribute("Cooldown") then
            Toggle:SetAttribute("Cooldown", true)
            State = not State
            UpdateColor()
            if Data.Callback then
                Data.Callback(State)
            end
            task.wait(0.2)
            Toggle:SetAttribute("Cooldown", false)
        end
    end)

    UpdateColor()
end

return XeloLibrary
