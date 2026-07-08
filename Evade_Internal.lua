local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local Debris = game:GetService("Debris")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local SkelHande = nil
local menuOpen = false
local WatermarkBack = nil
local MenuWrapper = nil
local MainMenu = nil
local VisualsBox = nil
local MiscBox = nil

local flyEnabled = false
local flySpeed = 30
local spinEnabled = false
local spinSpeed = 10
local spinMode = "Jitter"
local autoJumpEnabled = false
local anchorEnabled = false
local anchorParts = {}
local chamsEnabled = false
local chamsObjects = {}
local teleportEnabled = false
local teleportHeight = 5
local moveEmojiEnabled = false
local cframeSpeed = 16

local function CreateGUI()
	if SkelHande then
		pcall(function() SkelHande:Destroy() end)
		SkelHande = nil
	end
	
	SkelHande = Instance.new("ScreenGui")
	SkelHande.Name = "SkelHande"
	SkelHande.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	SkelHande.Parent = CoreGui
	SkelHande.IgnoreGuiInset = true
	SkelHande.ResetOnSpawn = false
	
	WatermarkBack = Instance.new("TextButton")
	WatermarkBack.Size = UDim2.new(0, 240, 0, 28)
	WatermarkBack.Position = UDim2.new(0, 10, 0, 70)
	WatermarkBack.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	WatermarkBack.BackgroundTransparency = 0
	WatermarkBack.BorderSizePixel = 0
	WatermarkBack.ZIndex = 999
	WatermarkBack.Text = ""
	WatermarkBack.Parent = SkelHande
	
	local WatermarkCorner = Instance.new("UICorner")
	WatermarkCorner.CornerRadius = UDim.new(0, 3)
	WatermarkCorner.Parent = WatermarkBack
	
	local WatermarkText = Instance.new("TextLabel")
	WatermarkText.Size = UDim2.new(1, 0, 1, 0)
	WatermarkText.BackgroundTransparency = 1
	WatermarkText.Text = "PXE | EVADE INTERNAL"
	WatermarkText.TextColor3 = Color3.fromRGB(255, 255, 255)
	WatermarkText.TextSize = 13
	WatermarkText.Font = Enum.Font.SourceSansBold
	WatermarkText.Parent = WatermarkBack
	
	local WatermarkLine = Instance.new("Frame")
	WatermarkLine.Size = UDim2.new(1, 0, 0, 2)
	WatermarkLine.Position = UDim2.new(0, 0, 1, 0)
	WatermarkLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	WatermarkLine.BorderSizePixel = 0
	WatermarkLine.ZIndex = 999
	WatermarkLine.Parent = WatermarkBack
	
	local LineGradient = Instance.new("UIGradient")
	LineGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 70, 70)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	})
	LineGradient.Parent = WatermarkLine
	
	MenuWrapper = Instance.new("Frame")
	MenuWrapper.Size = UDim2.new(0, 673, 0, 530)
	MenuWrapper.Position = UDim2.new(0.5, 0, 0.5, 0)
	MenuWrapper.AnchorPoint = Vector2.new(0.5, 0.5)
	MenuWrapper.BackgroundTransparency = 1
	MenuWrapper.BorderSizePixel = 0
	MenuWrapper.ZIndex = 1
	MenuWrapper.Parent = SkelHande
	MenuWrapper.Visible = false
	
	MainMenu = Instance.new("Frame")
	MainMenu.Size = UDim2.new(1, 0, 1, 0)
	MainMenu.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	MainMenu.BackgroundTransparency = 0
	MainMenu.BorderSizePixel = 0
	MainMenu.Active = true
	MainMenu.Parent = MenuWrapper
	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 3)
	MainCorner.Parent = MainMenu
	
	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.new(0, 32, 0, 32)
	CloseBtn.Position = UDim2.new(1, -12, 0, 12)
	CloseBtn.AnchorPoint = Vector2.new(1, 0)
	CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	CloseBtn.BackgroundTransparency = 0
	CloseBtn.Text = "✕"
	CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
	CloseBtn.TextSize = 18
	CloseBtn.Font = Enum.Font.SourceSansBold
	CloseBtn.BorderSizePixel = 0
	CloseBtn.Parent = MainMenu
	local CloseCorner = Instance.new("UICorner")
	CloseCorner.CornerRadius = UDim.new(0, 6)
	CloseCorner.Parent = CloseBtn
	
	CloseBtn.MouseButton1Click:Connect(function()
		menuOpen = false
		local tween = TweenService:Create(MenuWrapper, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1})
		tween:Play()
		task.wait(0.3)
		MenuWrapper.Visible = false
	end)
	
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
			menuOpen = not menuOpen
			if menuOpen then
				MenuWrapper.Visible = true
				MenuWrapper.BackgroundTransparency = 1
				local tween = TweenService:Create(MenuWrapper, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
				tween:Play()
			else
				local tween = TweenService:Create(MenuWrapper, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1})
				tween:Play()
				task.wait(0.3)
				MenuWrapper.Visible = false
			end
		end
	end)
	
	WatermarkBack.MouseButton1Click:Connect(function()
		menuOpen = not menuOpen
		if menuOpen then
			MenuWrapper.Visible = true
			MenuWrapper.BackgroundTransparency = 1
			local tween = TweenService:Create(MenuWrapper, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
			tween:Play()
		else
			local tween = TweenService:Create(MenuWrapper, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1})
			tween:Play()
			task.wait(0.3)
			MenuWrapper.Visible = false
		end
	end)
	
	local watermarkDragging = false
	local watermarkDragStart = nil
	local watermarkStartPos = nil
	
	WatermarkBack.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			watermarkDragging = true
			watermarkDragStart = input.Position
			watermarkStartPos = WatermarkBack.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					watermarkDragging = false
				end
			end)
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if watermarkDragging and input.UserInputType == Enum.UserInputType.Touch then
			local delta = input.Position - watermarkDragStart
			WatermarkBack.Position = UDim2.new(watermarkStartPos.X.Scale, watermarkStartPos.X.Offset + delta.X, watermarkStartPos.Y.Scale, watermarkStartPos.Y.Offset + delta.Y)
		end
	end)
	
	local dragging = false
	local dragInput = nil
	local dragStart = nil
	local startPos = nil
	local isDraggingSlider = false
	
	MenuWrapper.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch and not isDraggingSlider then
			dragging = true
			dragStart = input.Position
			startPos = MenuWrapper.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	MenuWrapper.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			MenuWrapper.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	
	MenuWrapper.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not isDraggingSlider then
			dragging = true
			dragStart = input.Position
			startPos = MenuWrapper.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	MenuWrapper.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			MenuWrapper.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	
	local HeaderBack = Instance.new("Frame")
	HeaderBack.Size = UDim2.new(1, 0, 0, 113)
	HeaderBack.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	HeaderBack.BorderSizePixel = 0
	HeaderBack.Parent = MainMenu
	local HeaderCorner = Instance.new("UICorner")
	HeaderCorner.Parent = HeaderBack
	
	local HeaderImage = Instance.new("ImageLabel")
	HeaderImage.Size = UDim2.new(0, 622, 0, 90)
	HeaderImage.Position = UDim2.new(0.5, 0, 0.5, 0)
	HeaderImage.AnchorPoint = Vector2.new(0.5, 0.5)
	HeaderImage.BackgroundTransparency = 1
	HeaderImage.Image = "rbxassetid://136374414403651"
	HeaderImage.Parent = HeaderBack
	
	local HeaderGradientLine = Instance.new("Frame")
	HeaderGradientLine.Size = UDim2.new(1, -40, 0, 3)
	HeaderGradientLine.Position = UDim2.new(0.5, 0, 1, 1)
	HeaderGradientLine.AnchorPoint = Vector2.new(0.5, 0)
	HeaderGradientLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HeaderGradientLine.BorderSizePixel = 0
	HeaderGradientLine.Parent = HeaderBack
	
	local HeaderGradient = Instance.new("UIGradient")
	HeaderGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 70, 70)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	})
	HeaderGradient.Parent = HeaderGradientLine
	
	local function PlayToggleSound()
		local s = Instance.new("Sound")
		s.SoundId = "rbxassetid://9120100756"
		s.Volume = 0.5
		s.Parent = SkelHande
		s:Play()
		Debris:AddItem(s, 2)
	end
	
	local function CreateToggle(parent, text, callback)
		local ToggleContainer = Instance.new("Frame")
		ToggleContainer.Size = UDim2.new(1, -10, 0, 35)
		ToggleContainer.BackgroundTransparency = 1
		ToggleContainer.Parent = parent

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(0, 200, 1, 0)
		Label.Position = UDim2.new(0, 10, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(255, 255, 255)
		Label.TextSize = 14
		Label.Font = Enum.Font.SourceSans
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = ToggleContainer

		local ToggleBtn = Instance.new("TextButton")
		ToggleBtn.Size = UDim2.new(0, 22, 0, 22)
		ToggleBtn.Position = UDim2.new(1, -25, 0.5, -11)
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		ToggleBtn.Text = ""
		ToggleBtn.Parent = ToggleContainer
		local BtnCorner = Instance.new("UICorner")
		BtnCorner.CornerRadius = UDim.new(0, 4)
		BtnCorner.Parent = ToggleBtn

		local Checkmark = Instance.new("ImageLabel")
		Checkmark.Size = UDim2.new(1, 0, 1, 0)
		Checkmark.BackgroundTransparency = 1
		Checkmark.Image = "rbxassetid://6031094667"
		Checkmark.ImageColor3 = Color3.fromRGB(0, 0, 0)
		Checkmark.Visible = false
		Checkmark.Parent = ToggleBtn

		local isEnabled = false
		local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		ToggleBtn.MouseButton1Click:Connect(function()
			isEnabled = not isEnabled
			local targetColor = isEnabled and Color3.fromRGB(255, 70, 70) or Color3.fromRGB(25, 25, 25)
			local tween = TweenService:Create(ToggleBtn, tweenInfo, {BackgroundColor3 = targetColor})
			tween:Play()
			PlayToggleSound()
			if isEnabled then
				task.wait(0.15)
				Checkmark.Visible = true
			else
				Checkmark.Visible = false
			end
			if callback then callback(isEnabled) end
		end)
		return ToggleContainer
	end

	local function CreateSlider(parent, text, min, max, default, callback)
		local Container = Instance.new("Frame")
		Container.Size = UDim2.new(1, -10, 0, 45)
		Container.BackgroundTransparency = 1
		Container.Parent = parent

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(0, 150, 0, 20)
		Label.Position = UDim2.new(0, 10, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 200)
		Label.TextSize = 13
		Label.Font = Enum.Font.SourceSans
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = Container

		local Bar = Instance.new("Frame")
		Bar.Size = UDim2.new(0, 150, 0, 8)
		Bar.Position = UDim2.new(0, 10, 0, 25)
		Bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Bar.BorderSizePixel = 0
		Bar.Parent = Container

		local BarCorner = Instance.new("UICorner")
		BarCorner.CornerRadius = UDim.new(0, 4)
		BarCorner.Parent = Bar

		local Fill = Instance.new("Frame")
		Fill.Size = UDim2.new(0, 0, 1, 0)
		Fill.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
		Fill.BorderSizePixel = 0
		Fill.Parent = Bar

		local FillCorner = Instance.new("UICorner")
		FillCorner.CornerRadius = UDim.new(0, 4)
		FillCorner.Parent = Fill

		local Value = Instance.new("TextLabel")
		Value.Size = UDim2.new(0, 40, 0, 20)
		Value.Position = UDim2.new(1, -45, 0, 0)
		Value.BackgroundTransparency = 1
		Value.Text = tostring(default)
		Value.TextColor3 = Color3.fromRGB(255, 255, 255)
		Value.TextSize = 13
		Value.Font = Enum.Font.SourceSansBold
		Value.TextXAlignment = Enum.TextXAlignment.Right
		Value.Parent = Container

		local dragging = false

		Bar.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				isDraggingSlider = true
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				local mouse = LocalPlayer:GetMouse()
				local barAbsPos, barSize = Bar.AbsolutePosition, Bar.AbsoluteSize
				local localX = mouse.X - barAbsPos.X
				local percent = math.clamp(localX / barSize.X, 0, 1)
				Fill.Size = UDim2.new(percent, 0, 1, 0)
				local val = math.round(min + (max - min) * percent)
				Value.Text = tostring(val)
				if callback then callback(val) end
				isDraggingSlider = true
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
				isDraggingSlider = false
			end
		end)

		return Container
	end

	local function CreateSection(title, xPos)
		local SectionGroup = Instance.new("Frame")
		SectionGroup.Size = UDim2.new(0, 308, 0, 365)
		SectionGroup.Position = UDim2.new(0, xPos, 0, 150)
		SectionGroup.BackgroundTransparency = 1
		SectionGroup.Parent = MainMenu

		local TitleBack = Instance.new("Frame")
		TitleBack.Size = UDim2.new(1, 0, 0, 40)
		TitleBack.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
		TitleBack.BorderSizePixel = 0
		TitleBack.Parent = SectionGroup
		local TitleCorner = Instance.new("UICorner")
		TitleCorner.CornerRadius = UDim.new(0, 6)
		TitleCorner.Parent = TitleBack

		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Size = UDim2.new(1, 0, 1, 0)
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Text = title
		TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TitleLabel.TextSize = 20
		TitleLabel.Font = Enum.Font.SourceSansBold
		TitleLabel.Parent = TitleBack

		local ContentBox = Instance.new("ScrollingFrame")
		ContentBox.Size = UDim2.new(1, 0, 1, -40)
		ContentBox.Position = UDim2.new(0, 0, 0, 40)
		ContentBox.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
		ContentBox.BorderSizePixel = 0
		ContentBox.ScrollBarThickness = 0
		ContentBox.ScrollBarImageColor3 = Color3.fromRGB(255, 70, 70)
		ContentBox.ScrollBarImageTransparency = 0.7
		ContentBox.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
		ContentBox.CanvasSize = UDim2.new(0, 0, 0, 800)
		ContentBox.Parent = SectionGroup
		local BoxCorner = Instance.new("UICorner")
		BoxCorner.Parent = ContentBox

		local Layout = Instance.new("UIListLayout")
		Layout.SortOrder = Enum.SortOrder.LayoutOrder
		Layout.Padding = UDim.new(0, 5)
		Layout.Parent = ContentBox

		Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			ContentBox.CanvasSize = UDim2.new(0, 0, 0, math.max(Layout.AbsoluteContentSize.Y, 400))
		end)

		return ContentBox
	end

	VisualsBox = CreateSection("VISUALS", 15)
	MiscBox = CreateSection("MISC", 340)

	local VisualsGradientLine = Instance.new("Frame")
	VisualsGradientLine.Size = UDim2.new(1, -20, 0, 2)
	VisualsGradientLine.Position = UDim2.new(0.5, 0, 1, -2)
	VisualsGradientLine.AnchorPoint = Vector2.new(0.5, 1)
	VisualsGradientLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	VisualsGradientLine.BorderSizePixel = 0
	VisualsGradientLine.Parent = VisualsBox.Parent

	local VisualsGradient = Instance.new("UIGradient")
	VisualsGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 70, 70)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	})
	VisualsGradient.Parent = VisualsGradientLine

	local MiscGradientLine = Instance.new("Frame")
	MiscGradientLine.Size = UDim2.new(1, -20, 0, 2)
	MiscGradientLine.Position = UDim2.new(0.5, 0, 1, -2)
	MiscGradientLine.AnchorPoint = Vector2.new(0.5, 1)
	MiscGradientLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MiscGradientLine.BorderSizePixel = 0
	MiscGradientLine.Parent = MiscBox.Parent

	local MiscGradient = Instance.new("UIGradient")
	MiscGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 70, 70)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	})
	MiscGradient.Parent = MiscGradientLine

	local function ApplyChams(part)
		if not part or not part:IsA("BasePart") then return end
		
		local alreadySaved = false
		for _, data in pairs(chamsObjects) do
			if data.part == part then
				alreadySaved = true
				break
			end
		end
		
		if not alreadySaved then
			table.insert(chamsObjects, {
				part = part,
				color = part.Color,
				material = part.Material,
				transparency = part.Transparency,
				reflection = part.Reflectance
			})
		end
		
		part.Material = Enum.Material.Neon
		part.Color = Color3.fromRGB(0, 255, 0)
		part.Transparency = 0.2
		part.Reflectance = 0
	end
	
	local function RestoreChams()
		for _, data in pairs(chamsObjects) do
			pcall(function()
				if data.part and data.part.Parent then
					data.part.Material = data.material
					data.part.Color = data.color
					data.part.Transparency = data.transparency
					data.part.Reflectance = data.reflection or 0
				end
			end)
		end
		chamsObjects = {}
	end
	
	local function UpdateAllChams()
		if not chamsEnabled then return end
		
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character then
				for _, part in pairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						ApplyChams(part)
					end
				end
			end
		end
	end
	
	CreateToggle(VisualsBox, "Chams for players (wallhack)", function(enabled)
		chamsEnabled = enabled
		
		if enabled then
			UpdateAllChams()
		else
			RestoreChams()
		end
	end)
	
	task.spawn(function()
		while task.wait(0.3) do
			if chamsEnabled then
				for _, player in pairs(Players:GetPlayers()) do
					if player ~= LocalPlayer and player.Character then
						for _, part in pairs(player.Character:GetDescendants()) do
							if part:IsA("BasePart") then

								local hasChams = false
								for _, data in pairs(chamsObjects) do
									if data.part == part then
										hasChams = true
										break
									end
								end
								if not hasChams then
									ApplyChams(part)
								end
							end
						end
					end
				end
			end
		end
	end)
	
	Players.PlayerAdded:Connect(function(player)
		task.wait(0.5)
		if chamsEnabled then
			player.CharacterAdded:Connect(function(char)
				task.wait(0.5)
				if chamsEnabled and char then
					for _, part in pairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							ApplyChams(part)
						end
					end
				end
			end)
		end
	end)

	CreateToggle(MiscBox, "Move when Emoji", function(enabled)
		moveEmojiEnabled = enabled
	end)
	
	CreateSlider(MiscBox, "CFrame Speed", 1, 500, 16, function(val)
		cframeSpeed = val
	end)
	
	local SpeedDesc = Instance.new("TextLabel")
	SpeedDesc.Size = UDim2.new(1, -20, 0, 25)
	SpeedDesc.Position = UDim2.new(0.5, 0, 0, 0)
	SpeedDesc.AnchorPoint = Vector2.new(0.5, 0)
	SpeedDesc.BackgroundTransparency = 1
	SpeedDesc.Text = "Works only when 'Move when Emoji' is ON"
	SpeedDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	SpeedDesc.TextSize = 11
	SpeedDesc.Font = Enum.Font.SourceSans
	SpeedDesc.TextXAlignment = Enum.TextXAlignment.Center
	SpeedDesc.Parent = MiscBox

	task.spawn(function()
		while task.wait(0.1) do
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				if moveEmojiEnabled then
					LocalPlayer.Character.Humanoid.WalkSpeed = cframeSpeed
				else
					LocalPlayer.Character.Humanoid.WalkSpeed = 16
				end
			end
		end
	end)

	CreateToggle(MiscBox, "CTRL + LMB Teleport (with rise)", function(enabled)
		teleportEnabled = enabled
	end)

	CreateSlider(MiscBox, "Teleport Rise Height", 1, 100, 5, function(val)
		teleportHeight = val
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		
		if teleportEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 then
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
				local mouse = LocalPlayer:GetMouse()
				local target = mouse.Hit
				
				if target and target.Position then
					local char = LocalPlayer.Character
					if char and char:FindFirstChild("HumanoidRootPart") then
						local root = char.HumanoidRootPart
						local targetPos = target.Position
						
						local raycastParams = RaycastParams.new()
						raycastParams.FilterDescendantsInstances = {char}
						raycastParams.FilterType = Enum.RaycastFilterType.Exclude
						
						local rayOrigin = targetPos + Vector3.new(0, 50, 0)
						local rayDirection = Vector3.new(0, -100, 0)
						
						local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
						
						local finalPos = targetPos
						
						if result then
							finalPos = result.Position + Vector3.new(0, teleportHeight, 0)
						else
							finalPos = targetPos + Vector3.new(0, teleportHeight, 0)
						end
						
						root.CFrame = CFrame.new(finalPos)
						
						local s = Instance.new("Sound")
						s.SoundId = "rbxassetid://9120100756"
						s.Volume = 0.3
						s.Parent = SkelHande
						s:Play()
						Debris:AddItem(s, 2)
					end
				end
			end
		end
	end)

	local SafePosContainer = Instance.new("Frame")
	SafePosContainer.Size = UDim2.new(1, -10, 0, 80)
	SafePosContainer.BackgroundTransparency = 1
	SafePosContainer.Parent = MiscBox
	local SafePosLabel = Instance.new("TextLabel")
	SafePosLabel.Size = UDim2.new(1, 0, 0, 20)
	SafePosLabel.BackgroundTransparency = 1
	SafePosLabel.Text = "Safe Positions"
	SafePosLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	SafePosLabel.TextSize = 11
	SafePosLabel.Font = Enum.Font.SourceSansBold
	SafePosLabel.TextXAlignment = Enum.TextXAlignment.Left
	SafePosLabel.Parent = SafePosContainer
	local SafePosBtn = Instance.new("TextButton")
	SafePosBtn.Size = UDim2.new(0, 80, 0, 30)
	SafePosBtn.Position = UDim2.new(0, 0, 0, 28)
	SafePosBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	SafePosBtn.Text = "Save"
	SafePosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	SafePosBtn.TextSize = 11
	SafePosBtn.Font = Enum.Font.SourceSans
	SafePosBtn.Parent = SafePosContainer
	local SafePosCorner = Instance.new("UICorner")
	SafePosCorner.CornerRadius = UDim.new(0, 6)
	SafePosCorner.Parent = SafePosBtn
	local TeleportBtn = Instance.new("TextButton")
	TeleportBtn.Size = UDim2.new(0, 80, 0, 30)
	TeleportBtn.Position = UDim2.new(0, 90, 0, 28)
	TeleportBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	TeleportBtn.Text = "Teleport"
	TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	TeleportBtn.TextSize = 11
	TeleportBtn.Font = Enum.Font.SourceSans
	TeleportBtn.Parent = SafePosContainer
	local TeleportCorner = Instance.new("UICorner")
	TeleportCorner.CornerRadius = UDim.new(0, 6)
	TeleportCorner.Parent = TeleportBtn

	local SavedPos = nil
	SafePosBtn.MouseButton1Click:Connect(function()
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			SavedPos = char.HumanoidRootPart.CFrame
			SafePosBtn.Text = "Saved!"
			SafePosBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			task.wait(2)
			SafePosBtn.Text = "Save"
			SafePosBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		end
	end)
	TeleportBtn.MouseButton1Click:Connect(function()
		if SavedPos then
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.CFrame = SavedPos
			end
		end
	end)

	CreateToggle(MiscBox, "No Clip", function(enabled)
		if enabled then
			if LocalPlayer.Character then
				for _, v in pairs(LocalPlayer.Character:GetChildren()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
			end
		else
			if LocalPlayer.Character then
				for _, v in pairs(LocalPlayer.Character:GetChildren()) do
					if v:IsA("BasePart") then
						v.CanCollide = true
					end
				end
			end
		end
	end)

	CreateToggle(MiscBox, "God Mode", function(enabled)
		_G.GodModeEnabled = enabled
	end)

	task.spawn(function()
		while task.wait() do
			if _G.GodModeEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
				LocalPlayer.Character.Humanoid.MaxHealth = 100000
			elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				LocalPlayer.Character.Humanoid.MaxHealth = 100
			end
		end
	end)

	CreateToggle(MiscBox, "Auto Jump", function(enabled)
		autoJumpEnabled = enabled
	end)

	task.spawn(function()
		while task.wait(0.05) do
			if autoJumpEnabled and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
					LocalPlayer.Character.Humanoid.Jump = true
				end
			end
		end
	end)

	local SpinModeContainer = Instance.new("Frame")
	SpinModeContainer.Size = UDim2.new(1, -10, 0, 30)
	SpinModeContainer.BackgroundTransparency = 1
	SpinModeContainer.Parent = MiscBox

	local SpinModeLabel = Instance.new("TextLabel")
	SpinModeLabel.Size = UDim2.new(0, 150, 1, 0)
	SpinModeLabel.BackgroundTransparency = 1
	SpinModeLabel.Text = "Spin Mode"
	SpinModeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	SpinModeLabel.TextSize = 12
	SpinModeLabel.Font = Enum.Font.SourceSans
	SpinModeLabel.TextXAlignment = Enum.TextXAlignment.Left
	SpinModeLabel.Parent = SpinModeContainer

	local SpinModeBtn = Instance.new("TextButton")
	SpinModeBtn.Size = UDim2.new(0, 80, 0, 22)
	SpinModeBtn.Position = UDim2.new(1, -90, 0.5, -11)
	SpinModeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	SpinModeBtn.Text = "Jitter"
	SpinModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	SpinModeBtn.TextSize = 11
	SpinModeBtn.Font = Enum.Font.SourceSans
	SpinModeBtn.Parent = SpinModeContainer
	local SpinModeCorner = Instance.new("UICorner")
	SpinModeCorner.CornerRadius = UDim.new(0, 4)
	SpinModeCorner.Parent = SpinModeBtn

	local spinModes = {"Random", "Jitter", "Static", "Up", "Down", "Left", "Right", "Spin"}
	local spinModeIndex = 2
	SpinModeBtn.MouseButton1Click:Connect(function()
		spinModeIndex = spinModeIndex + 1
		if spinModeIndex > #spinModes then spinModeIndex = 1 end
		spinMode = spinModes[spinModeIndex]
		SpinModeBtn.Text = spinMode
	end)

	CreateToggle(MiscBox, "Spin Bot", function(enabled)
		spinEnabled = enabled
		if not enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position)
		end
	end)

	CreateSlider(MiscBox, "Spin Speed", 1, 100, 10, function(val)
		spinSpeed = val
	end)

	task.spawn(function()
		local lastAngle = 0
		while task.wait() do
			if spinEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				local root = LocalPlayer.Character.HumanoidRootPart
				local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
				if hum and hum.Health > 0 then
					local speed = spinSpeed * 5
					local angle = 0
					if spinMode == "Random" then
						angle = math.rad(math.random(-180, 180))
					elseif spinMode == "Jitter" then
						lastAngle = lastAngle + math.rad(speed * 2)
						angle = lastAngle
						if math.random(1, 10) == 1 then
							angle = lastAngle + math.rad(math.random(-90, 90))
						end
					elseif spinMode == "Static" then
						angle = math.rad(90)
					elseif spinMode == "Up" then
						angle = math.rad(-90)
					elseif spinMode == "Down" then
						angle = math.rad(90)
					elseif spinMode == "Left" then
						angle = math.rad(-180)
					elseif spinMode == "Right" then
						angle = math.rad(0)
					elseif spinMode == "Spin" then
						lastAngle = lastAngle + math.rad(speed)
						angle = lastAngle
					end
					root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, angle, 0)
				end
			end
		end
	end)

	CreateToggle(MiscBox, "Fly", function(enabled)
		flyEnabled = enabled
		if enabled then
			local char = LocalPlayer.Character
			if char then
				local hum = char:FindFirstChild("Humanoid")
				if hum then
					hum.PlatformStand = true
				end
				local root = char:FindFirstChild("HumanoidRootPart")
				if root and root:FindFirstChild("Fly_Vel") then
					root.Fly_Vel:Destroy()
				end
			end
		else
			local char = LocalPlayer.Character
			if char then
				local hum = char:FindFirstChild("Humanoid")
				if hum then
					hum.PlatformStand = false
					hum.WalkSpeed = 16
				end
				local root = char:FindFirstChild("HumanoidRootPart")
				if root and root:FindFirstChild("Fly_Vel") then
					root.Fly_Vel:Destroy()
				end
			end
		end
	end)

	CreateSlider(MiscBox, "Fly Speed", 10, 500, 30, function(val)
		flySpeed = val
	end)

	RunService.RenderStepped:Connect(function()
		if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local root = LocalPlayer.Character.HumanoidRootPart
			local vel = root:FindFirstChild("Fly_Vel")
			if not vel then
				vel = Instance.new("BodyVelocity")
				vel.Name = "Fly_Vel"
				vel.MaxForce = Vector3.new(10000, 10000, 10000)
				vel.Velocity = Vector3.new(0, 0, 0)
				vel.Parent = root
			end
			local moveDir = Vector3.new(0, 0, 0)
			local speed = flySpeed
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + (camera.CFrame.LookVector * speed) end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - (camera.CFrame.LookVector * speed) end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - (camera.CFrame.RightVector * speed) end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + (camera.CFrame.RightVector * speed) end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir + Vector3.new(0, speed, 0) end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, speed, 0) end
			if moveDir.Magnitude > 0 then
				moveDir = moveDir.Unit * speed
			end
			vel.Velocity = Vector3.new(moveDir.X, moveDir.Y, moveDir.Z)
		end
	end)

	CreateToggle(MiscBox, "Anchor (7s Delay)", function(enabled)
		anchorEnabled = enabled
		if enabled then
			task.spawn(function()
				local char = LocalPlayer.Character
				if not char then return end
				local root = char:FindFirstChild("HumanoidRootPart")
				local hum = char:FindFirstChild("Humanoid")
				if root and hum then
					hum.PlatformStand = true
					local startPos = root.Position
					local endPos = startPos - Vector3.new(0, 2, 0)
					for i = 1, 70 do
						if not anchorEnabled then break end
						local progress = i / 70
						local currentPos = startPos:Lerp(endPos, progress)
						root.CFrame = CFrame.new(currentPos)
						task.wait(0.1)
					end
					if anchorEnabled and char then
						for _, part in pairs(char:GetDescendants()) do
							if part:IsA("BasePart") then
								part.Anchored = true
								table.insert(anchorParts, part)
							end
						end
						if hum then
							hum.PlatformStand = false
						end
					end
				end
			end)
		else
			for _, part in pairs(anchorParts) do
				if part and part.Parent then
					part.Anchored = false
				end
			end
			anchorParts = {}
			local char = LocalPlayer.Character
			if char then
				local root = char:FindFirstChild("HumanoidRootPart")
				local hum = char:FindFirstChild("Humanoid")
				if hum then
					hum.PlatformStand = false
				end
				if root then
					local raycastParams = RaycastParams.new()
					raycastParams.FilterDescendantsInstances = {char}
					raycastParams.FilterType = Enum.RaycastFilterType.Exclude
					local result = workspace:Raycast(root.Position + Vector3.new(0, 3, 0), Vector3.new(0, -10, 0), raycastParams)
					if result then
						root.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0))
					end
				end
			end
		end
	end)

	LocalPlayer.CharacterAdded:Connect(function(char)
		if anchorEnabled then
			task.wait(0.5)
			local root = char:FindFirstChild("HumanoidRootPart")
			local hum = char:FindFirstChild("Humanoid")
			if root and hum then
				hum.PlatformStand = true
				local startPos = root.Position
				local endPos = startPos - Vector3.new(0, 2, 0)
				for i = 1, 70 do
					if not anchorEnabled then break end
					local progress = i / 70
					local currentPos = startPos:Lerp(endPos, progress)
					root.CFrame = CFrame.new(currentPos)
					task.wait(0.1)
				end
				if anchorEnabled and char then
					for _, part in pairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.Anchored = true
							table.insert(anchorParts, part)
						end
					end
					if hum then
						hum.PlatformStand = false
					end
				end
			end
		end
	end)

	task.spawn(function()
		while task.wait(5) do
			if not SkelHande or not SkelHande.Parent then
				CreateGUI()
			end
		end
	end)
end

CreateGUI()
