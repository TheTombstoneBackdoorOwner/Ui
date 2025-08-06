local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local G2L = {}

-- Create ScreenGui
G2L["ScreenGui"] = Instance.new("ScreenGui")
G2L["ScreenGui"].Parent = PlayerGui
G2L["ScreenGui"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CollectionService:AddTag(G2L["ScreenGui"], "main")

-- Create Frame
local Frame = Instance.new("Frame")
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderMode = Enum.BorderMode.Middle
Frame.Size = UDim2.new(0.24219, 0, 0.18868, 0)
Frame.Position = UDim2.new(0.39063, 0, 0.19137, 0)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = G2L["ScreenGui"]
G2L["Frame"] = Frame

-- Create Scriptbox (TextBox)
local Scriptbox = Instance.new("TextBox")
Scriptbox.Name = "Scriptbox"
Scriptbox.CursorPosition = -1
Scriptbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Scriptbox.BorderMode = Enum.BorderMode.Middle
Scriptbox.ClearTextOnFocus = false
Scriptbox.Size = UDim2.new(0.89032, 0, 0.34286, 0)
Scriptbox.Position = UDim2.new(0.03871, 0, 0.28571, 0)
Scriptbox.Text = ""
Scriptbox.Parent = Frame
G2L["Scriptbox"] = Scriptbox

-- Create Execute Button
local Execute = Instance.new("TextButton")
Execute.Name = "Execute"
Execute.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Execute.BorderMode = Enum.BorderMode.Middle
Execute.Size = UDim2.new(0.41935, 0, 0.21429, 0)
Execute.Position = UDim2.new(0.03871, 0, 0.72857, 0)
Execute.Text = "Execute"
Execute.Parent = Frame
G2L["Execute"] = Execute

-- Create Clear Button
local Clear = Instance.new("TextButton")
Clear.Name = "Clear"
Clear.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Clear.BorderMode = Enum.BorderMode.Middle
Clear.Size = UDim2.new(0.41935, 0, 0.21429, 0)
Clear.Position = UDim2.new(0.47742, 0, 0.72857, 0)
Clear.Text = "Clear"
Clear.Parent = Frame
G2L["Clear"] = Clear

-- Create Title Label
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.TextWrapped = true
Title.TextScaled = true
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BorderMode = Enum.BorderMode.Middle
Title.Size = UDim2.new(0.99355, 0, 0.14286, 0)
Title.Position = UDim2.new(0, 0, -0.02857, 0)
Title.Text = "Cum Ui (Private Gui) --Made By Rxs. Do Not Redistribute If Leaked, If It Is Warn The Original Owner"
Title.Parent = Frame
G2L["Title"] = Title

-- UI Aspect Ratio Constraint
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.AspectRatio = 2.21429
UIAspectRatioConstraint.Parent = Frame
G2L["UIAspectRatioConstraint"] = UIAspectRatioConstraint

-- Remote storage
local remoteEvents = {}
local remoteFunctions = {}

-- Function to recursively search for RemoteEvents and RemoteFunctions in game
local function recursiveSearch(parent)
	for _, child in ipairs(parent:GetChildren()) do
		if child:IsA("RemoteEvent") then
			table.insert(remoteEvents, child)
		elseif child:IsA("RemoteFunction") then
			table.insert(remoteFunctions, child)
		end
		recursiveSearch(child)
	end
end

recursiveSearch(game)

-- Update remoteEvents and remoteFunctions on descendant added/removed
game.DescendantAdded:Connect(function(child)
	if child:IsA("RemoteEvent") then
		table.insert(remoteEvents, child)
	elseif child:IsA("RemoteFunction") then
		table.insert(remoteFunctions, child)
	end
end)

game.DescendantRemoving:Connect(function(child)
	for i, v in ipairs(remoteEvents) do
		if v == child then
			table.remove(remoteEvents, i)
			break
		end
	end
	for i, v in ipairs(remoteFunctions) do
		if v == child then
			table.remove(remoteFunctions, i)
			break
		end
	end
end)

-- Execute button click function
Execute.MouseButton1Click:Connect(function()
	local code = Scriptbox.Text
	for _, remoteEvent in ipairs(remoteEvents) do
		local success, err = pcall(function()
			remoteEvent:FireServer(code)
		end)
		if not success then
			warn("Failed to fire RemoteEvent "..remoteEvent:GetFullName()..": "..tostring(err))
		end
	end
	for _, remoteFunction in ipairs(remoteFunctions) do
		local success, result = pcall(function()
			return remoteFunction:InvokeServer(code)
		end)
		if not success then
			warn("Failed to invoke RemoteFunction "..remoteFunction:GetFullName()..": "..tostring(result))
		end
	end
end)

-- Clear button click function
Clear.MouseButton1Click:Connect(function()
	Scriptbox.Text = ""
end)

return G2L["ScreenGui"]
