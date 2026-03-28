-- Five Nights: Hunted Script für Xenon
-- Geschwindigkeitsregler, Barrieren-Deaktivierer, Fliegen und NoClip

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- GUI Erstellung
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 300, 0, 360)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.new(0, 1, 0)
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "F.N. Hunted - Multi-Hack"
Title.TextColor3 = Color3.new(0, 1, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = MainFrame
SpeedLabel.Size = UDim2.new(0, 100, 0, 20)
SpeedLabel.Position = UDim2.new(0, 10, 0, 40)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: 1.0"
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextSize = 14

local SpeedSlider = Instance.new("TextButton")
SpeedSlider.Parent = MainFrame
SpeedSlider.Size = UDim2.new(0, 200, 0, 20)
SpeedSlider.Position = UDim2.new(0, 50, 0, 65)
SpeedSlider.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
SpeedSlider.BorderSizePixel = 1
SpeedSlider.BorderColor3 = Color3.new(0, 1, 0)
SpeedSlider.Text = ""
SpeedSlider.AutoButtonColor = false

local FlyButton = Instance.new("TextButton")
FlyButton.Parent = MainFrame
FlyButton.Size = UDim2.new(0, 200, 0, 30)
FlyButton.Position = UDim2.new(0, 50, 0, 100)
FlyButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
FlyButton.BorderSizePixel = 1
FlyButton.BorderColor3 = Color3.new(0, 1, 0)
FlyButton.Text = "Fliegen: AUS"
FlyButton.TextColor3 = Color3.new(1, 0, 0)
FlyButton.Font = Enum.Font.SourceSansBold
FlyButton.TextSize = 16

local NoClipButton = Instance.new("TextButton")
NoClipButton.Parent = MainFrame
NoClipButton.Size = UDim2.new(0, 200, 0, 30)
NoClipButton.Position = UDim2.new(0, 50, 0, 140)
NoClipButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
NoClipButton.BorderSizePixel = 1
NoClipButton.BorderColor3 = Color3.new(0, 1, 0)
NoClipButton.Text = "NoClip: AUS"
NoClipButton.TextColor3 = Color3.new(1, 0, 0)
NoClipButton.Font = Enum.Font.SourceSansBold
NoClipButton.TextSize = 16

local BarrierButton = Instance.new("TextButton")
BarrierButton.Parent = MainFrame
BarrierButton.Size = UDim2.new(0, 200, 0, 30)
BarrierButton.Position = UDim2.new(0, 50, 0, 180)
BarrierButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
BarrierButton.BorderSizePixel = 1
BarrierButton.BorderColor3 = Color3.new(0, 1, 0)
BarrierButton.Text = "Barrieren: AKTIV"
BarrierButton.TextColor3 = Color3.new(1, 0, 0)
BarrierButton.Font = Enum.Font.SourceSansBold
BarrierButton.TextSize = 16

-- NEU: ESP Button
local ESPButton = Instance.new("TextButton")
ESPButton.Parent = MainFrame
ESPButton.Size = UDim2.new(0, 200, 0, 30)
ESPButton.Position = UDim2.new(0, 50, 0, 220)
ESPButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
ESPButton.BorderSizePixel = 1
ESPButton.BorderColor3 = Color3.new(0, 1, 0)
ESPButton.Text = "ESP: AUS"
ESPButton.TextColor3 = Color3.new(1, 0, 0)
ESPButton.Font = Enum.Font.SourceSansBold
ESPButton.TextSize = 16

-- NEU: Insta-Kill Button
local InstaKillButton = Instance.new("TextButton")
InstaKillButton.Parent = MainFrame
InstaKillButton.Size = UDim2.new(0, 200, 0, 30)
InstaKillButton.Position = UDim2.new(0, 50, 0, 260) -- Position unter dem ESP-Button
InstaKillButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
InstaKillButton.BorderSizePixel = 1
InstaKillButton.BorderColor3 = Color3.new(0, 1, 0)
InstaKillButton.Text = "Insta-Kill: AUS"
InstaKillButton.TextColor3 = Color3.new(1, 0, 0)
InstaKillButton.Font = Enum.Font.SourceSansBold
InstaKillButton.TextSize = 16

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Color3.new(0.5, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18

-- ==================== NEUE SPIELERLISTEN-GUI ====================
local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Parent = ScreenGui
PlayerListFrame.Size = UDim2.new(0, 200, 0, 300)
PlayerListFrame.Position = UDim2.new(0, 10, 0.5, -150) -- Links vom Hauptfenster
PlayerListFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
PlayerListFrame.BorderSizePixel = 2
PlayerListFrame.BorderColor3 = Color3.new(0, 1, 0)
PlayerListFrame.Active = true
PlayerListFrame.Draggable = true

local PlayerListTitle = Instance.new("TextLabel")
PlayerListTitle.Parent = PlayerListFrame
PlayerListTitle.Size = UDim2.new(1, 0, 0, 30)
PlayerListTitle.Position = UDim2.new(0, 0, 0, 0)
PlayerListTitle.BackgroundTransparency = 1
PlayerListTitle.Text = "Target Follow"
PlayerListTitle.TextColor3 = Color3.new(0, 1, 0)
PlayerListTitle.Font = Enum.Font.SourceSansBold
PlayerListTitle.TextSize = 16

-- ScrollingFrame für die Liste der Spieler
local PlayerScrollingFrame = Instance.new("ScrollingFrame")
PlayerScrollingFrame.Parent = PlayerListFrame
PlayerScrollingFrame.Size = UDim2.new(1, -10, 1, -40)
PlayerScrollingFrame.Position = UDim2.new(0, 5, 0, 35)
PlayerScrollingFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
PlayerScrollingFrame.BorderSizePixel = 0
PlayerScrollingFrame.ScrollBarThickness = 8
PlayerScrollingFrame.ScrollBarImageColor3 = Color3.new(0, 1, 0)

-- Layout, um die Buttons automatisch zu sortieren
local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Parent = PlayerScrollingFrame
PlayerListLayout.SortOrder = Enum.SortOrder.Name
PlayerListLayout.Padding = UDim.new(0, 2)

-- Tabelle zum Speichern der Spieler-Buttons
local playerButtons = {}

-- Variablen
local speedValue = 1.0
local barriersEnabled = true
local isDragging = false
local barrierParts = {}
local flying = false
local noClipEnabled = false
local flySpeed = 50
local bodyVelocity
local bodyGyro
-- NEU: ESP Variablen
local espEnabled = false
local espConnections = {}
local espObjects = {}
local instaKillEnabled = false
-- NEU: Target-Follow Variablen
local targetPlayer = nil
local isFollowing = false
local followConnection = nil

-- Geschwindigkeitsfunktion
local function updateSpeed()
    if Humanoid then
        Humanoid.WalkSpeed = 16 * speedValue
    end
    SpeedLabel.Text = "Speed: " .. string.format("%.1f", speedValue)
end


-- NEU: ESP Funktionen
local function createESP(player)
    if espObjects[player] then return end -- Verhindert doppelte Erstellung

    local character = player.Character
    if not character then return end

    espObjects[player] = {
        box = Drawing.new("Square"),
        name = Drawing.new("Text"),
        distance = Drawing.new("Text"),
        tracer = Drawing.new("Line")
    }

    local objects = espObjects[player]
    objects.box.Thickness = 1
    objects.box.Color = Color3.new(0, 1, 0)
    objects.box.Filled = false
    objects.box.Transparency = 1

    objects.name.Color = Color3.new(1, 1, 1)
    objects.name.Size = 14
    objects.name.Center = true
    objects.name.Outline = true
    objects.name.OutlineColor = Color3.new(0, 0, 0)

    objects.distance.Color = Color3.new(1, 1, 0)
    objects.distance.Size = 12
    objects.distance.Center = true
    objects.distance.Outline = true
    objects.distance.OutlineColor = Color3.new(0, 0, 0)

    objects.tracer.Color = Color3.new(1, 0, 0)
    objects.tracer.Thickness = 1
    objects.tracer.Transparency = 1
end

local function removeESP(player)
    if espObjects[player] then
        for _, drawing in pairs(espObjects[player]) do
            drawing:Remove()
        end
        espObjects[player] = nil
    end
end

local function updateESP()
    if not espEnabled then
        for player, _ in pairs(espObjects) do
            removeESP(player)
        end
        return
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not espObjects[player] then
                createESP(player)
            end

            local rootPart = player.Character.HumanoidRootPart
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            
            local objects = espObjects[player]
            if onScreen then
                local distance = (Camera.CFrame.Position - rootPart.Position).Magnitude
                local scale = 1000 / distance
                local headPos = Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, humanoid.HipHeight, 0))
                local footPos = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, humanoid.HipHeight, 0))
                
                local height = math.abs(headPos.Y - footPos.Y)
                local width = height * 0.6

                -- Box
                objects.box.Size = Vector2.new(width, height)
                objects.box.Position = Vector2.new(pos.X - width / 2, pos.Y - height / 2)
                objects.box.Visible = true

                -- Name
                objects.name.Text = player.Name
                objects.name.Position = Vector2.new(pos.X, pos.Y - height / 2 - 15)
                objects.name.Visible = true

                -- Distance
                objects.distance.Text = string.format("%.0f m", distance)
                objects.distance.Position = Vector2.new(pos.X, pos.Y + height / 2 + 15)
                objects.distance.Visible = true

                -- Tracer
                objects.tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                objects.tracer.To = Vector2.new(pos.X, pos.Y)
                objects.tracer.Visible = true
            else
                -- Verstecke alle Objekte, wenn der Spieler außerhalb des Bildschirms ist
                for _, drawing in pairs(objects) do
                    drawing.Visible = false
                end
            end
        else
            -- Entferne ESP, wenn der Spieler kein Character mehr hat
            removeESP(player)
        end
    end
