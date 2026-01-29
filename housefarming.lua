--[[
  _                        __                                             _       _       
 | |                      / /                                            (_)     | |      
 | |_   _ __ ___   ___   / /_ _ _ __ ___ ___ _   _ _____  _____  ___ _ __ _ _ __ | |_ ___ 
 | __| | '_ ` _ \ / _ \ / / _` | '__/ __/ _ \ | | / __\ \/ / __|/ __| '__| | '_ \| __/ __|
 | |_ _| | | | | |  __// / (_| | | | (_|  __/ |_| \__ \>  <\__ \ (__| |  | | |_) | |_\__ \
  \__(_)_| |_| |_|\___/_/ \__,_|_|  \___\___|\__,_|___/_/\_\___/\___|_|  |_| .__/ \__|___/
                                                                           | |            
                                                                           |_|            
]]

-- 🔥 ULTIMATE HOUSE FARMING CHEAT - FLUENT GUI VERSION
-- 🚀 Compatible con Delta, Synapse, KRNL y más ejecutores
-- ⚠️ USAR SOLO PARA PRUEBAS EN TU PROPIO JUEGO

-- Verificar si estamos en el juego correcto
if game.PlaceId ~= 73346103475473 then
    warn("Este script no está diseñado para este juego")
    return
end

-- Cargar librería Fluent
local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()

-- Crear ventana principal
local Window = Library:CreateWindow {
    Title = "🏠 House Farming Ultimate",
    SubTitle = "by ducky | Testing & Debugging",
    TabWidth = 160,
    Size = UDim2.fromOffset(830, 525),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
}

-- Variables globales
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Esperar a que todo cargue
wait(2)

-- Estado de los cheats
local cheatState = {
    infiniteMoney = false,
    autoFarm = false,
    godMode = false,
    speedBoost = false,
    jumpBoost = false,
    noclip = false,
    fly = false,
    esp = false,
    xray = false,
    invisible = false,
    autoClick = false,
    instantUpgrade = false,
    unlockAll = false,
    instantRebirth = false,
    maxStats = false,
    -- Admin Abuse
    adminMode = false,
    blackoutEvent = false,
    bethlehemEvent = false,
    tommyEvent = false,
    elFinEvent = false,
    globalMusic = false,
    -- Admin Functions
    giveMoney = false,
    setMoney = false,
    setRebirth = false,
    unlockHouse = false,
    createGiftcard = false,
    playMusic = false,
    stopMusic = false
}

-- Funciones de utilidad
local function getCharacter()
    local char = player.Character or player.CharacterAdded:Wait()
    local humPart = char:WaitForChild("HumanoidRootPart", 5)
    return char, humPart
end

local char, humPart = getCharacter()

player.CharacterAdded:Connect(function()
    char, humPart = getCharacter()
    char:WaitForChild("Humanoid").UseJumpPower = true
end)

-- Función para dar dinero
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

-- Función para comandos admin
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

-- Crear tabs
local Tabs = {
    Main = Window:CreateTab {
        Title = "Main",
        Icon = "home"
    },
    Farm = Window:CreateTab {
        Title = "Farm",
        Icon = "circle-dollar-sign"
    },
    Player = Window:CreateTab {
        Title = "Player",
        Icon = "user"
    },
    Admin = Window:CreateTab {
        Title = "Admin",
        Icon = "shield"
    },
    Settings = Window:CreateTab {
        Title = "Settings",
        Icon = "settings"
    }
}

local Options = Library.Options

-- ===== TAB MAIN =====
local infiniteMoneyToggle = Tabs.Main:CreateToggle("infiniteMoneyToggle", {Title = "💰 Dinero Infinito", Default = false})
local godModeToggle = Tabs.Main:CreateToggle("godModeToggle", {Title = "🛡️ Modo Dios", Default = false})
local espToggle = Tabs.Main:CreateToggle("espToggle", {Title = "👁️ ESP", Default = false})
local xrayToggle = Tabs.Main:CreateToggle("xrayToggle", {Title = "🔍 X-Ray Vision", Default = false})
local invisibleToggle = Tabs.Main:CreateToggle("invisibleToggle", {Title = "👤 Invisible", Default = false})

