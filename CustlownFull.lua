local Custlown = {
    Version = "1.0",
    Flags = {},
    Themes = {},
    CurrentTheme = nil,
    IsVisible = true,
    IsMinimized = false
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local gethui = gethui or (syn and syn.protect_gui) or nil

Custlown.Themes = {
    Obsidian = {
        TextColor = Color3.fromRGB(235, 235, 235),
        Background = Color3.fromRGB(8, 8, 12),
        Topbar = Color3.fromRGB(14, 14, 20),
        Accent = Color3.fromRGB(180, 60, 60),
        ElementBg = Color3.fromRGB(20, 20, 26),
        ElementBgHover = Color3.fromRGB(30, 22, 22),
        Stroke = Color3.fromRGB(50, 50, 60),
        SliderBg = Color3.fromRGB(38, 38, 48),
        SliderFill = Color3.fromRGB(180, 60, 60),
        ToggleBg = Color3.fromRGB(33, 33, 43),
        ToggleActive = Color3.fromRGB(180, 60, 60),
        DropdownSelected = Color3.fromRGB(28, 28, 36),
        DropdownUnselected = Color3.fromRGB(22, 22, 30),
        InputBg = Color3.fromRGB(26, 26, 34),
        PlaceholderColor = Color3.fromRGB(140, 140, 150)
    },
    Graphite = {
        TextColor = Color3.fromRGB(240, 240, 240),
        Background = Color3.fromRGB(18, 18, 22),
        Topbar = Color3.fromRGB(26, 26, 32),
        Accent = Color3.fromRGB(110, 110, 130),
        ElementBg = Color3.fromRGB(30, 30, 36),
        ElementBgHover = Color3.fromRGB(38, 38, 44),
        Stroke = Color3.fromRGB(55, 55, 65),
        SliderBg = Color3.fromRGB(48, 48, 58),
        SliderFill = Color3.fromRGB(110, 110, 130),
        ToggleBg = Color3.fromRGB(40, 40, 48),
        ToggleActive = Color3.fromRGB(110, 110, 130),
        DropdownSelected = Color3.fromRGB(35, 35, 42),
        DropdownUnselected = Color3.fromRGB(28, 28, 34),
        InputBg = Color3.fromRGB(32, 32, 38),
        PlaceholderColor = Color3.fromRGB(135, 135, 145)
    },
    Crimson = {
        TextColor = Color3.fromRGB(255, 240, 240),
        Background = Color3.fromRGB(20, 8, 8),
        Topbar = Color3.fromRGB(30, 12, 12),
        Accent = Color3.fromRGB(220, 50, 50),
        ElementBg = Color3.fromRGB(35, 15, 15),
        ElementBgHover = Color3.fromRGB(45, 20, 20),
        Stroke = Color3.fromRGB(65, 30, 30),
        SliderBg = Color3.fromRGB(50, 22, 22),
        SliderFill = Color3.fromRGB(220, 50, 50),
        ToggleBg = Color3.fromRGB(45, 18, 18),
        ToggleActive = Color3.fromRGB(220, 50, 50),
        DropdownSelected = Color3.fromRGB(40, 18, 18),
        DropdownUnselected = Color3.fromRGB(32, 14, 14),
        InputBg = Color3.fromRGB(38, 16, 16),
        PlaceholderColor = Color3.fromRGB(160, 100, 100)
    }
}
Custlown.CurrentTheme = Custlown.Themes.Obsidian

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Custlown"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = gethui and gethui() or CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 700, 0, 550)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -275)
MainFrame.BackgroundColor3 = Custlown.CurrentTheme.Background
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Custlown.CurrentTheme.Accent
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Custlown.CurrentTheme.Topbar
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 14)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.4, 0, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Custlown"
Title.TextColor3 = Custlown.CurrentTheme.TextColor
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
MinimizeBtn.Position = UDim2.new(1, -95, 0.5, -20)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "─"
MinimizeBtn.TextColor3 = Custlown.CurrentTheme.TextColor
MinimizeBtn.TextSize = 22
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0.5, -20)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Custlown.CurrentTheme.TextColor
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TopBar

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 160, 1, -45)
TabBar.Position = UDim2.new(0, 0, 0, 45)
TabBar.BackgroundColor3 = Custlown.CurrentTheme.Background
TabBar.BackgroundTransparency = 0.4
TabBar.BorderSizePixel = 1
TabBar.BorderColor3 = Custlown.CurrentTheme.Stroke
TabBar.Parent = MainFrame

