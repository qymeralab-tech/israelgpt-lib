pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("ui") then
        game:GetService("CoreGui").ui:Destroy()
    end
end)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Library = {}
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local Theme = {
    Main = Color3.fromRGB(10, 10, 10),
    Accent = Color3.fromRGB(0, 56, 184),
    Dark = Color3.fromRGB(5, 5, 5),
    Text = Color3.fromRGB(255, 255, 255),
    SecondaryText = Color3.fromRGB(160, 160, 160)
}

function Library:Window(title)
    local ui = Instance.new("ScreenGui")
    ui.Name = "ui"
    ui.Parent = CoreGui
    ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ui.ResetOnSpawn = false
    
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ui
    Main.BackgroundColor3 = Theme.Main
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, -235, 0.5, -141)
    Main.Size = UDim2.new(0, 470, 0, 283)
    Main.Active = true
    Main.ClipsDescendants = true
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Main
    
    local Top = Instance.new("Frame")
    Top.Name = "Top"
    Top.Parent = Main
    Top.BackgroundColor3 = Theme.Dark
    Top.Size = UDim2.new(1, 0, 0, 32)
    
    local Logo = Instance.new("ImageLabel")
    Logo.Parent = Top
    Logo.BackgroundTransparency = 1
    Logo.Position = UDim2.new(0, 8, 0.5, -10)
    Logo.Size = UDim2.new(0, 20, 0, 20)
    Logo.Image = "rbxassetid://16161023815"
    Logo.ImageColor3 = Theme.Accent

    local GameName = Instance.new("TextLabel")
    GameName.Parent = Top
    GameName.BackgroundTransparency = 1
    GameName.Position = UDim2.new(0, 34, 0, 0)
    GameName.Size = UDim2.new(0, 200, 1, 0)
    GameName.Font = Enum.Font.GothamMedium
    GameName.Text = title or "Interface"
    GameName.TextColor3 = Theme.Accent
    GameName.TextSize = 13
    GameName.TextXAlignment = Enum.TextXAlignment.Left

    local dragging, dragInput, dragStart, startPos
    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local MinimizedIcon = Instance.new("ImageButton")
    MinimizedIcon.Parent = ui
    MinimizedIcon.BackgroundColor3 = Theme.Main
    MinimizedIcon.Position = UDim2.new(1, -60, 1, -60)
    MinimizedIcon.Size = UDim2.new(0, 45, 0, 45)
    MinimizedIcon.Visible = false
    MinimizedIcon.Image = "rbxassetid://16161023815"
    MinimizedIcon.ImageColor3 = Theme.Accent
    Instance.new("UICorner", MinimizedIcon)

    local Close = Instance.new("TextButton")
    Close.Parent = Top
    Close.Position = UDim2.new(1, -32, 0, 0)
    Close.Size = UDim2.new(0, 32, 1, 0)
    Close.BackgroundTransparency = 1
    Close.Text = "×"
    Close.TextColor3 = Color3.fromRGB(200, 200, 200)
    Close.TextSize = 20
    Close.MouseButton1Click:Connect(function() ui:Destroy() end)

    local MiniBtn = Instance.new("TextButton")
    MiniBtn.Parent = Top
    MiniBtn.Position = UDim2.new(1, -64, 0, 0)
    MiniBtn.Size = UDim2.new(0, 32, 1, 0)
    MiniBtn.BackgroundTransparency = 1
    MiniBtn.Text = "—"
    MiniBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    MiniBtn.TextSize = 14
    MiniBtn.MouseButton1Click:Connect(function() Main.Visible = false MinimizedIcon.Visible = true end)
    MinimizedIcon.MouseButton1Click:Connect(function() Main.Visible = true MinimizedIcon.Visible = false end)

    local Sidebar = Instance.new("Frame")
    Sidebar.Parent = Main
    Sidebar.BackgroundColor3 = Theme.Dark
    Sidebar.Position = UDim2.new(0, 0, 0, 32)
    Sidebar.Size = UDim2.new(0, 120, 1, -32)
    
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Parent = Sidebar
    TabContainer.Size = UDim2.new(1, 0, 1, 0)
    TabContainer.BackgroundTransparency = 1
    TabContainer.ScrollBarThickness = 0
    local TabList = Instance.new("UIListLayout", TabContainer)
    TabList.Padding = UDim.new(0, 2)

    local PageContainer = Instance.new("Frame")
    PageContainer.Parent = Main
    PageContainer.BackgroundTransparency = 1
    PageContainer.Position = UDim2.new(0, 125, 0, 37)
    PageContainer.Size = UDim2.new(1, -130, 1, -42)

    local TabFunctions = {}
    function TabFunctions:Tab(name)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabContainer
        TabBtn.Size = UDim2.new(1, 0, 0, 30)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.Text = name
        TabBtn.TextColor3 = Theme.SecondaryText
        TabBtn.TextSize = 12

        local Page = Instance.new("ScrollingFrame")
        Page.Parent = PageContainer
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Theme.Accent
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 5)

        TabBtn.MouseButton1Click:Connect(function()
            for _,v in pairs(PageContainer:GetChildren()) do v.Visible = false end
            for _,v in pairs(TabContainer:GetChildren()) do if v:IsA("TextButton") then v.TextColor3 = Theme.SecondaryText end end
            Page.Visible = true
            TabBtn.TextColor3 = Theme.Accent
        end)

        if #PageContainer:GetChildren() == 1 then
            Page.Visible = true
            TabBtn.TextColor3 = Theme.Accent
        end

        local Elements = {}
        function Elements:Button(txt, cb)
            local b = Instance.new("TextButton")
            b.Parent = Page
            b.Size = UDim2.new(1, -10, 0, 30)
            b.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            b.Font = Enum.Font.Gotham
            b.Text = txt
            b.TextColor3 = Theme.Text
            b.TextSize = 12
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
            b.MouseButton1Click:Connect(cb)
        end

        function Elements:Toggle(txt, def, cb)
            local t = Instance.new("TextButton")
            t.Parent = Page
            t.Size = UDim2.new(1, -10, 0, 30)
            t.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            t.Text = ""
            Instance.new("UICorner", t).CornerRadius = UDim.new(0, 3)
            
            local l = Instance.new("TextLabel", t)
            l.Position = UDim2.new(0, 10, 0, 0)
            l.Size = UDim2.new(1, -40, 1, 0)
            l.BackgroundTransparency = 1
            l.Font = Enum.Font.Gotham
            l.Text = txt
            l.TextColor3 = Theme.Text
            l.TextSize = 12
            l.TextXAlignment = "Left"

            local b = Instance.new("Frame", t)
            b.Position = UDim2.new(1, -25, 0.5, -8)
            b.Size = UDim2.new(0, 16, 0, 16)
            b.BackgroundColor3 = def and Theme.Accent or Color3.fromRGB(40, 40, 40)
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)

            local s = def
            t.MouseButton1Click:Connect(function()
                s = not s
                b.BackgroundColor3 = s and Theme.Accent or Color3.fromRGB(40, 40, 40)
                cb(s)
            end)
        end

        return Elements
    end
    return TabFunctions
end

return Library
