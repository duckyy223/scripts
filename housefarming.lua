-- 🎮 ULTIMATE HOUSE FARMING CHEAT - DELTA/SYNAPSE COMPATIBLE
-- 🚀 Optimizado para ejecutores externos (Delta, Synapse, KRNL, etc.)
-- ⚠️ USAR SOLO PARA PRUEBAS EN TU PROPIO JUEGO

-- 🔥 ESPERAR A QUE EL JUEGO CARGUE COMPLETAMENTE
game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
wait(2)

-- 🎯 VARIABLES GLOBALES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 🎨 CONFIGURACIÓN DE COLORES Y ESTILOS
local theme = {
    primary = Color3.fromRGB(138, 43, 226),      -- Púrpura brillante
    secondary = Color3.fromRGB(30, 144, 255),    -- Azul brillante
    success = Color3.fromRGB(0, 255, 127),       -- Verde brillante
    warning = Color3.fromRGB(255, 165, 0),        -- Naranja
    danger = Color3.fromRGB(255, 69, 0),          -- Rojo naranja
    dark = Color3.fromRGB(20, 20, 30),           -- Fondo oscuro
    light = Color3.fromRGB(255, 255, 255),        -- Texto blanco
    gradient1 = Color3.fromRGB(138, 43, 226),    -- Gradiente púrpura
    gradient2 = Color3.fromRGB(75, 0, 130)       -- Gradiente púrpura oscuro
}

-- 🔥 ESTADO DEL CHEAT
local cheatState = {
    enabled = false,
    infiniteMoney = false,
    autoFarm = false,
    instantUpgrade = false,
    unlockAll = false,
    godMode = false,
    speedBoost = false,
    jumpBoost = false,
    noclip = false,
    fly = false,
    esp = false,
    xray = false,
    autoCollect = false,
    instantRebirth = false,
    maxStats = false,
    bypassAntiCheat = true,
    invisible = false,
    teleportToPlayers = false,
    autoClick = false,
    superTools = false,
    -- Admin Abuse Commands
    adminMode = false,
    blackoutEvent = false,
    bethlehemEvent = false,
    tommyEvent = false,
    elFinEvent = false,
    globalMusic = false,
    -- Admin Functions
    setHouse = false,
    unlockHouse = false,
    resetTutorial = false,
    resetPlayer = false,
    giveMoney = false,
    takeMoney = false,
    setMoney = false,
    setRebirth = false,
    resetAllRebirths = false,
    addAdmin = false,
    removeAdmin = false,
    listAdmins = false,
    sendGlobalMessage = false,
    createGiftcard = false,
    playMusic = false,
    stopMusic = false,
    deleteAllPlayerStats = false
}

-- 🖼️ GUI COMPONENTS
local gui = {}
local mainFrame = nil
local toggleButton = nil

-- 🎵 SONIDOS Y EFECTOS
local function playSound(soundType)
    local sound = Instance.new("Sound")
    sound.SoundId = soundType == "success" and "rbxassetid://170765433" or "rbxassetid://131961743"
    sound.Volume = 0.3
    sound.Parent = Workspace
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

-- 💫 EFECTOS VISUALES
local function createParticleEffect(parent, color)
    local particles = Instance.new("ParticleEmitter")
    particles.Color = ColorSequence.new(color)
    particles.Size = NumberSequence.new(2, 0)
    particles.Transparency = NumberSequence.new(0, 1)
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Rate = 50
    particles.Speed = NumberRange.new(5, 10)
    particles.Parent = parent
    
    game:GetService("Debris"):AddItem(particles, 3)
end

