-- Services
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Create Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Emil_axelgsGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui or LocalPlayer:WaitForChild("PlayerGui")

-- Toggle GUI Button (On screen)
local ToggleGuiButton = Instance.new("TextButton")
ToggleGuiButton.Name = "ToggleGuiButton"
ToggleGuiButton.Parent = ScreenGui
ToggleGuiButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleGuiButton.BorderSizePixel = 0
ToggleGuiButton.Position = UDim2.new(0.01, 0, 0.01, 0)
ToggleGuiButton.Size = UDim2.new(0, 110, 0, 35)
ToggleGuiButton.Font = Enum.Font.GothamBold
ToggleGuiButton.Text = "Toggle GUI"
ToggleGuiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleGuiButton.TextSize = 13

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleGuiButton

-- Main Window Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.01, 0, 0.07, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 440)
MainFrame.Visible = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Top Bar / Title
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(1, 0, 0, 35)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "  Emil_axelgs GUI"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 15
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleLabel

-- Credits Text
local CreditsLabel = Instance.new("TextLabel")
CreditsLabel.Name = "CreditsLabel"
CreditsLabel.Parent = MainFrame
CreditsLabel.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
CreditsLabel.BorderSizePixel = 0
CreditsLabel.Position = UDim2.new(0, 0, 0, 37)
CreditsLabel.Size = UDim2.new(1, 0, 0, 24)
CreditsLabel.Font = Enum.Font.GothamMedium
CreditsLabel.Text = "Created by @therageisbest"
CreditsLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
CreditsLabel.TextSize = 11

-- Make Window Draggable
local dragging, dragInput, dragStart, startPos
TitleLabel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

TitleLabel.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

ToggleGuiButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- Scrolling Container for Elements
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Parent = MainFrame
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0, 0, 0, 65)
ScrollingFrame.Size = UDim2.new(1, 0, 1, -65)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 950)
ScrollingFrame.ScrollBarThickness = 6

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Helper: Create Input Boxes
local function createTextBox(placeholder, defaultText)
	local TextBox = Instance.new("TextBox")
	TextBox.Parent = ScrollingFrame
	TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	TextBox.BorderSizePixel = 0
	TextBox.Size = UDim2.new(0.9, 0, 0, 32)
	TextBox.Font = Enum.Font.Gotham
	TextBox.PlaceholderText = placeholder
	TextBox.Text = defaultText
	TextBox.TextColor3 = Color3.fromRGB(220, 220, 220)
	TextBox.TextSize = 13
	
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 6)
	Corner.Parent = TextBox
	return TextBox
end

-- Helper: Create Toggles
local function createToggle(name, callback)
	local ToggleButton = Instance.new("TextButton")
	ToggleButton.Parent = ScrollingFrame
	ToggleButton.BackgroundColor3 = Color3.fromRGB(42, 42, 50)
	ToggleButton.BorderSizePixel = 0
	ToggleButton.Size = UDim2.new(0.9, 0, 0, 36)
	ToggleButton.Font = Enum.Font.GothamMedium
	ToggleButton.Text = "  " .. name .. ": OFF"
	ToggleButton.TextColor3 = Color3.fromRGB(255, 100, 100)
	ToggleButton.TextSize = 13
	ToggleButton.TextXAlignment = Enum.TextXAlignment.Left

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 6)
	Corner.Parent = ToggleButton

	local active = false
	ToggleButton.MouseButton1Click:Connect(function()
		active = not active
		if active then
			ToggleButton.Text = "  " .. name .. ": ON"
			ToggleButton.TextColor3 = Color3.fromRGB(100, 255, 100)
			ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 60, 40)
		else
			ToggleButton.Text = "  " .. name .. ": OFF"
			ToggleButton.TextColor3 = Color3.fromRGB(255, 100, 100)
			ToggleButton.BackgroundColor3 = Color3.fromRGB(42, 42, 50)
		end
		callback(active)
	end)
end

-- 1. Auto Collect Controls
local BrainrotInputBox = createTextBox("Target Brainrot Name...", "Spaghetti Tualetti")
local autoCollectActive = false
createToggle("Auto Collect Money", function(state) autoCollectActive = state end)