local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Size = UDim2.new(1, -12, 1, -12)
TabContainer.Position = UDim2.new(0, 6, 0, 6)
TabContainer.BackgroundTransparency = 1
TabContainer.BorderSizePixel = 0
TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
TabContainer.ScrollBarThickness = 4
TabContainer.ScrollBarImageColor3 = Custlown.CurrentTheme.Accent
TabContainer.Parent = TabBar

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 8)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabContainer

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -175, 1, -60)
ContentFrame.Position = UDim2.new(0, 170, 0, 55)
ContentFrame.BackgroundColor3 = Custlown.CurrentTheme.ElementBg
ContentFrame.BackgroundTransparency = 0.15
ContentFrame.BorderSizePixel = 1
ContentFrame.BorderColor3 = Custlown.CurrentTheme.Stroke
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 12)
ContentCorner.Parent = ContentFrame

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -16, 1, -16)
ScrollFrame.Position = UDim2.new(0, 8, 0, 8)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Custlown.CurrentTheme.Accent
ScrollFrame.ElasticBehavior = Enum.ElasticBehavior.Never
ScrollFrame.Parent = ContentFrame

local ScrollLayout = Instance.new("UIListLayout")
ScrollLayout.Padding = UDim.new(0, 10)
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScrollLayout.Parent = ScrollFrame

local ScrollPadding = Instance.new("UIPadding")
ScrollPadding.PaddingTop = UDim.new(0, 10)
ScrollPadding.PaddingBottom = UDim.new(0, 10)
ScrollPadding.PaddingLeft = UDim.new(0, 8)
ScrollPadding.PaddingRight = UDim.new(0, 8)
ScrollPadding.Parent = ScrollFrame

local Tabs = {}

local function updateCanvasSize()
    task.wait()
    local height = ScrollLayout.AbsoluteContentSize.Y
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, height + 30)
end
ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)

function Custlown:CreateTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -12, 0, 42)
    btn.BackgroundColor3 = Custlown.CurrentTheme.ElementBg
    btn.BackgroundTransparency = 0.5
    btn.Text = name
    btn.TextColor3 = Custlown.CurrentTheme.TextColor
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.Parent = TabContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.Visible = #Tabs == 0
    content.Parent = ScrollFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Parent = content
    
    btn.MouseButton1Click:Connect(function()
        for _, tab in pairs(Tabs) do
            tab.Content.Visible = false
            tab.Button.BackgroundTransparency = 0.5
            tab.Button.TextColor3 = Custlown.CurrentTheme.TextColor
        end
        content.Visible = true
        btn.BackgroundTransparency = 0.1
        btn.TextColor3 = Custlown.CurrentTheme.Accent
        updateCanvasSize()
    end)
    
    local tab = {Name = name, Button = btn, Content = content}
    table.insert(Tabs, tab)
    updateCanvasSize()
    return content
end

function Custlown:CreateSection(parent, title)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 35)
    section.BackgroundTransparency = 1
    section.Parent = parent
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 0, 28)
    line.BackgroundColor3 = Custlown.CurrentTheme.Accent
    line.BackgroundTransparency = 0.4
    line.BorderSizePixel = 0
    line.Parent = section
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 25)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = Custlown.CurrentTheme.Accent
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = section
    
    return section
end

function Custlown:CreateButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 42)
    btn.BackgroundColor3 = Custlown.CurrentTheme.ElementBg
    btn.BackgroundTransparency = 0.5
    btn.Text = text
    btn.TextColor3 = Custlown.CurrentTheme.TextColor
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
    end)
    
    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.7}):Play()
        if callback then callback()
        task.wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
    end)
    
    return btn