end

-- NEU: Insta-Kill Funktion
local function onHit(hitPart)
    if not instaKillEnabled then return end
    
    local character = hitPart.Parent
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    -- Überprüfen, ob es ein gültiger Gegner ist (nicht du selbst)
    if humanoid and humanoid ~= Humanoid and character ~= Character then
        -- Setze die Gesundheit des Gegners auf 0
        humanoid.Health = 0
    end
end

-- ==================== NEUE TARGET-FOLLOW FUNKTIONEN ====================

-- Erstellt oder aktualisiert den Button für einen einzelnen Spieler
local function createOrUpdatePlayerButton(player)
    if player == LocalPlayer then return end -- Nicht sich selbst anzeigen

    local button = playerButtons[player]
    if not button then
        -- Button erstellen, falls er nicht existiert
        button = Instance.new("TextButton")
        button.Parent = PlayerScrollingFrame
        button.Size = UDim2.new(1, 0, 0, 25)
        button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        button.BorderSizePixel = 1
        button.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.Font = Enum.Font.SourceSans
        button.TextSize = 14
        playerButtons[player] = button
    end

    button.Text = player.Name
    
    -- Button-Farbe basierend auf dem Status aktualisieren
    if isFollowing and targetPlayer == player then
        button.BackgroundColor3 = Color3.new(0, 0.5, 0) -- Grün, wenn dieser Spieler das Ziel ist
        button.Text = player.Name .. " [FOLLOWING]"
    else
        button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2) -- Standardfarbe
    end