task.spawn(function()
	while true do
		if autoCollectActive then
			pcall(function()
				local targetName = BrainrotInputBox.Text
				local foundTarget = workspace:FindFirstChild(targetName, true)
				if foundTarget then
					local args = {"take a shower", 44394224, foundTarget}
					ReplicatedStorage:WaitForChild("RemoteEvent"):FireServer(unpack(args))
				end
			end)
		end
		task.wait(1)
	end
end)

-- 2. Auto Lock Base Toggle
local autoLockActive = false
createToggle("Auto Lock Base", function(state) autoLockActive = state end)

task.spawn(function()
	while true do
		if autoLockActive then
			pcall(function()
				local args = {"take a shower2", 375625560}
				ReplicatedStorage:WaitForChild("RemoteEvent"):FireServer(unpack(args))
			end)
		end
		task.wait(1)
	end
end)

-- 3. Auto Spin Wheel Toggle
local autoSpinActive = false
createToggle("Auto Spin Wheel", function(state) autoSpinActive = state end)

task.spawn(function()
	while true do
		if autoSpinActive then
			pcall(function()
				local args = {"spinwheel", 157711808}
				ReplicatedStorage:WaitForChild("RemoteEvent"):FireServer(unpack(args))
			end)
		end
		task.wait(2)
	end
end)

-- 4. Auto Buy Blocks Controls
local BlockInputBox = createTextBox("Block Item Name...", "Diamond Block")
local autoBuyBlockActive = false
createToggle("Auto Buy Blocks", function(state) autoBuyBlockActive = state end)

task.spawn(function()
	while true do
		if autoBuyBlockActive then
			pcall(function()
				local args = {"bypassthis2", 28928448, BlockInputBox.Text, 1}
				ReplicatedStorage:WaitForChild("RemoteEvent"):FireServer(unpack(args))
			end)
		end
		task.wait(2)
	end
end)

-- 5. Auto Buy Defense Controls
local DefenseInputBox = createTextBox("Defense Item Name...", "Laser Door")
local autoBuyDefenseActive = false
createToggle("Auto Buy Defense", function(state) autoBuyDefenseActive = state end)

task.spawn(function()
	while true do
		if autoBuyDefenseActive then
			pcall(function()
				local args = {"bypassthis2", 470940160, DefenseInputBox.Text, 1}
				ReplicatedStorage:WaitForChild("RemoteEvent"):FireServer(unpack(args))
			end)
		end
		task.wait(2)
	end
end)

-- 6. Speed Boost Toggle
createToggle("Speed Boost (37)", function(state)
	local function updateSpeed()
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
			LocalPlayer.Character.Humanoid.WalkSpeed = state and 37 or 16
		end
	end
	updateSpeed()
	LocalPlayer.CharacterAdded:Connect(function(char)
		char:WaitForChild("Humanoid")
		if state then char.Humanoid.WalkSpeed = 37 end
	end)
end)

-- 7. Infinite Jump Toggle
local infJumpActive = false
createToggle("Infinite Jump", function(state)
	infJumpActive = state
end)