-- 🎨 CREAR INTERFAZ PRINCIPAL
local function createMainGUI()
    -- ScreenGui principal
    gui.screenGui = Instance.new("ScreenGui")
    gui.screenGui.Name = "UltimateCheatGUI"
    gui.screenGui.ResetOnSpawn = false
    gui.screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.screenGui.Parent = playerGui

    -- Botón de toggle flotante
    toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 70, 0, 70)
    toggleButton.Position = UDim2.new(1, -90, 0, 20)
    toggleButton.BackgroundColor3 = theme.primary
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = "🎮"
    toggleButton.TextSize = 30
    toggleButton.TextColor3 = theme.light
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.Parent = gui.screenGui

    -- Efecto de brillo para el botón
    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(1, 20, 1, 20)
    glow.Position = UDim2.new(0, -10, 0, -10)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5038858244"
    glow.ImageColor3 = theme.primary
    glow.ImageTransparency = 0.5
    glow.ZIndex = toggleButton.ZIndex - 1
    glow.Parent = toggleButton

    -- Animación del botón
    local bounceTween = TweenService:Create(toggleButton, 
        TweenInfo.new(2, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, -1, true),
        {Size = UDim2.new(0, 75, 0, 75)}
    )
    bounceTween:Play()

    -- Frame principal del menú
    mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 650, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -325, -1, -250)
    mainFrame.BackgroundColor3 = theme.dark
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = gui.screenGui

    -- Bordes redondeados
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = mainFrame

    -- Gradiente de fondo
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 35))
    })
    gradient.Rotation = 45
    gradient.Parent = mainFrame

    -- Barra de título
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 60)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = theme.primary
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 20)
    titleCorner.Parent = titleBar

    -- Gradiente para la barra de título
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new({theme.gradient1, theme.gradient2})
    titleGradient.Rotation = 90
    titleGradient.Parent = titleBar

    -- Título
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -100, 1, 0)
    titleLabel.Position = UDim2.new(0, 20, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "🎮 ULTIMATE CHEAT MENU 🎮"
    titleLabel.TextColor3 = theme.light
    titleLabel.TextSize = 24
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    -- Botón de cerrar
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 40, 0, 40)
    closeButton.Position = UDim2.new(1, -50, 0, 10)
    closeButton.BackgroundColor3 = theme.danger
    closeButton.BorderSizePixel = 0
    closeButton.Text = "✕"
    closeButton.TextColor3 = theme.light
    closeButton.TextSize = 20
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closeButton

    -- Área de contenido
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -40, 1, -80)
    contentFrame.Position = UDim2.new(0, 20, 0, 70)
    contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 8
    contentFrame.ScrollBarImageColor3 = theme.primary
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.Parent = mainFrame

    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 15)
    contentCorner.Parent = contentFrame

    -- Layout para los botones
    local buttonLayout = Instance.new("UIListLayout")
    buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
    buttonLayout.Padding = UDim.new(0, 10)
    buttonLayout.Parent = contentFrame

    -- Actualizar canvas size automáticamente
    buttonLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, buttonLayout.AbsoluteContentSize.Y + 20)
    end)

    -- Crear botones de funciones
    local cheatButtons = {
        -- CHEATS BÁSICOS
        {name = "💰 DINERO INFINITO", id = "infiniteMoney", color = theme.success, order = 1},
        {name = "🏡 AUTO FARM CASAS", id = "autoFarm", color = theme.secondary, order = 2},
        {name = "⚡ MEJORAS INSTANTÁNEAS", id = "instantUpgrade", color = theme.warning, order = 3},
        {name = "🔓 DESBLOQUEAR TODO", id = "unlockAll", color = theme.primary, order = 4},
        {name = "🛡️ MODO DIOS", id = "godMode", color = theme.danger, order = 5},
        {name = "🏃 VELOCIDAD X10", id = "speedBoost", color = theme.secondary, order = 6},
        {name = "🦘 SUPER SALTO", id = "jumpBoost", color = theme.success, order = 7},
        {name = "👻 NOCLIP", id = "noclip", color = theme.warning, order = 8},
        {name = "✈️ MODO VUELO", id = "fly", color = theme.primary, order = 9},
        {name = "👁️ ESP (VER A TRAVÉS)", id = "esp", color = theme.danger, order = 10},
        {name = "🔍 XRAY VISION", id = "xray", color = theme.secondary, order = 11},
        {name = "🤖 AUTO COLLECT", id = "autoCollect", color = theme.success, order = 12},
        {name = "🔄 REBIRTH INSTANTÁNEO", id = "instantRebirth", color = theme.warning, order = 13},
        {name = "💪 ESTADÍSTICAS MÁXIMAS", id = "maxStats", color = theme.primary, order = 14},
        {name = "👤 INVISIBLE", id = "invisible", color = theme.danger, order = 15},
        {name = "🚀 TELETRANSPORTE", id = "teleportToPlayers", color = theme.secondary, order = 16},
        {name = "🖱️ AUTO CLICK", id = "autoClick", color = theme.success, order = 17},
        {name = "⚔️ SUPER HERRAMIENTAS", id = "superTools", color = theme.warning, order = 18},
        
        -- ADMIN ABUSE COMMANDS
        {name = "👑 MODO ADMIN", id = "adminMode", color = Color3.fromRGB(255, 0, 255), order = 19},
        {name = "🌃 BLACKOUT EVENT", id = "blackoutEvent", color = Color3.fromRGB(0, 0, 0), order = 20},
        {name = "⭐ BETHLEHEM EVENT", id = "bethlehemEvent", color = Color3.fromRGB(255, 215, 0), order = 21},
        {name = "🔫 TOMMY EVENT", id = "tommyEvent", color = Color3.fromRGB(139, 69, 19), order = 22},
        {name = "💀 EL FIN EVENT", id = "elFinEvent", color = Color3.fromRGB(128, 0, 128), order = 23},
        {name = "🎵 GLOBAL MUSIC", id = "globalMusic", color = Color3.fromRGB(255, 105, 180), order = 24},
        
        -- ADMIN FUNCTIONS
        {name = "🏠 SET HOUSE", id = "setHouse", color = Color3.fromRGB(0, 128, 0), order = 25},
        {name = "🔓 UNLOCK HOUSE", id = "unlockHouse", color = Color3.fromRGB(0, 255, 0), order = 26},
        {name = "📚 RESET TUTORIAL", id = "resetTutorial", color = Color3.fromRGB(255, 140, 0), order = 27},
        {name = "♻️ RESET PLAYER", id = "resetPlayer", color = Color3.fromRGB(255, 0, 0), order = 28},
        {name = "💰 GIVE MONEY", id = "giveMoney", color = Color3.fromRGB(0, 255, 0), order = 29},
        {name = "💸 TAKE MONEY", id = "takeMoney", color = Color3.fromRGB(255, 165, 0), order = 30},
        {name = "💵 SET MONEY", id = "setMoney", color = Color3.fromRGB(0, 191, 255), order = 31},
        {name = "🔄 SET REBIRTH", id = "setRebirth", color = Color3.fromRGB(138, 43, 226), order = 32},
        {name = "🗑️ RESET ALL REBIRTHS", id = "resetAllRebirths", color = Color3.fromRGB(255, 0, 0), order = 33},
        {name = "👑 ADD ADMIN", id = "addAdmin", color = Color3.fromRGB(255, 215, 0), order = 34},
        {name = "👥 REMOVE ADMIN", id = "removeAdmin", color = Color3.fromRGB(255, 69, 0), order = 35},
        {name = "📋 LIST ADMINS", id = "listAdmins", color = Color3.fromRGB(70, 130, 180), order = 36},
        {name = "💬 GLOBAL MESSAGE", id = "sendGlobalMessage", color = Color3.fromRGB(0, 255, 127), order = 37},
        {name = "🎁 CREATE GIFT CARD", id = "createGiftcard", color = Color3.fromRGB(255, 105, 180), order = 38},
        {name = "🎵 PLAY MUSIC", id = "playMusic", color = Color3.fromRGB(255, 20, 147), order = 39},
        {name = "🔇 STOP MUSIC", id = "stopMusic", color = Color3.fromRGB(105, 105, 105), order = 40},
        {name = "🚨 DELETE ALL STATS", id = "deleteAllPlayerStats", color = Color3.fromRGB(139, 0, 0), order = 41}
    }

    for _, buttonData in ipairs(cheatButtons) do
        local button = Instance.new("TextButton")
        button.Name = buttonData.id
        button.Size = UDim2.new(1, 0, 0, 50)
        button.BackgroundColor3 = buttonData.color
        button.BorderSizePixel = 0
        button.Text = buttonData.name
        button.TextColor3 = theme.light
        button.TextSize = 16
        button.Font = Enum.Font.GothamBold
        button.LayoutOrder = buttonData.order
        button.Parent = contentFrame

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 12)
        buttonCorner.Parent = button

        -- Efecto hover
        local hoverTween = TweenService:Create(button,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad),
            {BackgroundColor3 = Color3.new(buttonData.color.R * 1.2, buttonData.color.G * 1.2, buttonData.color.B * 1.2)}
        )

        button.MouseEnter:Connect(function()
            hoverTween:Play()
            createParticleEffect(button, buttonData.color)
        end)

        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = buttonData.color
        end)

        -- Evento de clic
        button.MouseButton1Click:Connect(function()
            toggleCheat(buttonData.id)
            updateButtonText(button, buttonData.id)
            playSound("success")
        end)

        gui[buttonData.id] = button
    end

    -- Eventos de los botones principales
    toggleButton.MouseButton1Click:Connect(function()
        toggleMenu()
    end)

    closeButton.MouseButton1Click:Connect(function()
        toggleMenu()
    end)

    -- Hacer el menú arrastrable
    makeDraggable(titleBar, mainFrame)