end

function Custlown:CreateToggle(parent, text, defaultValue, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 48)
    frame.BackgroundColor3 = Custlown.CurrentTheme.ElementBg
    frame.BackgroundTransparency = 0.5
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Custlown.CurrentTheme.TextColor
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 60, 0, 30)
    toggleBtn.Position = UDim2.new(1, -75, 0.5, -15)
    toggleBtn.BackgroundColor3 = defaultValue and Custlown.CurrentTheme.ToggleActive or Custlown.CurrentTheme.ToggleBg
    toggleBtn.Text = defaultValue and "ON" or "OFF"
    toggleBtn.TextColor3 = Custlown.CurrentTheme.TextColor
    toggleBtn.TextSize = 12
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Parent = frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleBtn
    
    local state = defaultValue
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = state and Custlown.CurrentTheme.ToggleActive or Custlown.CurrentTheme.ToggleBg}):Play()
        toggleBtn.Text = state and "ON" or "OFF"
        if callback then callback(state)
        if Custlown.Flags[text] then Custlown.Flags[text] = state end
    end)
    
    Custlown.Flags[text] = state
    return function() return state end
end

function Custlown:CreateSlider(parent, text, minVal, maxVal, defaultValue, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 80)
    frame.BackgroundColor3 = Custlown.CurrentTheme.ElementBg
    frame.BackgroundTransparency = 0.5
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 0, 25)
    label.Position = UDim2.new(0, 15, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Custlown.CurrentTheme.TextColor
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.3, 0, 0, 25)
    valueLabel.Position = UDim2.new(0.7, 0, 0, 5)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultValue)
    valueLabel.TextColor3 = Custlown.CurrentTheme.Accent
    valueLabel.TextSize = 13
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = frame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0.9, 0, 0, 4)
    sliderBg.Position = UDim2.new(0, 15, 0, 60)
    sliderBg.BackgroundColor3 = Custlown.CurrentTheme.SliderBg
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = frame
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((defaultValue - minVal) / (maxVal - minVal), 0, 1, 0)
    sliderFill.BackgroundColor3 = Custlown.CurrentTheme.SliderFill
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new((defaultValue - minVal) / (maxVal - minVal), -8, 0.5, -8)
    knob.BackgroundColor3 = Custlown.CurrentTheme.SliderFill
    knob.BorderSizePixel = 0
    knob.Parent = sliderBg
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 8)
    knobCorner.Parent = knob
    
    local value = defaultValue
    local dragging = false
    
    local function updateSlider(newVal)
        value = math.clamp(newVal, minVal, maxVal)
        local percent = (value - minVal) / (maxVal - minVal)
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        knob.Position = UDim2.new(percent, -8, 0.5, -8)
        valueLabel.Text = string.format("%.0f", value)
        if callback then callback(value)
    end
    
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            local x = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            updateSlider(minVal + x * (maxVal - minVal))
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local x = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            updateSlider(minVal + x * (maxVal - minVal))
        end
    end)
    
    updateSlider(defaultValue)
    return function() return value end
end

function Custlown:CreateLabel(parent, text)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 34)
    frame.BackgroundColor3 = Custlown.CurrentTheme.ElementBg
    frame.BackgroundTransparency = 0.5
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Custlown.CurrentTheme.TextColor
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    return label
end

function Custlown:CreateInput(parent, text, placeholder, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 65)
    frame.BackgroundColor3 = Custlown.CurrentTheme.ElementBg
    frame.BackgroundTransparency = 0.5
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 15, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Custlown.CurrentTheme.TextColor
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.9, 0, 0, 30)
    input.Position = UDim2.new(0, 15, 0, 28)
    input.BackgroundColor3 = Custlown.CurrentTheme.InputBg
    input.PlaceholderText = placeholder
    input.Text = ""
    input.TextColor3 = Custlown.CurrentTheme.TextColor
    input.PlaceholderColor3 = Custlown.CurrentTheme.PlaceholderColor
    input.TextSize = 13
    input.Font = Enum.Font.Gotham
    input.Parent = frame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = input
    
    input.FocusLost:Connect(function()
        if callback then callback(input.Text) end
    end)
    
    return input