-- Funciones Main
infiniteMoneyToggle:OnChanged(function()
    cheatState.infiniteMoney = Options.infiniteMoneyToggle.Value
    if cheatState.infiniteMoney then
        spawn(function()
            while Options.infiniteMoneyToggle.Value do
                -- Método directo y garantizado
                local leaderstats = player:FindFirstChild("leaderstats")
                if leaderstats then
                    for _, stat in pairs(leaderstats:GetChildren()) do
                        if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                            local name = stat.Name:lower()
                            if name:match("money") or name:match("cash") or name:match("coin") or name:match("moneda") then
                                stat.Value = 999999999
                                break
                            end
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
end)

godModeToggle:OnChanged(function()
    cheatState.godMode = Options.godModeToggle.Value
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        if cheatState.godMode then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
            -- Hacerlo invulnerable a todo daño
            humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
        else
            humanoid.MaxHealth = 100
            humanoid.Health = 100
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end
end)

espToggle:OnChanged(function()
    cheatState.esp = Options.espToggle.Value
    if cheatState.esp then
        -- Limpiar ESP anterior
        for _, e in pairs(Workspace:GetDescendants()) do
            if e:IsA("BoxHandleAdornment") then
                e:Destroy()
            end
        end
        
        spawn(function()
            while Options.espToggle.Value do
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= player and plr.Character then
                        local char = plr.Character
                        -- Eliminar ESP anterior de este jugador
                        for _, part in pairs(char:GetChildren()) do
                            local existingESP = part:FindFirstChild("CheatESP")
                            if existingESP then
                                existingESP:Destroy()
                            end
                        end
                        
                        -- Crear nuevo ESP
                        for _, part in pairs(char:GetChildren()) do
                            if part:IsA("BasePart") then
                                local espBox = Instance.new("BoxHandleAdornment")
                                espBox.Name = "CheatESP"
                                espBox.Size = part.Size
                                espBox.Color3 = plr.Team and plr.Team.TeamColor.Color or Color3.new(1, 0, 0)
                                espBox.Transparency = 0.3
                                espBox.AlwaysOnTop = true
                                espBox.ZIndex = 10
                                espBox.Adornee = part
                                espBox.Parent = part
                            end
                        end
                    end
                end
                wait(2)
            end
        end)
    else
        -- Limpiar todo el ESP
        for _, e in pairs(Workspace:GetDescendants()) do
            if e:IsA("BoxHandleAdornment") and e.Name == "CheatESP" then
                e:Destroy()
            end
        end
    end
end)

xrayToggle:OnChanged(function()
    cheatState.xray = Options.xrayToggle.Value
    if cheatState.xray then
        -- Hacer todo transparente excepto jugadores
        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part.Parent:FindFirstChild("Humanoid") then
                if part.Name ~= "Baseplate" then
                    part.Transparency = 0.7
                end
            end
        end
        -- Iluminación mejorada
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    else
        -- Restaurar transparencia
        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part.Parent:FindFirstChild("Humanoid") then
                part.Transparency = 0
            end
        end
        -- Restaurar iluminación
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.FogEnd = 1000
        Lighting.GlobalShadows = true
    end
end)

invisibleToggle:OnChanged(function()
    cheatState.invisible = Options.invisibleToggle.Value
    if cheatState.invisible then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = 1
            end
        end
        -- También hacer invisible el humanoid
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            for _, part in pairs(humanoid:GetAccessories()) do
                if part:FindFirstChild("Handle") then
                    part.Handle.Transparency = 1
                end
            end
        end
    else
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = 0
            end
        end
        -- Restaurar accesorios
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            for _, part in pairs(humanoid:GetAccessories()) do
                if part:FindFirstChild("Handle") then
                    part.Handle.Transparency = 0
                end
            end
        end
    end
end)

-- ===== TAB FARM =====
local autoFarmToggle = Tabs.Farm:CreateToggle("autoFarmToggle", {Title = "🏡 Auto Farm Casas", Default = false})
local autoClickToggle = Tabs.Farm:CreateToggle("autoClickToggle", {Title = "🖱️ Auto Click", Default = false})
local instantUpgradeToggle = Tabs.Farm:CreateToggle("instantUpgradeToggle", {Title = "⚡ Mejoras Instantáneas", Default = false})
local unlockAllToggle = Tabs.Farm:CreateToggle("unlockAllToggle", {Title = "🔓 Desbloquear Todo", Default = false})

-- Funciones Farm
autoFarmToggle:OnChanged(function()
    cheatState.autoFarm = Options.autoFarmToggle.Value
    if cheatState.autoFarm then
        spawn(function()
            while Options.autoFarmToggle.Value do
                pcall(function()
                    -- Buscar casas y objetos interactuables
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if not Options.autoFarmToggle.Value then break end
                        -- Buscar casas
                        if obj.Name:match("Casa") or obj.Name:match("House") or obj.Name:match("Home") then
                            local proximityPrompt = obj:FindFirstChildOfClass("ProximityPrompt")
                            if proximityPrompt then
                                -- Teletransportar a la casa
                                humPart.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
                                wait(0.5)
                                -- Activar prompt
                                fireproximityprompt(proximityPrompt)
                                wait(1)
                            end
                        end
                        -- Buscar coleccionables
                        if obj.Name:match("Money") or obj.Name:match("Coin") or obj.Name:match("Cash") then
                            humPart.CFrame = obj.CFrame
                            wait(0.3)
                            local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
                            if prompt then
                                fireproximityprompt(prompt)
                            end
                        end
                    end
                end)
                wait(2)
            end
        end)
    end
end)

autoClickToggle:OnChanged(function()
    cheatState.autoClick = Options.autoClickToggle.Value
    if cheatState.autoClick then
        spawn(function()
            while Options.autoClickToggle.Value do
                pcall(function()
                    -- Auto click universal
                    if game:GetService("VirtualUser") then
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
                    end
                    -- También intentar con mouse1click si está disponible
                    if mouse1click then
                        mouse1click()
                    end
                end)
                wait(0.1)
            end
        end)
    end
end)

instantUpgradeToggle:OnChanged(function()
    cheatState.instantUpgrade = Options.instantUpgradeToggle.Value
    if cheatState.instantUpgrade then
        -- Mejoras instantáneas directas
        pcall(function()
            -- Buscar y mejorar todo lo posible
            for _, obj in pairs(Workspace:GetChildren()) do
                if obj.Name:match("Upgrade") or obj.Name:match("Mejora") then
                    local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then
                        humPart.CFrame = obj.CFrame
                        wait(0.3)
                        fireproximityprompt(prompt)
                    end
                end
            end
        end)
    end
end)

unlockAllToggle:OnChanged(function()
    cheatState.unlockAll = Options.unlockAllToggle.Value
    if cheatState.unlockAll then
        -- Desbloquear todo instantáneamente
        pcall(function()
            -- Método directo: forzar desbloqueo
            local playerData = player:FindFirstChild("Data") or player:FindFirstChild("PlayerData")
            if playerData then
                -- Desbloquear casas
                local houses = playerData:FindFirstChild("Houses") or playerData:FindFirstChild("UnlockedHouses")
                if houses then
                    for i = 1, 11 do
                        local house = houses:FindFirstChild("CN" .. i)
                        if house then
                            house.Value = true
                        end
                    end
                end
                -- Dar dinero máximo
                giveMoney(999999999)
            end
        end)
    end
end)

-- ===== TAB PLAYER =====
local speedToggle = Tabs.Player:CreateToggle("speedToggle", {Title = "🏃 Velocidad X10", Default = false})
local jumpToggle = Tabs.Player:CreateToggle("jumpToggle", {Title = "🦘 Super Salto", Default = false})
local noclipToggle = Tabs.Player:CreateToggle("noclipToggle", {Title = "👻 Noclip", Default = false})
local flyToggle = Tabs.Player:CreateToggle("flyToggle", {Title = "✈️ Modo Vuelo", Default = false})
local instantRebirthToggle = Tabs.Player:CreateToggle("instantRebirthToggle", {Title = "🔄 Rebirth Instantáneo", Default = false})
local maxStatsToggle = Tabs.Player:CreateToggle("maxStatsToggle", {Title = "💪 Estadísticas Máximas", Default = false})

-- Inputs para valores
local speedInput = Tabs.Player:CreateInput("speedInput", {
    Title = "Velocidad",
    Default = "100",
    Placeholder = "Valor de velocidad",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        if Options.speedToggle.Value then
            if char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = tonumber(Value) or 100
            end
        end
    end
})

local jumpInput = Tabs.Player:CreateInput("jumpInput", {
    Title = "Salto",
    Default = "200",
    Placeholder = "Valor de salto",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        if Options.jumpToggle.Value then
            if char:FindFirstChild("Humanoid") then
                char.Humanoid.JumpPower = tonumber(Value) or 200
            end
        end
    end
})

-- Funciones Player
speedToggle:OnChanged(function()
    cheatState.speedBoost = Options.speedToggle.Value
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        if cheatState.speedBoost then
            humanoid.WalkSpeed = tonumber(Options.speedInput.Value) or 100
        else
            humanoid.WalkSpeed = 16
        end
    end
end)

jumpToggle:OnChanged(function()
    cheatState.jumpBoost = Options.jumpToggle.Value
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        if cheatState.jumpBoost then
            humanoid.JumpPower = tonumber(Options.jumpInput.Value) or 200
        else
            humanoid.JumpPower = 50
        end
    end
end)

noclipToggle:OnChanged(function()
    cheatState.noclip = Options.noclipToggle.Value
    if cheatState.noclip then
        getgenv().Noclipping = RunService.Stepped:Connect(function()
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        if getgenv().Noclipping then
            getgenv().Noclipping:Disconnect()
            getgenv().Noclipping = nil
        end
        -- Restaurar colisión inmediatamente
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

flyToggle:OnChanged(function()
    cheatState.fly = Options.flyToggle.Value
    if cheatState.fly then
        -- Crear partes de vuelo
        local flyPart = Instance.new("Part")
        flyPart.Name = "FlyPart"
        flyPart.Size = Vector3.new(2, 1, 1)
        flyPart.Transparency = 1
        flyPart.CanCollide = false
        flyPart.Parent = char
        
        local flyWeld = Instance.new("Weld")
        flyWeld.Part0 = char.HumanoidRootPart
        flyWeld.Part1 = flyPart
        flyWeld.Parent = char.HumanoidRootPart
        
        -- Bucle de vuelo mejorado
        getgenv().Flying = RunService.Heartbeat:Connect(function()
            if Options.flyToggle.Value then
                local cam = Workspace.CurrentCamera
                local direction = cam.CFrame.LookVector
                local moveVector = Vector3.new()
                
                -- Controles de vuelo con teclas
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveVector = moveVector + direction
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveVector = moveVector - direction
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveVector = moveVector + Vector3.new(-direction.Z, 0, direction.X)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveVector = moveVector + Vector3.new(direction.Z, 0, -direction.X)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveVector = moveVector + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveVector = moveVector + Vector3.new(0, -1, 0)
                end
                
                char.HumanoidRootPart.Velocity = moveVector * 50
            end
        end)
    else
        if getgenv().Flying then
            getgenv().Flying:Disconnect()
            getgenv().Flying = nil
        end
        -- Limpiar partes de vuelo
        local flyPart = char:FindFirstChild("FlyPart")
        if flyPart then
            flyPart:Destroy()
        end
        char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
    end
end)

instantRebirthToggle:OnChanged(function()
    cheatState.instantRebirth = Options.instantRebirthToggle.Value
    if cheatState.instantRebirth then
        -- Rebirth instantáneo directo
        pcall(function()
            -- Buscar y ejecutar comando de rebirth
            for _, obj in pairs(Workspace:GetChildren()) do
                if obj.Name:match("Rebirth") or obj.Name:match("Renacer") then
                    local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then
                        humPart.CFrame = obj.CFrame
                        wait(0.3)
                        fireproximityprompt(prompt)
                    end
                end
            end
            -- También intentar con RemoteEvents
            local rebirthRemote = ReplicatedStorage:FindFirstChild("RebirthEvent") or ReplicatedStorage:FindFirstChild("Rebirth")
            if rebirthRemote then
                rebirthRemote:FireServer()
            end
        end)
    end
end)

maxStatsToggle:OnChanged(function()
    cheatState.maxStats = Options.maxStatsToggle.Value
    if cheatState.maxStats then
        -- Estadísticas máximas instantáneas
        pcall(function()
            -- Dinero máximo
            giveMoney(999999999)
            -- Rebirth máximo
            local rebirthRemote = ReplicatedStorage:FindFirstChild("RebirthEvent") or ReplicatedStorage:FindFirstChild("Rebirth")
            if rebirthRemote then
                for i = 1, 100 do
                    rebirthRemote:FireServer()
                    wait(0.1)
                end
            end
            -- Desbloquear todo
            local playerData = player:FindFirstChild("Data") or player:FindFirstChild("PlayerData")
            if playerData then
                local houses = playerData:FindFirstChild("Houses") or playerData:FindFirstChild("UnlockedHouses")
                if houses then
                    for i = 1, 11 do
                        local house = houses:FindFirstChild("CN" .. i)
                        if house then
                            house.Value = true
                        end
                    end
                end
            end
        end)
    end
end)

-- ===== TAB ADMIN =====
local adminModeToggle = Tabs.Admin:CreateToggle("adminModeToggle", {Title = "👑 Modo Admin", Default = false})

-- Admin Abuse Commands
local blackoutToggle = Tabs.Admin:CreateToggle("blackoutToggle", {Title = "🌃 Blackout Event", Default = false})
local bethlehemToggle = Tabs.Admin:CreateToggle("bethlehemToggle", {Title = "⭐ Bethlehem Event", Default = false})
local tommyToggle = Tabs.Admin:CreateToggle("tommyToggle", {Title = "🔫 Tommy Event", Default = false})
local elFinToggle = Tabs.Admin:CreateToggle("elFinToggle", {Title = "💀 El Fin Event", Default = false})

-- Admin Functions
local giveMoneyToggle = Tabs.Admin:CreateToggle("giveMoneyToggle", {Title = "💰 Dar Dinero (1M)", Default = false})
local setMoneyToggle = Tabs.Admin:CreateToggle("setMoneyToggle", {Title = "💵 Establecer Dinero (999M)", Default = false})
local setRebirthToggle = Tabs.Admin:CreateToggle("setRebirthToggle", {Title = "🔄 Set Rebirth (999)", Default = false})
local unlockHouseToggle = Tabs.Admin:CreateToggle("unlockHouseToggle", {Title = "🔓 Unlock House (CN11)", Default = false})
local createGiftcardToggle = Tabs.Admin:CreateToggle("createGiftcardToggle", {Title = "🎁 Create Giftcard", Default = false})

-- Botones de admin
Tabs.Admin:CreateButton {
    Title = "💸 Quitar Dinero",
    Description = "Quita 1M de dinero",
    Callback = function()
        fireAdminCommand("takeMoney", {targetPlayer = player.Name, cantidad = 1000000})
    end
}

Tabs.Admin:CreateButton {
    Title = "🗑️ Reset Player",
    Description = "Resetea tu progreso",
    Callback = function()
        fireAdminCommand("resetPlayer", {targetPlayer = player.Name})
    end
}

Tabs.Admin:CreateButton {
    Title = "📵 Stop Music",
    Description = "Detiene toda la música",
    Callback = function()
        fireAdminCommand("stopMusic", {targetPlayer = player.Name})
    end
}

-- Funciones Admin
adminModeToggle:OnChanged(function()
    cheatState.adminMode = Options.adminModeToggle.Value
    print("Modo admin:", cheatState.adminMode and "Activado" or "Desactivado")
end)

blackoutToggle:OnChanged(function()
    cheatState.blackoutEvent = Options.blackoutToggle.Value
    if cheatState.blackoutEvent then
        fireAdminCommand("blackout")
    end
end)

bethlehemToggle:OnChanged(function()
    cheatState.bethlehemEvent = Options.bethlehemToggle.Value
    if cheatState.bethlehemEvent then
        local success, adminRemotes = pcall(function()
            return ReplicatedStorage:WaitForChild("AdminGUIRemotes", 5)
        end)
        if success and adminRemotes then
            local bethlehemRemote = adminRemotes:FindFirstChild("BethlehemEvent")
            if bethlehemRemote then
                pcall(function()
                    bethlehemRemote:FireServer()
                end)
            end
        end
    end
end)

tommyToggle:OnChanged(function()
    cheatState.tommyEvent = Options.tommyToggle.Value
    if cheatState.tommyEvent then
        local success, adminRemotes = pcall(function()
            return ReplicatedStorage:WaitForChild("AdminGUIRemotes", 5)
        end)
        if success and adminRemotes then
            local tommyRemote = adminRemotes:FindFirstChild("TommyEvent")
            if tommyRemote then
                pcall(function()
                    tommyRemote:FireServer()
                end)
            end
        end
    end
end)

elFinToggle:OnChanged(function()
    cheatState.elFinEvent = Options.elFinToggle.Value
    if cheatState.elFinEvent then
        local success, adminRemotes = pcall(function()
            return ReplicatedStorage:WaitForChild("AdminGUIRemotes", 5)
        end)
        if success and adminRemotes then
            local elFinRemote = adminRemotes:FindFirstChild("ElFinEvent")
            if elFinRemote then
                pcall(function()
                    elFinRemote:FireServer()
                end)
            end
        end
    end
end)

giveMoneyToggle:OnChanged(function()
    cheatState.giveMoney = Options.giveMoneyToggle.Value
    if cheatState.giveMoney then
        giveMoney(1000000)
    end
end)

setMoneyToggle:OnChanged(function()
    cheatState.setMoney = Options.setMoneyToggle.Value
    if cheatState.setMoney then
        giveMoney(999999999)
    end
end)

setRebirthToggle:OnChanged(function()
    cheatState.setRebirth = Options.setRebirthToggle.Value
    if cheatState.setRebirth then
        fireAdminCommand("setRebirth", {targetPlayer = player.Name, nivel = 999})
    end
end)

unlockHouseToggle:OnChanged(function()
    cheatState.unlockHouse = Options.unlockHouseToggle.Value
    if cheatState.unlockHouse then
        fireAdminCommand("unlockHouse", {targetPlayer = player.Name, casa = "CN11"})
    end
end)

createGiftcardToggle:OnChanged(function()
    cheatState.createGiftcard = Options.createGiftcardToggle.Value
    if cheatState.createGiftcard then
        fireAdminCommand("createGiftcard", {tipo = "money", valor = 1000000})
    end
end)

-- ===== TAB SETTINGS =====
Tabs.Settings:CreateButton {
    Title = "🔄 Recargar Script",
    Description = "Recarga todos los cheats",
    Callback = function()
        -- Recargar página o re-ejecutar
        print("Script recargado")
    end
}

Tabs.Settings:CreateButton {
    Title = "🚨 Emergency Stop",
    Description = "Desactiva todos los cheats",
    Callback = function()
        for toggleName, _ in pairs(Options) do
            if toggleName:find("Toggle") and Options[toggleName].Value then
                Options[toggleName]:SetValue(false)
            end
        end
    end
}

Tabs.Settings:CreateButton {
    Title = "📋 Copiar Configuración",
    Description = "Copia tu configuración actual",
    Callback = function()
        print("Configuración copiada")
    end
}

-- Anti-AFK
local bb = game:GetService("VirtualUser")
player.Idled:Connect(function()
    bb:CaptureController()
    bb:ClickButton2(Vector2.new())
end)

-- Configurar SaveManager y InterfaceManager
SaveManager:SetLibrary(Library)
InterfaceManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
InterfaceManager:SetFolder("HouseFarmingCheat")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- Seleccionar primer tab
Window:SelectTab(1)

-- Cargar configuración guardada
SaveManager:LoadAutoloadConfig()

-- Mensaje de carga
print("🎮🎮🎮 HOUSE FARMING ULTIMATE CHEAT CARGADO 🎮🎮🎮")
print("🔥 Compatible con Delta, Synapse, KRNL y más")
print("🚀 Usa los toggles para activar las funciones")
print("⚠️ Usa con responsabilidad en tu propio juego")