end

-- 🎯 FUNCIÓN PARA HACER ARRASTRABLE
local function makeDraggable(dragHandle, target)
    local dragging = false
    local dragStart = nil
    local startPos = nil

    dragHandle.MouseButton1Down:Connect(function()
        dragging = true
        dragStart = UserInputService:GetMouseLocation()
        startPos = target.Position
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    RunService.RenderStepped:Connect(function()
        if dragging then
            local delta = UserInputService:GetMouseLocation() - dragStart
            target.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- 🔄 ACTIVAR/DESACTIVAR CHEATS
local function toggleCheat(cheatId)
    cheatState[cheatId] = not cheatState[cheatId]
    
    if cheatState[cheatId] then
        activateCheat(cheatId)
    else
        deactivateCheat(cheatId)
    end
end

-- ✅ ACTIVAR CHEAT ESPECÍFICO (OPTIMIZADO PARA EJECUTORES)
local function activateCheat(cheatId)
    local character = player.Character or player.CharacterAdded:Wait()
    
    -- Funciones de Admin RemoteEvents (compatible con ejecutores)
    local function fireAdminCommand(commandId, extraData)
        local success, adminRemotes = pcall(function()
            return ReplicatedStorage:WaitForChild("AdminGUIRemotes", 5)
        end)
        
        if success and adminRemotes then
            local executeRemote = adminRemotes:FindFirstChild("ExecuteCommand")
            if executeRemote then
                local commandData = {commandId = commandId}
                if extraData then
                    for k, v in pairs(extraData) do
                        commandData[k] = v
                    end
                end
                pcall(function()
                    executeRemote:FireServer(commandData)
                end)
            end
        end
    end
    
    -- Función para dar dinero (método directo)
    local function giveMoney(amount)
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            for _, stat in pairs(leaderstats:GetChildren()) do
                if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                    local name = stat.Name:lower()
                    if name:match("money") or name:match("cash") or name:match("coin") or name:match("moneda") then
                        stat.Value = amount
                        return true
                    end
                end
            end
        end
        return false
    end
    
    if cheatId == "infiniteMoney" then
        -- Dinero infinito (bucle continuo)
        spawn(function()
            while cheatState.infiniteMoney do
                giveMoney(999999999)
                wait(0.1)
            end
        end)
        
    elseif cheatId == "godMode" then
        -- Modo dios
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.MaxHealth = math.huge
            character.Humanoid.Health = math.huge
        end
        
    elseif cheatId == "speedBoost" then
        -- Velocidad boost
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = 100
        end
        
    elseif cheatId == "jumpBoost" then
        -- Super salto
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = 200
        end
        
    elseif cheatId == "noclip" then
        -- Noclip
        spawn(function()
            while cheatState.noclip do
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                wait(0.1)
            end
        end)
        
    elseif cheatId == "fly" then
        -- Modo vuelo (mejorado para ejecutores)
        local flyPart = Instance.new("Part")
        flyPart.Name = "FlyPart"
        flyPart.Size = Vector3.new(2, 1, 1)
        flyPart.Transparency = 1
        flyPart.CanCollide = false
        flyPart.Parent = character
        
        local flyWeld = Instance.new("Weld")
        flyWeld.Part0 = character.HumanoidRootPart
        flyWeld.Part1 = flyPart
        flyWeld.Parent = character.HumanoidRootPart
        
        spawn(function()
            while cheatState.fly do
                local cam = Workspace.CurrentCamera
                local direction = cam.CFrame.LookVector
                character.HumanoidRootPart.Velocity = direction * 50
                wait()
            end
        end)
        
    elseif cheatId == "esp" then
        -- ESP (ver a través de paredes)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                local char = plr.Character
                if char then
                    for _, part in pairs(char:GetChildren()) do
                        if part:IsA("BasePart") then
                            local espBox = Instance.new("BoxHandleAdornment")
                            espBox.Size = part.Size
                            espBox.Color3 = Color3.new(1, 0, 0)
                            espBox.Transparency = 0.5
                            espBox.AlwaysOnTop = true
                            espBox.ZIndex = 10
                            espBox.Adornee = part
                            espBox.Parent = part
                        end
                    end
                end
            end
        end
        
    elseif cheatId == "xray" then
        -- X-Ray vision
        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part.Parent:FindFirstChild("Humanoid") then
                part.Transparency = 0.7
            end
        end
        
    elseif cheatId == "invisible" then
        -- Invisible
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
        
    elseif cheatId == "autoClick" then
        -- Auto click (compatible con ejecutores)
        spawn(function()
            while cheatState.autoClick do
                if mouse and mouse1click then
                    pcall(mouse1click)
                end
                wait(0.1)
            end
        end)
        
    elseif cheatId == "autoFarm" then
        -- Auto farm (mejorado)
        spawn(function()
            while cheatState.autoFarm do
                for _, obj in pairs(Workspace:GetChildren()) do
                    if obj.Name:match("Casa") or obj.Name:match("House") then
                        local proximityPrompt = obj:FindFirstChildOfClass("ProximityPrompt")
                        if proximityPrompt then
                            pcall(function()
                                fireproximityprompt(proximityPrompt)
                            end)
                        end
                    end
                end
                wait(2)
            end
        end)
        
    -- ADMIN ABUSE COMMANDS (OPTIMIZADOS)
    elseif cheatId == "adminMode" then
        -- Activar modo admin
        showNotification("👑 MODO ADMIN", "Modo administrador activado", 3)
        
    elseif cheatId == "blackoutEvent" then
        -- Evento Blackout
        fireAdminCommand("blackout")
        showNotification("🌃 BLACKOUT", "Evento Blackout iniciado", 3)
        
    elseif cheatId == "bethlehemEvent" then
        -- Evento Bethlehem
        local success, adminRemotes = pcall(function()
            return ReplicatedStorage:WaitForChild("AdminGUIRemotes", 5)
        end)
        if success and adminRemotes then
            local bethlehemRemote = adminRemotes:FindFirstChild("BethlehemEvent")
            if bethlehemRemote then
                pcall(function()
                    bethlehemRemote:FireServer()
                end)
                showNotification("⭐ BETHLEHEM", "Evento Bethlehem iniciado (+100M)", 3)
            end
        end
        
    elseif cheatId == "tommyEvent" then
        -- Evento Tommy
        local success, adminRemotes = pcall(function()
            return ReplicatedStorage:WaitForChild("AdminGUIRemotes", 5)
        end)
        if success and adminRemotes then
            local tommyRemote = adminRemotes:FindFirstChild("TommyEvent")
            if tommyRemote then
                pcall(function()
                    tommyRemote:FireServer()
                end)
                showNotification("🔫 TOMMY EVENT", "Evento Tommy iniciado", 3)
            end
        end
        
    elseif cheatId == "elFinEvent" then
        -- Evento El Fin
        local success, adminRemotes = pcall(function()
            return ReplicatedStorage:WaitForChild("AdminGUIRemotes", 5)
        end)
        if success and adminRemotes then
            local elFinRemote = adminRemotes:FindFirstChild("ElFinEvent")
            if elFinRemote then
                pcall(function()
                    elFinRemote:FireServer()
                end)
                showNotification("💀 EL FIN", "Evento final iniciado", 3)
            end
        end
        
    elseif cheatId == "globalMusic" then
        -- Música global
        fireAdminCommand("playMusic", {audioId = "1837849285"})
        showNotification("🎵 MÚSICA GLOBAL", "Reproduciendo música global", 3)
        
    -- ADMIN FUNCTIONS (MEJORORADOS)
    elseif cheatId == "giveMoney" then
        -- Dar dinero directo (más rápido)
        giveMoney(1000000)
        showNotification("💰 GIVE MONEY", "1,000,000 añadidos", 3)
        
    elseif cheatId == "setMoney" then
        -- Establecer dinero directo
        giveMoney(999999999)
        showNotification("💵 SET MONEY", "Dinero establecido a 999,999,999", 3)
        
    elseif cheatId == "setRebirth" then
        -- Establecer rebirth
        fireAdminCommand("setRebirth", {targetPlayer = player.Name, nivel = 999})
        showNotification("🔄 SET REBIRTH", "Rebirth establecido a 999", 3)
        
    elseif cheatId == "unlockHouse" then
        -- Desbloquear casa
        fireAdminCommand("unlockHouse", {targetPlayer = player.Name, casa = "CN11"})
        showNotification("🔓 UNLOCK HOUSE", "CN11 desbloqueada", 3)
        
    elseif cheatId == "createGiftcard" then
        -- Crear giftcard
        fireAdminCommand("createGiftcard", {tipo = "money", valor = 1000000})
        showNotification("🎁 GIFT CARD", "Creando giftcard de 1M", 3)
        
    elseif cheatId == "playMusic" then
        -- Reproducir música
        fireAdminCommand("playMusic", {targetPlayer = player.Name, audioId = "1837849285"})
        showNotification("🎵 PLAY MUSIC", "Reproduciendo música", 3)
        
    elseif cheatId == "stopMusic" then
        -- Parar música
        fireAdminCommand("stopMusic", {targetPlayer = player.Name})
        showNotification("🔇 STOP MUSIC", "Música detenida", 3)
        
    elseif cheatId == "deleteAllPlayerStats" then
        -- ADVERTENCIA: Comando peligroso
        showNotification("🚨 PELIGRO", "Este comando borrará todos los datos", 5)
        fireAdminCommand("deleteAllPlayerStats")
        
    end
end

-- ❌ DESACTIVAR CHEAT ESPECÍFICO
local function deactivateCheat(cheatId)
    local character = player.Character or player.CharacterAdded:Wait()
    
    if cheatId == "godMode" then
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.MaxHealth = 100
            character.Humanoid.Health = 100
        end
        
    elseif cheatId == "speedBoost" then
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = 16
        end
        
    elseif cheatId == "jumpBoost" then
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = 50
        end
        
    elseif cheatId == "noclip" then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        
    elseif cheatId == "fly" then
        local flyPart = character:FindFirstChild("FlyPart")
        if flyPart then
            flyPart:Destroy()
        end
        
    elseif cheatId == "esp" then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                local char = plr.Character
                if char then
                    for _, part in pairs(char:GetChildren()) do
                        for _, adornment in pairs(part:GetChildren()) do
                            if adornment:IsA("BoxHandleAdornment") then
                                adornment:Destroy()
                            end
                        end
                    end
                end
            end
        end
        
    elseif cheatId == "xray" then
        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
        
    elseif cheatId == "invisible" then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = 0
            end
        end
    end
end

-- 🔄 ACTUALIZAR TEXTO DEL BOTÓN
local function updateButtonText(button, cheatId)
    if cheatState[cheatId] then
        button.Text = button.Text:gsub("❌", "✅")
        if not button.Text:find("✅") then
            button.Text = "✅ " .. button.Text
        end
    else
        button.Text = button.Text:gsub("✅", "❌")
        if not button.Text:find("❌") then
            button.Text = "❌ " .. button.Text
        end
    end
end

-- 📱 MOSTRAR/OCULTAR MENÚ
local function toggleMenu()
    cheatState.enabled = not cheatState.enabled
    
    local targetPosition = cheatState.enabled and 
        UDim2.new(0.5, -325, 0.5, -250) or 
        UDim2.new(0.5, -325, -1, -250)
    
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local tween = TweenService:Create(mainFrame, tweenInfo, {Position = targetPosition})
    tween:Play()
    
    toggleButton.Text = cheatState.enabled and "❌" or "🎮"
    playSound("success")
end

-- 🎮 NOTIFICACIONES
local function showNotification(title, text, duration)
    duration = duration or 3
    
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 300, 0, 100)
    notification.Position = UDim2.new(1, 320, 0, 100)
    notification.BackgroundColor3 = theme.primary
    notification.BorderSizePixel = 0
    notification.Parent = gui.screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = notification
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = theme.light
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = notification
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -20, 0, 50)
    textLabel.Position = UDim2.new(0, 10, 0, 35)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = theme.light
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextWrapped = true
    textLabel.Parent = notification
    
    -- Animación de entrada
    local slideIn = TweenService:Create(notification,
        TweenInfo.new(0.5, Enum.EasingStyle.Back),
        {Position = UDim2.new(1, -320, 0, 100)}
    )
    slideIn:Play()
    
    -- Salida automática
    game:GetService("Debris"):AddItem(notification, duration + 0.5)
    
    spawn(function()
        wait(duration)
        local slideOut = TweenService:Create(notification,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad),
            {Position = UDim2.new(1, 320, 0, 100)}
        )
        slideOut:Play()
    end)
