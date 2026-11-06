-- YanzGong.lua
-- Runtime: Roblox Studio | LocalScript

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("YanzGongHub")
if old then old:Destroy() end

local purple = Color3.fromRGB(153, 110, 255)
local dark = Color3.fromRGB(19, 19, 30)
local panel = Color3.fromRGB(30, 29, 46)

local gui = Instance.new("ScreenGui")
gui.Name = "YanzGongHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(430, 310)
main.Position = UDim2.new(0.5, -215, 0.5, -155)
main.BackgroundColor3 = dark
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = purple
stroke.Thickness = 1.5
stroke.Parent = main

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 65),
    BackgroundColor3 = panel,
    BorderSizePixel = 0
}, main)

make("UICorner", {
    CornerRadius = UDim.new(0, 12)
}, header)

make("TextLabel", {
    Size = UDim2.new(1, -60, 0, 30),
    Position = UDim2.fromOffset(15, 7),
    BackgroundTransparency = 1,
    Text = "YANZGONG HUB",
    TextColor3 = Color3.fromRGB(205, 180, 255),
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

make("TextLabel", {
    Size = UDim2.new(1, -60, 0, 20),
    Position = UDim2.fromOffset(16, 36),
    BackgroundTransparency = 1,
    Text = "GROWBLOX EDITION | V1.0",
    TextColor3 = Color3.fromRGB(160, 155, 180),
    TextSize = 10,
    Font = Enum.Font.Gotham
}, header)

local close = make("TextButton", {
    Size = UDim2.fromOffset(35, 35),
    Position = UDim2.new(1, -43, 0, 13),
    BackgroundColor3 = Color3.fromRGB(75, 45, 90),
    Text = "X",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 16,
    Font = Enum.Font.GothamBold
}, header)

make("UICorner", {
    CornerRadius = UDim.new(0, 8)
}, close)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local sidebar = make("Frame", {
    Position = UDim2.fromOffset(10, 75),
    Size = UDim2.new(0, 120, 1, -85),
    BackgroundColor3 = panel,
    BorderSizePixel = 0
}, main)

make("UICorner", {
    CornerRadius = UDim.new(0, 9)
}, sidebar)

local content = make("Frame", {
    Position = UDim2.fromOffset(140, 75),
    Size = UDim2.new(1, -150, 1, -85),
    BackgroundTransparency = 1
}, main)

local currentTab

local descriptions = {
    Farming = "Farming tools for your own test world.",
    Player = "Player interface settings.",
    Visual = "Visual preferences.",
    Settings = "YanzGong Hub configuration."
}

local function showTab(name)
    if currentTab then
        currentTab:Destroy()
    end

    currentTab = Instance.new("Frame")
    currentTab.Size = UDim2.fromScale(1, 1)
    currentTab.BackgroundTransparency = 1
    currentTab.Parent = content

    make("TextLabel", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundTransparency = 1,
        Text = name:upper(),
        TextColor3 = purple,
        TextSize = 19,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, currentTab)

    make("TextLabel", {
        Position = UDim2.fromOffset(0, 40),
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundTransparency = 1,
        Text = descriptions[name],
        TextColor3 = Color3.fromRGB(190, 190, 205),
        TextSize = 12,
        TextWrapped = true,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, currentTab)

    make("TextLabel", {
        Position = UDim2.fromOffset(0, 100),
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = panel,
        Text = "STATUS: READY",
        TextColor3 = Color3.fromRGB(120, 230, 160),
        TextSize = 13,
        Font = Enum.Font.GothamBold
    }, currentTab)
end

local tabs = {"Farming", "Player", "Visual", "Settings"}

for i, name in ipairs(tabs) do
    local button = make("TextButton", {
        Size = UDim2.new(1, -12, 0, 42),
        Position = UDim2.fromOffset(6, 7 + (i-1)*49),
        BackgroundColor3 = dark,
        Text = name,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 13,
        Font = Enum.Font.GothamMedium
    }, sidebar)

    make("UICorner", {
        CornerRadius = UDim.new(0, 7)
    }, button)

    button.MouseButton1Click:Connect(function()
        showTab(name)
    end)
end

local dragging = false
local dragStart
local startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then

        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

showTab("Farming")

print("[YanzGong Hub] Initialized successfully.")
