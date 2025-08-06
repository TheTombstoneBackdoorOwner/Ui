local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local G2L = {}

G2L["ScreenGui"] = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
G2L["ScreenGui"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CollectionService:AddTag(G2L["ScreenGui"], "main")

G2L["Frame"] = Instance.new("Frame", G2L["ScreenGui"])
G2L["Frame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
G2L["Frame"].BorderMode = Enum.BorderMode.Middle
G2L["Frame"].Size = UDim2.new(0.24219, 0, 0.18868, 0)
G2L["Frame"].Position = UDim2.new(0.39063, 0, 0.19137, 0)
G2L["Frame"].Active = true
G2L["Frame"].Draggable = true

G2L["Scriptbox"] = Instance.new("TextBox", G2L["Frame"])
G2L["Scriptbox"].CursorPosition = -1
G2L["Scriptbox"].Name = "Scriptbox"
G2L["Scriptbox"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
G2L["Scriptbox"].BorderMode = Enum.BorderMode.Middle
G2L["Scriptbox"].ClearTextOnFocus = false
G2L["Scriptbox"].Size = UDim2.new(0.89032, 0, 0.34286, 0)
G2L["Scriptbox"].Position = UDim2.new(0.03871, 0, 0.28571, 0)
G2L["Scriptbox"].Text = ""

G2L["Execute"] = Instance.new("TextButton", G2L["Frame"])
G2L["Execute"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
G2L["Execute"].BorderMode = Enum.BorderMode.Middle
G2L["Execute"].Size = UDim2.new(0.41935, 0, 0.21429, 0)
G2L["Execute"].Text = "Execute"
G2L["Execute"].Name = "Execute"
G2L["Execute"].Position = UDim2.new(0.03871, 0, 0.72857, 0)

G2L["Clear"] = Instance.new("TextButton", G2L["Frame"])
G2L["Clear"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
G2L["Clear"].BorderMode = Enum.BorderMode.Middle
G2L["Clear"].Size = UDim2.new(0.41935, 0, 0.21429, 0)
G2L["Clear"].Text = "Clear"
G2L["Clear"].Name = "Clear"
G2L["Clear"].Position = UDim2.new(0.47742, 0, 0.72857, 0)

G2L["Title"] = Instance.new("TextLabel", G2L["Frame"])
G2L["Title"].TextWrapped = true
G2L["Title"].TextScaled = true
G2L["Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
G2L["Title"].BorderMode = Enum.BorderMode.Middle
G2L["Title"].Archivable = false
G2L["Title"].Size = UDim2.new(0.99355, 0, 0.14286, 0)
G2L["Title"].Text = "Cum Ui (Private Gui) --Made By Rxs. Do Not Redistribute If Leaked, If It Is Warn The Original Owner"
G2L["Title"].Name = "Title"
G2L["Title"].Position = UDim2.new(0, 0, -0.02857, 0)

G2L["UIAspectRatioConstraint"] = Instance.new("UIAspectRatioConstraint", G2L["Frame"])
G2L["UIAspectRatioConstraint"].AspectRatio = 2.21429

local remoteEvents = {}
local remoteFunctions = {}

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

local ExecuteScript = Instance.new("LocalScript", G2L["Execute"])
ExecuteScript.Name = "ExecuteScript"

ExecuteScript.Parent.MouseButton1Click:Connect(function()
	local code = G2L["Scriptbox"].Text
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

local ClearScript = Instance.new("LocalScript", G2L["Clear"])
ClearScript.Name = "ClearScript"

ClearScript.Parent.MouseButton1Click:Connect(function()
	G2L["Scriptbox"].Text = ""
end)

return G2L["ScreenGui"]