end

function Custlown:CreateDropdown(parent, text, options, defaultOption, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 48)
    frame.BackgroundColor3 = Custlown.CurrentTheme.ElementBg
    frame.BackgroundTransparency = 0.5
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Custlown.CurrentTheme.TextColor
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Size = UDim2.new(0.45, 0, 0, 32)
    dropdownBtn.Position = UDim2.new(0.5, 0, 0.5, -16)
    dropdownBtn.BackgroundColor3 = Custlown.CurrentTheme.InputBg
    dropdownBtn.Text = defaultOption
    dropdownBtn.TextColor3 = Custlown.CurrentTheme.TextColor
    dropdownBtn.TextSize = 12
    dropdownBtn.Font = Enum.Font.Gotham
    dropdownBtn.Parent = frame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = dropdownBtn
    
    local listVisible = false
    local listFrame = Instance.new("Frame")
    listFrame.Size = UDim2.new(0.45, 0, 0, 0)
    listFrame.Position = UDim2.new(0.5, 0, 0.5, 16)
    listFrame.BackgroundColor3 = Custlown.CurrentTheme.DropdownUnselected
    listFrame.BackgroundTransparency = 0.9
    listFrame.ClipsDescendants = true
    listFrame.Visible = false
    listFrame.Parent = frame
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 6)
    listCorner.Parent = listFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = listFrame
    
    local selectedOption = defaultOption
    
    for _, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 30)
        optBtn.BackgroundColor3 = Custlown.CurrentTheme.DropdownUnselected
        optBtn.Text = opt
        optBtn.TextColor3 = Custlown.CurrentTheme.TextColor
        optBtn.TextSize = 12
        optBtn.Font = Enum.Font.Gotham
        optBtn.Parent = listFrame
        
        optBtn.MouseButton1Click:Connect(function()
            selectedOption = opt
            dropdownBtn.Text = opt
            if callback then callback(opt)
            TweenService:Create(listFrame, TweenInfo.new(0.2), {Size = UDim2.new(0.45, 0, 0, 0)}):Play()
            task.wait(0.2)
            listFrame.Visible = false
            listVisible = false
        end)
    end
    
    dropdownBtn.MouseButton1Click:Connect(function()
        if listVisible then
            TweenService:Create(listFrame, TweenInfo.new(0.2), {Size = UDim2.new(0.45, 0, 0, 0)}):Play()
            task.wait(0.2)
            listFrame.Visible = false
        else
            listFrame.Visible = true
            local height = #options * 32
            TweenService:Create(listFrame, TweenInfo.new(0.2), {Size = UDim2.new(0.45, 0, 0, height)}):Play()
        end
        listVisible = not listVisible
    end)
    
    return function() return selectedOption end
end

local NotifContainer = Instance.new("Frame")
NotifContainer.Name = "NotifContainer"
NotifContainer.Size = UDim2.new(0, 400, 0, 0)
NotifContainer.Position = UDim2.new(0.5, -200, 0, 12)
NotifContainer.BackgroundTransparency = 1
NotifContainer.Parent = ScreenGui

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.Padding = UDim.new(0, 8)
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Top
NotifLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
NotifLayout.Parent = NotifContainer

