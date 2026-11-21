
--====================================================
-- BAD BOYS | JK PANEL V2.0
-- BEAR FACTION EDITION
--====================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "BAD_BOYS_JK_V2"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local BLACK = Color3.fromRGB(8,8,8)
local DARK = Color3.fromRGB(20,20,20)
local RED = Color3.fromRGB(190,15,25)
local WHITE = Color3.fromRGB(255,255,255)

-- CHAT
local function sendChat(message)
    local success, err = pcall(function()
        local channels = TextChatService:WaitForChild("TextChannels")
        local channel = channels:FindFirstChild("RBXGeneral")

        if not channel then
            for _,v in ipairs(channels:GetChildren()) do
                if v:IsA("TextChannel") then
                    channel = v
                    break
                end
            end
        end

        assert(channel, "Canal de chat não encontrado")
        channel:SendAsync(message)
    end)

    if not success then
        warn("BAD BOYS CHAT: ", err)
    end
end

-- DRAG
local function drag(object, handle)
    local active = false
    local moved = false
    local startPosition
    local startInput
    local lastInput

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            active = true
            moved = false
            startInput = input.Position
            startPosition = object.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    active = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if active and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            lastInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if active and lastInput == input then
            local delta = input.Position - startInput

            if delta.Magnitude > 5 then
                moved = true
            end

            object.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)

    return function()
        return moved
    end
end

-- BOLINHA JK
local ball = Instance.new("TextButton")
ball.Size = UDim2.fromOffset(52,52)
ball.Position = UDim2.new(0,25,0.4,0)
ball.BackgroundColor3 = BLACK
ball.Text = "JK"
ball.TextColor3 = WHITE
ball.Font = Enum.Font.GothamBlack
ball.TextSize = 19
ball.AutoButtonColor = false
ball.Parent = gui

Instance.new("UICorner",ball).CornerRadius = UDim.new(1,0)

local ballStroke = Instance.new("UIStroke",ball)
ballStroke.Color = RED
ballStroke.Thickness = 2

local wasMoved = drag(ball,ball)

-- PAINEL
local panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(215,360)
panel.Position = UDim2.new(0,90,0.3,0)
panel.BackgroundColor3 = BLACK
panel.Visible = false
panel.Parent = gui

Instance.new("UICorner",panel).CornerRadius = UDim.new(0,12)

local outline = Instance.new("UIStroke",panel)
outline.Color = RED
outline.Thickness = 1.5

-- CABEÇALHO
local header = Instance.new("Frame")
header.Size = UDim2.new(1,0,0,65)
header.BackgroundColor3 = DARK
header.Parent = panel

Instance.new("UICorner",header).CornerRadius = UDim.new(0,10)

local banner = Instance.new("TextLabel")
banner.Size = UDim2.new(1,-38,0,30)
banner.Position = UDim2.fromOffset(8,4)
banner.BackgroundTransparency = 1
banner.Text = "🐻 BAD BOYS"
banner.TextColor3 = RED
banner.Font = Enum.Font.GothamBlack
banner.TextSize = 18
banner.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1,-10,0,18)
subtitle.Position = UDim2.fromOffset(5,36)
subtitle.BackgroundTransparency = 1
subtitle.Text = "JK PANEL V2.0 | FACTION"
subtitle.TextColor3 = WHITE
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 9
subtitle.Parent = header

drag(panel,header)

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(27,27)
close.Position = UDim2.new(1,-32,0,5)
close.BackgroundColor3 = RED
close.Text = "X"
close.TextColor3 = WHITE
close.Font = Enum.Font.GothamBold
close.TextSize = 12
close.Parent = header

Instance.new("UICorner",close).CornerRadius = UDim.new(0,6)

close.Activated:Connect(function()
    panel.Visible = false
end)

-- CONTEÚDO
local content = Instance.new("ScrollingFrame")
content.Position = UDim2.fromOffset(9,73)
content.Size = UDim2.new(1,-18,1,-82)
content.BackgroundTransparency = 1
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = RED
content.CanvasSize = UDim2.new(0,0,0,0)
content.Parent = panel

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,7)
layout.Parent = content

local function label(text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,0,0,20)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = RED
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = content
end

local function makeButton(name, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,0,0,34)
    b.BackgroundColor3 = DARK
    b.Text = name
    b.TextColor3 = WHITE
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.AutoButtonColor = true
    b.Parent = content

    Instance.new("UICorner",b).CornerRadius = UDim.new(0,6)

    local s = Instance.new("UIStroke",b)
    s.Color = Color3.fromRGB(75,25,25)

    b.Activated:Connect(callback)
    return b
end

-- SISTEMA MAT / REGIÃO
label("  SISTEMA DE REGIÕES")

local region = Instance.new("TextBox")
region.Size = UDim2.new(1,0,0,35)
region.BackgroundColor3 = DARK
region.Text = ""
region.PlaceholderText = "Digite a região..."
region.PlaceholderColor3 = Color3.fromRGB(150,150,150)
region.TextColor3 = WHITE
region.Font = Enum.Font.Gotham
region.TextSize = 11
region.ClearTextOnFocus = false
region.Parent = content

Instance.new("UICorner",region).CornerRadius = UDim.new(0,6)

makeButton("🐻 ENVIAR MAT - FAL NUTELADO",function()
    local area = region.Text:gsub("[%c]", ""):sub(1,40)

    if area:gsub("%s","") == "" then
        warn("Digite uma região!")
        return
    end

    sendChat("/Mat [FAL - NUTELADO] (" .. area .. ")")
end)

-- COMANDOS
label("  COMANDOS DO RP")

local commands = {
    "/render",
    "/tracer",
    "/bazuca",
    "/patrulha",
    "/reforco",
    "/base",
    "/retirada",
    "/socorro",
    "/recrutar"
}

for _,command in ipairs(commands) do
    makeButton(command:upper(),function()
        sendChat(command)
    end)
end

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    content.CanvasSize = UDim2.new(
        0,0,0,layout.AbsoluteContentSize.Y + 10
    )
end)

-- ABRIR E FECHAR
local opened = false

ball.Activated:Connect(function()
    if wasMoved() then return end

    opened = not opened

    if opened then
        panel.Visible = true
        panel.Size = UDim2.fromOffset(215,0)

        TweenService:Create(
            panel,
            TweenInfo.new(0.25,Enum.EasingStyle.Back),
            {Size = UDim2.fromOffset(215,360)}
        ):Play()
    else
        panel.Visible = false
    end
end)

print("🐻 BAD BOYS | JK PANEL V2.0 carregado!")
