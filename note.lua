-- Skapa GUI-behållaren
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local TitleLabel = Instance.new("TextLabel")
local ToggleGuiButton = Instance.new("TextButton")

-- Sätt upp ScreenGui
ScreenGui.Name = "Emil_axelgsGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Knapp för att öppna/stänga hela gränssnittet
ToggleGuiButton.Name = "ToggleGuiButton"
ToggleGuiButton.Parent = ScreenGui
ToggleGuiButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleGuiButton.BorderSizePixel = 0
ToggleGuiButton.Position = UDim2.new(0.01, 0, 0.01, 0)
ToggleGuiButton.Size = UDim2.new(0, 100, 0, 30)
ToggleGuiButton.Font = Enum.Font.SourceSansBold
ToggleGuiButton.Text = "Toggle GUI"
ToggleGuiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleGuiButton.TextSize = 14

-- Huvudfönster
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.01, 0, 0.06, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 335)
MainFrame.Visible = true

-- Öppna/stäng logik för GUI
ToggleGuiButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- Titel
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(1, 0, 0, 35)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "Emil_axelgs GUI"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16

-- Layout
UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Funktion för att skapa av/på-knappar (Toggles)
local function createToggle(name, callback)
	local ToggleButton = Instance.new("TextButton")
	ToggleButton.Name = name .. "Toggle"
	ToggleButton.Parent = MainFrame
	ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	ToggleButton.BorderSizePixel = 0
	ToggleButton.Size = UDim2.new(1, 0, 0, 32)
	ToggleButton.Font = Enum.Font.SourceSans
	ToggleButton.Text = name .. ": OFF"
	ToggleButton.TextColor3 = Color3.fromRGB(255, 100, 100)
	ToggleButton.TextSize = 14

	local active = false
	
	ToggleButton.MouseButton1Click:Connect(function()
		active = not active
		if active then
			ToggleButton.Text = name .. ": ON"
			ToggleButton.TextColor3 = Color3.fromRGB(100, 255, 100)
			ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
		else
			ToggleButton.Text = name .. ": OFF"
			ToggleButton.TextColor3 = Color3.fromRGB(255, 100, 100)
			ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		end
		callback(active)
	end)
end

-- 1. Auto Collect Money Toggle
local autoCollectActive = false
createToggle("Auto Collect Money", function(state)
	autoCollectActive = state
end)

task.spawn(function()
	while true do
		if autoCollectActive then
			pcall(function()
				local args = {
					"take a shower",
					44394224,
					workspace:WaitForChild("Plots"):WaitForChild("2"):WaitForChild("Builds"):WaitForChild("Spaghetti Tualetti")
				}
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
			end)
		end
		task.wait(1)
	end
end)

-- 2. Auto Lock Base Toggle
local autoLockActive = false
createToggle("Auto Lock Base", function(state)
	autoLockActive = state
end)

task.spawn(function()
	while true do
		if autoLockActive then
			pcall(function()
				local args = {
					"take a shower2",
					375625560
				}
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
			end)
		end
		task.wait(1)
	end
end)

-- 3. Auto Spin Toggle
local autoSpinActive = false
createToggle("Auto Spin Wheel", function(state)
	autoSpinActive = state
end)

task.spawn(function()
	while true do
		if autoSpinActive then
			pcall(function()
				local args = {
					"spinwheel",
					157711808
				}
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
			end)
		end
		task.wait(2) -- Justera tidsintervall för spin om det behövs
	end
end)

-- 4. Speed Boost Toggle (Sätter hastighet till 37)
createToggle("Speed Boost (37)", function(state)
	local player = game:GetService("Players").LocalPlayer
	local function updateSpeed()
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			if state then
				player.Character.Humanoid.WalkSpeed = 37
			else
				player.Character.Humanoid.WalkSpeed = 16 -- Standardhastighet
			end
		end
	end
	updateSpeed()
	player.CharacterAdded:Connect(function(char)
		char:WaitForChild("Humanoid")
		if state then
			char.Humanoid.WalkSpeed = 37
		end
	end)
end)

-- 5. Roof Noclip (Aktiverar anti-teleport, noclip och inf jump i 3 sekunder)
local RoofNoclipButton = Instance.new("TextButton")
RoofNoclipButton.Name = "RoofNoclipToggle"
RoofNoclipButton.Parent = MainFrame
RoofNoclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RoofNoclipButton.BorderSizePixel = 0
RoofNoclipButton.Size = UDim2.new(1, 0, 0, 32)
RoofNoclipButton.Font = Enum.Font.SourceSans
RoofNoclipButton.Text = "Roof Noclip (3s)"
RoofNoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RoofNoclipButton.TextSize = 14

RoofNoclipButton.MouseButton1Click:Connect(function()
	RoofNoclipButton.Text = "Roof Noclip: ACTIVE"
	RoofNoclipButton.TextColor3 = Color3.fromRGB(100, 255, 100)
	RoofNoclipButton.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
	
	local player = game:GetService("Players").LocalPlayer
	local runService = game:GetService("RunService")
	
	-- Anti-teleport / Noclip / Infinite Jump logik under 3 sekunder
	local connection
	connection = runService.Stepped:Connect(function()
		if player.Character then
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end)
	
	-- Infinite jump koppling under perioden
	local infJumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
		if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
			player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
	
	task.delay(3, function()
		if connection then connection:Disconnect() end
		if infJumpConn then infJumpConn:Disconnect() end
		RoofNoclipButton.Text = "Roof Noclip (3s)"
		RoofNoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		RoofNoclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end)
end)

-- 6. Player ESP Toggle
local espActive = false
createToggle("Player ESP", function(state)
	espActive = state
	local players = game:GetService("Players")
	
	local function addEsp(plr)
		if plr == players.LocalPlayer then return end
		local function applyToChar(char)
			if char:FindFirstChild("Highlight") then return end
			local hl = Instance.new("Highlight")
			hl.Name = "Highlight"
			hl.Adornee = char
			hl.Parent = char
			hl.Enabled = espActive
			hl.FillColor = Color3.fromRGB(255, 0, 0)
			hl.OutlineColor = Color3.fromRGB(255, 255, 255)
		end
		
		if plr.Character then applyToChar(plr.Character) end
		plr.CharacterAdded:Connect(applyToChar)
	end
	
	for _, plr in pairs(players:GetPlayers()) do
		addEsp(plr)
	end
	
	players.PlayerAdded:Connect(addEsp)
	
	-- Uppdatera befintliga highlights om ESP stängs av/på
	for _, plr in pairs(players:GetPlayers()) do
		if plr.Character and plr.Character:FindFirstChild("Highlight") then
			plr.Character.Highlight.Enabled = espActive
		end
	end
end)
