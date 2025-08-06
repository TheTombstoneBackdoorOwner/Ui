local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local G2L = {}

-- Basic UI setup --
G2L["ScreenGui"] = Instance.new("ScreenGui", playerGui)
G2L["ScreenGui"].Name = "BackdoorScannerUI"
CollectionService:AddTag(G2L["ScreenGui"], "main")

local frame = Instance.new("Frame", G2L["ScreenGui"])
frame.Size = UDim2.new(0.3, 0, 0.15, 0)
frame.Position = UDim2.new(0.35, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Text = "Backdoor Scanner (Private)"
title.Font = Enum.Font.SourceSansBold

local outputBox = Instance.new("TextBox", frame)
outputBox.ClearTextOnFocus = false
outputBox.MultiLine = true
outputBox.Size = UDim2.new(1, -10, 0.6, -10)
outputBox.Position = UDim2.new(0, 5, 0.3, 5)
outputBox.TextWrapped = true
outputBox.TextColor3 = Color3.new(1, 1, 1)
outputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
outputBox.Text = ""
outputBox.Font = Enum.Font.Code

-- No buttons needed to avoid flooding ---

-- Scan for remotes safely
local remoteEvents = {}
local remoteFunctions = {}

local function scanRemotes(parent)
    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("RemoteEvent") then
            table.insert(remoteEvents, child)
        elseif child:IsA("RemoteFunction") then
            table.insert(remoteFunctions, child)
        end
        scanRemotes(child)
    end
end

-- Initial scan
scanRemotes(game)

-- Helper to report
local function report(text)
    outputBox.Text = outputBox.Text .. text .. "\n"
end

-- Report discovered remotes on startup
report("Scanning for RemoteEvents and RemoteFunctions...")
report("RemoteEvents found: "..#remoteEvents)
for _, re in ipairs(remoteEvents) do
    report("Event: "..re:GetFullName())
end
report("RemoteFunctions found: "..#remoteFunctions)
for _, rf in ipairs(remoteFunctions) do
    report("Function: "..rf:GetFullName())
end

-- Listen for new remotes added during gameplay, report them too
game.DescendantAdded:Connect(function(child)
    if child:IsA("RemoteEvent") then
        table.insert(remoteEvents, child)
        report("[Added] RemoteEvent: "..child:GetFullName())
    elseif child:IsA("RemoteFunction") then
        table.insert(remoteFunctions, child)
        report("[Added] RemoteFunction: "..child:GetFullName())
    end
end)

game.DescendantRemoving:Connect(function(child)
    -- Remove from lists silently, no report to reduce spam
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

return G2L["ScreenGui"]