function Custlown:Notify(title, content, duration)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 380, 0, 0)
    notif.BackgroundColor3 = Custlown.CurrentTheme.Background
    notif.BackgroundTransparency = 0.15
    notif.BorderSizePixel = 1
    notif.BorderColor3 = Custlown.CurrentTheme.Accent
    notif.ClipsDescendants = true
    notif.Parent = NotifContainer
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 12)
    notifCorner.Parent = notif
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 22)
    titleLabel.Position = UDim2.new(0, 15, 0, 8)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Custlown.CurrentTheme.Accent
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notif
    
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Size = UDim2.new(1, -20, 0, 0)
    contentLabel.Position = UDim2.new(0, 15, 0, 32)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = content
    contentLabel.TextColor3 = Custlown.CurrentTheme.TextColor
    contentLabel.TextSize = 12
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextWrapped = true
    contentLabel.Parent = notif
    
    task.wait()
    local textHeight = contentLabel.TextBounds.Y
    local totalHeight = math.max(55, textHeight + 45)
    
    TweenService:Create(notif, TweenInfo.new(0.3), {Size = UDim2.new(0, 380, 0, totalHeight)}):Play()
    TweenService:Create(contentLabel, TweenInfo.new(0.2), {Size = UDim2.new(1, -20, 0, textHeight + 5)}):Play()
    
    task.wait(duration or 3)
    
    TweenService:Create(notif, TweenInfo.new(0.3), {Size = UDim2.new(0, 380, 0, 0)}):Play()
    task.wait(0.3)
    notif:Destroy()
end

local dragging = false
local dragStart, frameStart
local minimized = false
local visible = true

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        frameStart = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 700, 0, 45)}):Play()
        TabBar.Visible = false
        ContentFrame.Visible = false
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 700, 0, 550)}):Play()
        TabBar.Visible = true
        ContentFrame.Visible = true
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    visible = not visible
    MainFrame.Visible = visible
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
        visible = not visible
        MainFrame.Visible = visible
    end
end)

function Custlown:CreateWindow(config)
    MainFrame.Size = UDim2.new(0, config.Width or 700, 0, config.Height or 550)
    MainFrame.Position = UDim2.new(0.5, -(config.Width or 700)/2, 0.5, -(config.Height or 550)/2)
    Title.Text = config.Name or "Custlown"
    MainFrame.Visible = true
    
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, config.Width or 700, 0, config.Height or 550)}):Play()
    
    return {
        CreateTab = Custlown.CreateTab,
        CreateSection = Custlown.CreateSection,
        CreateButton = Custlown.CreateButton,
        CreateToggle = Custlown.CreateToggle,
        CreateSlider = Custlown.CreateSlider,
        CreateLabel = Custlown.CreateLabel,
        CreateInput = Custlown.CreateInput,
        CreateDropdown = Custlown.CreateDropdown,
        Notify = Custlown.Notify
    }
end

function Custlown:SetTheme(themeName)
    if type(themeName) == "string" and Custlown.Themes[themeName] then
        Custlown.CurrentTheme = Custlown.Themes[themeName]
    elseif type(themeName) == "table" then
        Custlown.CurrentTheme = themeName
    else return false end
    
    MainFrame.BackgroundColor3 = Custlown.CurrentTheme.Background
    MainFrame.BorderColor3 = Custlown.CurrentTheme.Accent
    TopBar.BackgroundColor3 = Custlown.CurrentTheme.Topbar
    Title.TextColor3 = Custlown.CurrentTheme.TextColor
    MinimizeBtn.TextColor3 = Custlown.CurrentTheme.TextColor
    CloseBtn.TextColor3 = Custlown.CurrentTheme.TextColor
    TabBar.BackgroundColor3 = Custlown.CurrentTheme.Background
    TabBar.BorderColor3 = Custlown.CurrentTheme.Stroke
    ContentFrame.BackgroundColor3 = Custlown.CurrentTheme.ElementBg
    ContentFrame.BorderColor3 = Custlown.CurrentTheme.Stroke
    ScrollFrame.ScrollBarImageColor3 = Custlown.CurrentTheme.Accent
    TabContainer.ScrollBarImageColor3 = Custlown.CurrentTheme.Accent
    
    for _, tab in pairs(Tabs) do
        tab.Button.BackgroundColor3 = Custlown.CurrentTheme.ElementBg
        tab.Button.TextColor3 = Custlown.CurrentTheme.TextColor
    end
    
    return true
end

MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.BackgroundTransparency = 1
TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 700, 0, 550),
    BackgroundTransparency = 0
}):Play()

return Custlown