end

-- Entfernt den Button eines Spielers, der gegangen ist
local function removePlayerButton(player)
    if playerButtons[player] then
        playerButtons[player]:Destroy()
        playerButtons[player] = nil
    end
end

-- Hauptfunktion, um die gesamte Liste zu aktualisieren
local function updatePlayerList()
    -- Alte Buttons von Spielern entfernen, die nicht mehr im Server sind
    for player, _ in pairs(playerButtons) do
        if not Players:FindFirstChild(player.Name) then
            removePlayerButton(player)
        end
    end
    
    -- Buttons für alle aktuellen Spieler erstellen oder aktualisieren
    for _, player in pairs(Players:GetPlayers()) do
        createOrUpdatePlayerButton(player)
    end
    
    -- Größe des ScrollingFrame anpassen
    PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, PlayerListLayout.AbsoluteContentSize.Y)
end

-- Funktion zum Starten/Stoppen des Folgens
local function toggleFollow(playerToFollow)
    if isFollowing and targetPlayer == playerToFollow then
        -- Stoppe das Folgen
        isFollowing = false
        targetPlayer = nil
        if followConnection then
            followConnection:Disconnect()
            followConnection = nil
        end
        print("Folgen beendet.")
    else
        -- Beginne, dem neuen Spieler zu folgen
        if isFollowing and followConnection then
            followConnection:Disconnect() -- Alte Verbindung trennen
        end
        isFollowing = true
        targetPlayer = playerToFollow
        print("Folge jetzt: " .. targetPlayer.Name)

        -- Neue, verbesserte Version
        followConnection = RunService.Heartbeat:Connect(function()
            if isFollowing and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and Character and Character:FindFirstChild("HumanoidRootPart") then
                local targetCFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                Character.HumanoidRootPart.CFrame = targetCFrame * CFrame.new(0, 0, 3)
            else
                -- Wenn das Ziel verloren geht (z.B. tot), beende das Folgen sauber.
                if isFollowing then
                    print("Ziel verloren. Folgen wird beendet.")
                    toggleFollow(targetPlayer) -- Beendet den Follow-Zustand
                end
            end
        end)
    end -- <--- DIESES END WAR WICHTIG!