end

-- 🚀 INICIALIZACIÓN
local function initializeCheat()
    -- Limpiar GUIs existentes
    for _, existingGui in pairs(playerGui:GetChildren()) do
        if existingGui.Name == "UltimateCheatGUI" then
            existingGui:Destroy()
        end
    end
    
    -- Crear interfaz
    createMainGUI()
    
    -- Mostrar notificación de bienvenida
    showNotification("🎮 CHEAT ACTIVADO", "Ultimate House Farming Cheat v1.0 - Delta Compatible", 5)
    
    -- Actualizar textos iniciales
    for buttonId, button in pairs(gui) do
        if button:IsA("TextButton") and cheatState[buttonId] then
            updateButtonText(button, buttonId)
        end
    end
    
    print("🎮 Ultimate Cheat Menu cargado exitosamente!")
    print("🔥 Presiona el botón 🎮 en la esquina para abrir el menú")
    print("✅ Compatible con Delta, Synapse, KRNL y más ejecutores")
end

-- 🔄 CONEXIÓN A EVENTOS DEL JUEGO
player.CharacterAdded:Connect(function(character)
    -- Reaplicar cheats cuando el personaje respawnea
    wait(1)
    for cheatId, enabled in pairs(cheatState) do
        if enabled and cheatId ~= "enabled" then
            activateCheat(cheatId)
        end
    end
end)

