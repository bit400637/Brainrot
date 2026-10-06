-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Create Main Window
local Window = Rayfield:CreateWindow({
	Name = "Emil_axelgs GUI",
	LoadingTitle = "Emil_axelgs GUI",
	LoadingSubtitle = "Created by @therageisbest",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = nil,
		FileName = "EmilConfig"
	},
	KeySystem = false,
})

-- Create Tabs
local MainTab = Window:CreateTab("Main Farm", 4483362458)
local CombatTab = Window:CreateTab("Combat & Mov", 4483362458)
local VisualsTab = Window:CreateTab("Visuals", 4483362458)

------------------------------------------------------------------
-- MAIN TAB (Auto Collect, Spin, Buy Blocks/Defense, Lock Base)
------------------------------------------------------------------

-- 1. Auto Collect Money
local targetBrainrotName = "Spaghetti Tualetti"
MainTab:CreateInput({
	Name = "Target Brainrot Name",
	CurrentValue = "Spaghetti Tualetti",
	PlaceholderText = "Enter brainrot name...",
	Flag = "BrainrotInput",
	Callback = function(Text)
		targetBrainrotName = Text
	end,
})

local autoCollectActive = false
MainTab:CreateToggle({
	Name = "Auto Collect Money",
	CurrentValue = false,
	Flag = "AutoCollect",
	Callback = function(Value)
		autoCollectActive = Value
	end,
})

task.spawn(function()
	while true do
		if autoCollectActive then
			pcall(function()
				local foundTarget = workspace:FindFirstChild(targetBrainrotName, true)
				if foundTarget then
					local args = {"take a shower", 44394224, foundTarget}
					ReplicatedStorage:WaitForChild("RemoteEvent"):FireServer(unpack(args))
				end
			end)
		end
		task.wait(1)
	end
end)

-- 2. Auto Lock Base
local autoLockActive = false
MainTab:CreateToggle({
	Name = "Auto Lock Base",
	CurrentValue = false,
	Flag = "AutoLock",
	Callback = function(Value)
		autoLockActive = Value
	end,
})

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

-- 3. Auto Spin Wheel
local autoSpinActive = false
MainTab:CreateToggle({
	Name = "Auto Spin Wheel",
	CurrentValue = false,
	Flag = "AutoSpin",
	Callback = function(Value)
		autoSpinActive = Value
	end,
})

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

-- 4. Auto Buy Blocks
local blockItemName = "Diamond Block"
MainTab:CreateInput({
	Name = "Block Item Name",
	CurrentValue = "Diamond Block",
	PlaceholderText = "Enter block name...",
	Flag = "BlockInput",
	Callback = function(Text)
		blockItemName = Text
	end,
})

local autoBuyBlockActive = false
MainTab:CreateToggle({
	Name = "Auto Buy Blocks",
	CurrentValue = false,
	Flag = "AutoBuyBlock",
	Callback = function(Value)
		autoBuyBlockActive = Value
	end,
})

task.spawn(function()
	while true do
		if autoBuyBlockActive then
			pcall(function()
				local args = {"bypassthis2", 28928448, blockItemName, 1}
				ReplicatedStorage:WaitForChild("RemoteEvent"):FireServer(unpack(args))
			end)
		end
		task.wait(2)
	end
end)

-- 5. Auto Buy Defense
local defenseItemName = "Laser Door"
MainTab:CreateInput({
	Name = "Defense Item Name",
	CurrentValue = "Laser Door",
	PlaceholderText = "Enter defense name...",
	Flag = "DefenseInput",
	Callback = function(Text)
		defenseItemName = Text
	end,
})

local autoBuyDefenseActive = false
MainTab:CreateToggle({
	Name = "Auto Buy Defense",
	CurrentValue = false,
	Flag = "AutoBuyDefense",
	Callback = function(Value)
		autoBuyDefenseActive = Value
	end,
})

task.spawn(function()
	while true do
		if autoBuyDefenseActive then
			pcall(function()
				local args = {"bypassthis2", 470940160, defenseItemName, 1}
				ReplicatedStorage:WaitForChild("RemoteEvent"):FireServer(unpack(args))
			end)
		end
		task.wait(2)
	end
end)


------------------------------------------------------------------
-- COMBAT & MOVEMENT TAB (Speed, Jump, Aimbot, Noclip, Anti-Teleport)
------------------------------------------------------------------

-- 1. Speed Boost
CombatTab:CreateToggle({
	Name = "Speed Boost (37)",
	CurrentValue = false,
	Flag = "SpeedBoost",
	Callback = function(Value)
		local function updateSpeed()
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				LocalPlayer.Character.Humanoid.WalkSpeed = Value and 37 or 16
			end
		end
		updateSpeed()
		LocalPlayer.CharacterAdded:Connect(function(char)
			char:WaitForChild("Humanoid")
			if Value then char.Humanoid.WalkSpeed = 37 end
		end)
	end,
})

-- 2. Infinite Jump
local infJumpActive = false
CombatTab:CreateToggle({
	Name = "Infinite Jump",
	CurrentValue = false,
	Flag = "InfJump",
	Callback = function(Value)
		infJumpActive = Value
	end,
})

UserInputService.JumpRequest:Connect(function()
	if infJumpActive and LocalPlayer.Character then
		local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

-- 3. Roof Noclip (3s Timer)
CombatTab:CreateButton({
	Name = "Roof Noclip (3s)",
	Callback = function()
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
		end)
	end,
})

-- 4. No Respawn Teleport (Anti-Teleport / Anchor to stop rubberbanding back to spawn)
local antiTpActive = false
CombatTab:CreateToggle({
	Name = "No Respawn Teleport (Anti-TP)",
	CurrentValue = false,
	Flag = "AntiTp",
	Callback = function(Value)
		antiTpActive = Value
	end,
})

RunService.Stepped:Connect(function()
	if antiTpActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		pcall(function()
			-- Blockera automatiska återställningar eller tvingade positioner från servern
			local rootPart = LocalPlayer.Character.HumanoidRootPart
			rootPart.AssemblyLinearVelocity = Vector3.new(0, rootPart.AssemblyLinearVelocity.Y, 0)
		end)
	end
end)

-- 5. Auto Sword Attack
local autoSwordActive = false
CombatTab:CreateToggle({
	Name = "Auto Sword Attack",
	CurrentValue = false,
	Flag = "AutoSword",
	Callback = function(Value)
		autoSwordActive = Value
	end,
})

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

-- 6. Sword Aimbot
local swordAimbotActive = false
CombatTab:CreateToggle({
	Name = "Sword Aimbot",
	CurrentValue = false,
	Flag = "SwordAimbot",
	Callback = function(Value)
		swordAimbotActive = Value
	end,
})

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


------------------------------------------------------------------
-- VISUALS TAB (Player ESP)
------------------------------------------------------------------

VisualsTab:CreateToggle({
	Name = "Player ESP",
	CurrentValue = false,
	Flag = "PlayerESP",
	Callback = function(Value)
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
						if not Value or not char or not char.Parent or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
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
	end,
})

-- Load notification
Rayfield:Notify({
	Title = "Emil_axelgs GUI Loaded!",
	Content = "Successfully initialized Rayfield interface.",
	Duration = 6.5,
	Image = 4483362458,
})