end -- <--- UND DIESES END BEENDET DIE toggleFollow FUNKTION!

local function toggleInstaKill()
    instaKillEnabled = not instaKillEnabled
    if instaKillEnabled then
        InstaKillButton.Text = "Insta-Kill: AN"
        InstaKillButton.TextColor3 = Color3.new(0, 1, 0)
        
        -- Funktion, um die Events zu verbinden
        local function connectToCharacter(char)
            if not char then return end
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    local connection = part.Touched:Connect(onHit)
                    if not espConnections["InstaKill"] then espConnections["InstaKill"] = {} end
                    table.insert(espConnections["InstaKill"], connection)
                end
            end
        end

        -- Verbinde mit dem aktuellen Charakter
        connectToCharacter(Character)
        
        -- Verbinde erneut, wenn der Charakter respawnt
        espConnections.InstakillRespawn = LocalPlayer.CharacterAdded:Connect(connectToCharacter)

    else
        InstaKillButton.Text = "Insta-Kill: AUS"
        InstaKillButton.TextColor3 = Color3.new(1, 0, 0)
        
        -- Trenne alle Verbindungen
        if espConnections["InstaKill"] then
            for _, connection in pairs(espConnections["InstaKill"]) do
                connection:Disconnect()
            end
            espConnections["InstaKill"] = nil
        end
        if espConnections.InstakillRespawn then
            espConnections.InstakillRespawn:Disconnect()
            espConnections.InstakillRespawn = nil
        end
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        ESPButton.Text = "ESP: AN"
        ESPButton.TextColor3 = Color3.new(0, 1, 0)
    else
        ESPButton.Text = "ESP: AUS"
        ESPButton.TextColor3 = Color3.new(1, 0, 0)
        -- Räume alle bestehenden ESPs auf
        for player, _ in pairs(espObjects) do
            removeESP(player)
        end
    end
end

-- Fliegen-Funktionen
local function startFly()
    if flying then return end
    
    flying = true
    FlyButton.Text = "Fliegen: AN"
    FlyButton.TextColor3 = Color3.new(0, 1, 0)
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Parent = Humanoid.RootPart
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.P = 10000
    bodyGyro.Parent = Humanoid.RootPart
    
    Humanoid.PlatformStand = true
end

local function stopFly()
    if not flying then return end
    
    flying = false
    FlyButton.Text = "Fliegen: AUS"
    FlyButton.TextColor3 = Color3.new(1, 0, 0)
    
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
    
    Humanoid.PlatformStand = false
end

local function controlFly()
    if not flying then return end
    
    local camera = workspace.CurrentCamera
    local moveDirection = Vector3.new(0, 0, 0)
    
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        moveDirection = moveDirection + camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        moveDirection = moveDirection - camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        moveDirection = moveDirection - camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        moveDirection = moveDirection + camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        moveDirection = moveDirection + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        moveDirection = moveDirection - Vector3.new(0, 1, 0)
    end
    
    if bodyVelocity then
        bodyVelocity.Velocity = moveDirection * flySpeed * speedValue
    end
    
    if bodyGyro then
        bodyGyro.CFrame = camera.CFrame
    end
end

-- NoClip-Funktion
local function toggleNoClip()
    noClipEnabled = not noClipEnabled
    if noClipEnabled then
        NoClipButton.Text = "NoClip: AN"
        NoClipButton.TextColor3 = Color3.new(0, 1, 0)
    else
        NoClipButton.Text = "NoClip: AUS"
        NoClipButton.TextColor3 = Color3.new(1, 0, 0)
    end
end

-- Barrieren finden
local function findBarriers()
    barrierParts = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("WedgePart") then
            if obj.Name:lower():find("barrier") or obj.Name:lower():find("wall") or obj.Name:lower():find("block") or obj.Name:lower():find("fence") then
                table.insert(barrierParts, obj)
            end
        end
    end
end

-- Barrieren umschalten
local function toggleBarriers()
    barriersEnabled = not barriersEnabled
    if barriersEnabled then
        BarrierButton.Text = "Barrieren: AKTIV"
        BarrierButton.TextColor3 = Color3.new(1, 0, 0)
        for _, part in pairs(barrierParts) do
            if part and part.Parent then
                part.CanCollide = true
                part.Transparency = 0
            end
        end
    else
        BarrierButton.Text = "Barrieren: DEAKTIV"
        BarrierButton.TextColor3 = Color3.new(0, 1, 0)
        for _, part in pairs(barrierParts) do
            if part and part.Parent then
                part.CanCollide = false
                part.Transparency = 0.5
            end
        end
    end