UserInputService.JumpRequest:Connect(function()
	if infJumpActive and LocalPlayer.Character then
		local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

-- 8. Roof Noclip (3s Timer Button)
local RoofNoclipButton = Instance.new("TextButton")
RoofNoclipButton.Parent = ScrollingFrame
RoofNoclipButton.BackgroundColor3 = Color3.fromRGB(42, 42, 50)
RoofNoclipButton.BorderSizePixel = 0
RoofNoclipButton.Size = UDim2.new(0.9, 0, 0, 36)
RoofNoclipButton.Font = Enum.Font.GothamMedium
RoofNoclipButton.Text = "  Roof Noclip (3s)"
RoofNoclipButton.TextColor3 = Color3.fromRGB(220, 220, 220)
RoofNoclipButton.TextSize = 13
RoofNoclipButton.TextXAlignment = Enum.TextXAlignment.Left

local RoofCorner = Instance.new("UICorner")
RoofCorner.CornerRadius = UDim.new(0, 6)
RoofCorner.Parent = RoofNoclipButton

RoofNoclipButton.MouseButton1Click:Connect(function()
	RoofNoclipButton.Text = "  Roof Noclip: ACTIVE"
	RoofNoclipButton.TextColor3 = Color3.fromRGB(100, 255, 100)
	
	local connection = RunService.Stepped:Connect(function()
		if LocalPlayer.Character then
			for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end
	end)
	
	local tempInfJumpConn = UserInputService.JumpRequest:Connect(function()
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
			LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
	
	task.delay(3, function()
		if connection then connection:Disconnect() end
		if tempInfJumpConn then tempInfJumpConn:Disconnect() end
		RoofNoclipButton.Text = "  Roof Noclip (3s)"
		RoofNoclipButton.TextColor3 = Color3.fromRGB(220, 220, 220)
	end)
end)

-- 9. Auto Sword Attack Toggle
local autoSwordActive = false
createToggle("Auto Sword Attack", function(state) autoSwordActive = state end)

task.spawn(function()
	while true do
		if autoSwordActive then
			pcall(function()
				local char = LocalPlayer.Character
				if char then
					local tool = char:FindFirstChildOfClass("Tool")
					if tool then
						tool:Activate()
					end
				end
			end)
		end
		task.wait(0.1)
	end
end)

-- 10. Sword Aimbot Toggle
local swordAimbotActive = false
createToggle("Sword Aimbot", function(state) swordAimbotActive = state end)

RunService.RenderStepped:Connect(function()
	if swordAimbotActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		pcall(function()
			local localRoot = LocalPlayer.Character.HumanoidRootPart
			local closestPlayer = nil
			local shortestDistance = math.huge
			
			for _, plr in pairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					local targetRoot = plr.Character.HumanoidRootPart
					local dist = (localRoot.Position - targetRoot.Position).Magnitude
					if dist < shortestDistance then
						shortestDistance = dist
						closestPlayer = plr
					end
				end
			end
			
			if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") then
				local targetPos = closestPlayer.Character.HumanoidRootPart.Position
				localRoot.CFrame = CFrame.new(localRoot.Position, Vector3.new(targetPos.X, localRoot.Position.Y, targetPos.Z))
			end
		end)
	end
end)

-- 11. Player ESP Toggle
createToggle("Player ESP", function(state)
	local function setupEsp(plr)
		if plr == LocalPlayer then return end
		local function applyToChar(char)
			if not char:FindFirstChild("Highlight") then
				local hl = Instance.new("Highlight")
				hl.Name = "Highlight"
				hl.Adornee = char
				hl.Parent = char
				hl.FillColor = Color3.fromRGB(255, 0, 0)
				hl.OutlineColor = Color3.fromRGB(255, 255, 255)
			end
			
			local head = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
			if head and not head:FindFirstChild("EspTag") then
				local billboard = Instance.new("BillboardGui")
				billboard.Name = "EspTag"
				billboard.Adornee = head
				billboard.Size = UDim2.new(0, 200, 0, 50)
				billboard.StudsOffset = Vector3.new(0, 2.5, 0)
				billboard.AlwaysOnTop = true
				
				local textLabel = Instance.new("TextLabel")
				textLabel.Parent = billboard
				textLabel.BackgroundTransparency = 1
				textLabel.Size = UDim2.new(1, 0, 1, 0)
				textLabel.Font = Enum.Font.GothamBold
				textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				textLabel.TextSize = 12
				textLabel.TextStrokeTransparency = 0.4
				billboard.Parent = head
				
				RunService.RenderStepped:Connect(function()
					if not state or not char or not char.Parent or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						billboard.Enabled = false
						if char:FindFirstChild("Highlight") then char.Highlight.Enabled = false end
						return
					end
					
					billboard.Enabled = true
					if char:FindFirstChild("Highlight") then char.Highlight.Enabled = true end
					
					local rootPart = char:FindFirstChild("HumanoidRootPart")
					local localRoot = LocalPlayer.Character.HumanoidRootPart
					if rootPart and localRoot then
						local distance = math.floor((rootPart.Position - localRoot.Position).Magnitude)
						local teamName = plr.Team and plr.Team.Name or "No Team"
						textLabel.Text = string.format("%s | Team: %s | [%d studs]", plr.Name, teamName, distance)
					end
				end)
			end
		end
		
		if plr.Character then applyToChar(plr.Character) end
		plr.CharacterAdded:Connect(applyToChar)
	end
	
	for _, plr in pairs(Players:GetPlayers()) do setupEsp(plr) end
	Players.PlayerAdded:Connect(setupEsp)
end)