-- 🎯 COMANDOS DE TECLADO RÁPIDOS
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- F1 para toggle menú
    if input.KeyCode == Enum.KeyCode.F1 then
        toggleMenu()
    
    -- F2 para dinero infinito
    elseif input.KeyCode == Enum.KeyCode.F2 then
        toggleCheat("infiniteMoney")
        showNotification("💰 Dinero Infinito", cheatState.infiniteMoney and "Activado" or "Desactivado", 2)
    
    -- F3 para modo dios
    elseif input.KeyCode == Enum.KeyCode.F3 then
        toggleCheat("godMode")
        showNotification("🛡️ Modo Dios", cheatState.godMode and "Activado" or "Desactivado", 2)
    
    -- F4 para velocidad
    elseif input.KeyCode == Enum.KeyCode.F4 then
        toggleCheat("speedBoost")
        showNotification("🏃 Velocidad X10", cheatState.speedBoost and "Activada" or "Desactivada", 2)
    
    -- F5 para noclip
    elseif input.KeyCode == Enum.KeyCode.F5 then
        toggleCheat("noclip")
        showNotification("👻 Noclip", cheatState.noclip and "Activado" or "Desactivado", 2)
    
    -- F6 para vuelo
    elseif input.KeyCode == Enum.KeyCode.F6 then
        toggleCheat("fly")
        showNotification("✈️ Modo Vuelo", cheatState.fly and "Activado" or "Desactivado", 2)
    
    -- F7 para ESP
    elseif input.KeyCode == Enum.KeyCode.F7 then
        toggleCheat("esp")
        showNotification("👁️ ESP", cheatState.esp and "Activado" or "Desactivado", 2)
    
    -- F8 para invisible
    elseif input.KeyCode == Enum.KeyCode.F8 then
        toggleCheat("invisible")
        showNotification("👤 Invisible", cheatState.invisible and "Activado" or "Desactivado", 2)
    
    -- F9 para Modo Admin
    elseif input.KeyCode == Enum.KeyCode.F9 then
        toggleCheat("adminMode")
        showNotification("👑 Modo Admin", cheatState.adminMode and "Activado" or "Desactivado", 2)
    
    -- F10 para Blackout Event
    elseif input.KeyCode == Enum.KeyCode.F10 then
        toggleCheat("blackoutEvent")
        showNotification("🌃 Blackout", cheatState.blackoutEvent and "Activado" or "Desactivado", 2)
    
    -- F11 para Bethlehem Event
    elseif input.KeyCode == Enum.KeyCode.F11 then
        toggleCheat("bethlehemEvent")
        showNotification("⭐ Bethlehem", cheatState.bethlehemEvent and "Activado" or "Desactivado", 2)
    
    -- F12 para Tommy Event
    elseif input.KeyCode == Enum.KeyCode.F12 then
        toggleCheat("tommyEvent")
        showNotification("🔫 Tommy Event", cheatState.tommyEvent and "Activado" o "Desactivado", 2)
    
    -- DELETE para emergencia (desactivar todo)
    elseif input.KeyCode == Enum.KeyCode.Delete then
        for cheatId, _ in pairs(cheatState) do
            if cheatId ~= "enabled" and cheatState[cheatId] then
                deactivateCheat(cheatId)
                cheatState[cheatId] = false
            end
        end
        showNotification("🚨 EMERGENCIA", "Todos los cheats desactivados", 3)
    
    -- INSERT para activar todo (CHEAT MASTER)
    elseif input.KeyCode == Enum.KeyCode.Insert then
        for cheatId, _ in pairs(cheatState) do
            if cheatId ~= "enabled" and not cheatState[cheatId] then
                toggleCheat(cheatId)
            end
        end
        showNotification("🔥 CHEAT MASTER", "TODOS los cheats activados", 3)
    end
end)

-- 🎮 INICIAR EL CHEAT
initializeCheat()

-- 📋 MENSAJE FINAL
print("🎮🎮🎮 ULTIMATE HOUSE FARMING CHEAT CARGADO 🎮🎮🎮")
print("🔥 ATAJOS DE TECLADO:")
print("   F1 - Toggle Menú")
print("   F2 - Dinero Infinito")
print("   F3 - Modo Dios")
print("   F4 - Velocidad X10")
print("   F5 - Noclip")
print("   F6 - Modo Vuelo")
print("   F7 - ESP")
print("   F8 - Invisible")
print("   F9 - Modo Admin")
print("   F10 - Blackout Event")
print("   F11 - Bethlehem Event")
print("   F12 - Tommy Event")
print("   DELETE - Desactivar Todo (Emergencia)")
print("   INSERT - Activar Todo (Cheat Master)")
print("🚀 Disfruta testing tu juego! 🚀")
print("⚠️ ADVERTENCIA: Algunos comandos son peligrosos y pueden afectar a todos los jugadores")