end

-- Slider-Steuerung Fly 
SpeedSlider.MouseButton1Down:Connect(function()
    isDragging = true
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = input.Position
        local sliderPos = SpeedSlider.AbsolutePosition
        local sliderSize = SpeedSlider.AbsoluteSize
        
        local relativeX = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
        speedValue = 0.1 + (relativeX * 49.0) -- 0.1 bis 10.0
        
        updateSpeed()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

-- Button-Events
FlyButton.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
    end
end)

ESPButton.MouseButton1Click:Connect(toggleESP)
NoClipButton.MouseButton1Click:Connect(toggleNoClip)
BarrierButton.MouseButton1Click:Connect(toggleBarriers)
InstaKillButton.MouseButton1Click:Connect(toggleInstaKill)
CloseButton.MouseButton1Click:Connect(function()
    -- Räume alle ESP-Objekte auf
    for player, _ in pairs(espObjects) do
        removeESP(player)
    end
    -- Trenne alle Verbindungen (einschließlich Insta-Kill)
    for key, connections in pairs(espConnections) do
        if type(connections) == "table" then
            for _, connection in pairs(connections) do
                connection:Disconnect()
            end
        else
            connections:Disconnect()
        end
    end
    espConnections = {}
    ScreenGui:Destroy()
end)

-- NEU
RunService.Stepped:Connect(function()
    -- NoClip
    if noClipEnabled and Character and Humanoid then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    -- Fliegen-Steuerung
    controlFly()
    
    -- NEU: ESP Update
    updateESP()
end)

-- Initialisierung
findBarriers()
updateSpeed()


-- Automatische Aktualisierung der Barrieren
spawn(function()
    while ScreenGui.Parent do
        wait(5)
        findBarriers()
        if not barriersEnabled then
            for _, part in pairs(barrierParts) do
                if part and part.Parent then
                    part.CanCollide = false
                    part.Transparency = 0.5
                end
            end
        end
    end
end)


-- NEU: Spieler-Verbindungen für ESP
local function onPlayerAdded(player)
    local connection
    connection = player.CharacterAdded:Connect(function()
        if espEnabled then
            createESP(player)
        end
    end)
    espConnections[player] = connection
end

-- NEU (etwas sicherer)
local function onPlayerRemoving(player)
    if player then -- Sicherheitsprüfung
        removeESP(player)
        if espConnections[player] then
            espConnections[player]:Disconnect()
            espConnections[player] = nil
        end
    end
end

for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end


Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

-- Stelle sicher, dass Character und Humanoid immer aktuell sind
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:WaitForChild("Humanoid")
    
    -- Optional: Deaktiviere NoClip und Fliegen nach dem Respawn für Sicherheit
    if noClipEnabled then
        toggleNoClip()
    end
    if flying then
        stopFly()
    end
end)

-- ==================== EVENT-HANDLER FÜR DIE SPIELERLISTE ====================

-- Wenn ein Button in der Spielerliste geklickt wird
PlayerScrollingFrame.ChildAdded:Connect(function(child)
    if child:IsA("TextButton") then
        child.MouseButton1Click:Connect(function()
            local playerName = child.Text:gsub(" %[FOLLOWING%]", "") -- Name bereinigen
            local player = Players:FindFirstChild(playerName)
            if player then
                toggleFollow(player)
            end
        end)
    end
end)

-- Verbindung zu Events, wenn Spieler den Server betreten oder verlassen
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        updatePlayerList()
    end)
    updatePlayerList()
end)

Players.PlayerRemoving:Connect(function(player)
    -- Wenn der Spieler, dem wir folgen, geht, hören wir auf zu folgen
    if targetPlayer == player then
        toggleFollow(player)
    end
    removePlayerButton(player)
end)

-- ==================== INITIALISIERUNG ====================
-- Erstelle die initiale Spielerliste
updatePlayerList()

-- Aktualisiere die Liste alle paar Sekunden für den Fall, dass etwas verpasst wird
spawn(function()
    while ScreenGui.Parent do
        wait(5)
        updatePlayerList()
    end
end)

print("F.N. Hunted Multi-Hack geladen!")
print("Features: Geschwindigkeit, Fliegen, NoClip, Barrieren")
print("Fliegen-Steuerung: W/A/S/D zum Bewegen, Leertaste hoch, Strg runter")
