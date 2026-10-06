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
MainFrame.Size = UDim2.new(0, 240, 0, 430)
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

-- 1. Textruta för att skriva in Brainrot-namn till Auto Collect
local BrainrotInputBox = Instance.new("TextBox")
BrainrotInputBox.Name = "BrainrotInputBox"
BrainrotInputBox.Parent = MainFrame
BrainrotInputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BrainrotInputBox.BorderSizePixel = 0
BrainrotInputBox.Size = UDim2.new(1, 0, 0, 30)
BrainrotInputBox.Font = Enum.Font.SourceSans
BrainrotInputBox.PlaceholderText = "Type Brainrot Name Here..."
BrainrotInputBox.Text = "Spaghetti Tualetti" -- Standardvärde
BrainrotInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
BrainrotInputBox.TextSize = 14

-- 2. Auto Collect Money Toggle (Sökning i hela Workspace efter namnet)
local autoCollectActive = false
createToggle("Auto Collect Money", function(state)
	autoCollectActive = state
end)

task.spawn(function()
	while true do
		if autoCollectActive then
			pcall(function()
				local targetName = BrainrotInputBox.Text
				local foundTarget = workspace:FindFirstChild(targetName, true) -- Sök rekursivt i workspace
				
				if foundTarget then
					local args = {
						"take a shower",
						44394224,
						foundTarget
					}
					game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
				end
			end)
		end
		task.wait(1)
	end
end)

-- 3. Auto Lock Base Toggle
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

-- 4. Auto Spin Wheel Toggle
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
		task.wait(2)
	end
end)

-- 5. Auto Buy Diamond Block Toggle
local autoBuyDiamondActive = false
createToggle("Auto Buy Diamond Block", function(state)
	autoBuyDiamondActive = state
end)

task.spawn(function()
	while true do
		if autoBuyDiamondActive then
			pcall(function()
				local args = {
					"bypassthis2",
					28928448,
					"Diamond Block",
					1
				}
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
			end)
		end
		task.wait(2)
	end
end)

-- 6. Speed Boost Toggle (Sätter hastighet till 37)
createToggle("Speed Boost (37)", function(state)
	local player = game:GetService("Players").LocalPlayer
	local function updateSpeed()
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			if state then
				player.Character.Humanoid.WalkSpeed = 37
			else
				player.Character.Humanoid.WalkSpeed = 16
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

-- 7. Roof Noclip (3 sekunder)
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

-- 8. Player ESP Toggle (Visar användarnamn, lag och avstånd)
local espActive = false
createToggle("Player ESP", function(state)
	espActive = state
	local players = game:GetService("Players")
	local localPlayer = players.LocalPlayer
	local runService = game:GetService("RunService")
	
	local function setupEsp(plr)
		if plr == localPlayer then return end
		
		local function applyToChar(char)
			-- Highlight för att se spelaren genom väggar
			if not char:FindFirstChild("Highlight") then
				local hl = Instance.new("Highlight")
				hl.Name = "Highlight"
				hl.Adornee = char
				hl.Parent = char
				hl.FillColor = Color3.fromRGB(255, 0, 0)
				hl.OutlineColor = Color3.fromRGB(255, 255, 255)
			end
			
			-- BillboardGui för Namn, Lag och Avstånd
			local head = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
			if head and not head:FindFirstChild("EspTag") then
				local billboard = Instance.new("BillboardGui")
				billboard.Name = "EspTag"
				billboard.Adornee = head
				billboard.Size = UDim2.new(0, 200, 0, 50)
				billboard.StudsOffset = Vector3.new(0, 2.5, 0)
				billboard.AlwaysOnTop = true
				
				local textLabel = Instance.new("TextLabel")
				textLabel.Name = "Text"
				textLabel.Parent = billboard
				textLabel.BackgroundTransparency = 1
				textLabel.Size = UDim2.new(1, 0, 1, 0)
				textLabel.Font = Enum.Font.SourceSansBold
				textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				textLabel.TextSize = 13
				textLabel.TextStrokeTransparency = 0.5
				textLabel.Parent = billboard
				billboard.Parent = head
				
				-- Uppdatera texten varje bildruta (avstånd, namn, lag)
				local conn
				conn = runService.RenderStepped:Connect(function()
					if not espActive or not char or not char.Parent or not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
						billboard.Enabled = false
						if char:FindFirstChild("Highlight") then char.Highlight.Enabled = false end
						return
					end
					
					billboard.Enabled = true
					if char:FindFirstChild("Highlight") then char.Highlight.Enabled = true end
					
					local rootPart = char:FindFirstChild("HumanoidRootPart")
					local localRoot = localPlayer.Character.HumanoidRootPart
					if rootPart and localRoot then
						local distance = math.floor((rootPart.Position - localRoot.Position).Magnitude)
						local teamName = plr.Team and plr.Team.Name or "No Team"
						textLabel.Text = string.VFormat("{0} | Team: {1} | [{2} studs]", {plr.Name, teamName, distance})
					end
				end)
				
				char.AncestryChanged:Connect(function(_, parent)
					if not parent then
						if conn then conn:Disconnect() end
					end
				end)
			end
		end
		
		if plr.Character then applyToChar(plr.Character) end
		plr.CharacterAdded:Connect(applyToChar)
	end
	
	for _, plr in pairs(players:GetPlayers()) do
		setupEsp(plr)
	end
	
	players.PlayerAdded:Connect(setupEsp)
end)
