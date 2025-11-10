-- Pantalla de carga "Método Moreira" con efecto rainbow
local progress = 1
local maxProgress = 99
local speed = 0.2 -- velocidad de carga
local fontTitle, fontPercent, fontText
local blinkTimer = 0
local showText = true
local rainbowTimer = 0

function love.load()
    love.window.setTitle("Método Moreira")
    love.window.setMode(800, 600, {resizable=false})
    fontTitle = love.graphics.newFont(60)
    fontPercent = love.graphics.newFont(26)
    fontText = love.graphics.newFont(22)
end

-- Función para crear color arcoíris en base al tiempo
local function rainbowColor(t)
    local r = (math.sin(t * 2) + 1) / 2
    local g = (math.sin(t * 2 + 2) + 1) / 2
    local b = (math.sin(t * 2 + 4) + 1) / 2
    return r, g, b
end

function love.update(dt)
    rainbowTimer = rainbowTimer + dt * 2

    -- Incrementa el progreso lentamente, pero nunca pasa del 99%
    if progress < maxProgress then
        progress = progress + speed
    else
        progress = maxProgress
        -- Parpadeo del texto "Cargando..."
        blinkTimer = blinkTimer + dt
        if blinkTimer >= 0.8 then
            showText = not showText
            blinkTimer = 0
        end
    end
end

function love.draw()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    -- Fondo oscuro
    love.graphics.clear(0.05, 0.05, 0.05)

    -- Texto principal con efecto rainbow
    love.graphics.setFont(fontTitle)
    local r, g, b = rainbowColor(rainbowTimer)
    love.graphics.setColor(r, g, b)
    love.graphics.printf("Método Moreira", 0, height/2 - 150, width, "center")

    -- Contenedor de la barra
    local barWidth = width * 0.7
    local barHeight = 30
    local barX = (width - barWidth) / 2
    local barY = height / 2

    -- Fondo de la barra
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", barX, barY, barWidth, barHeight, 10, 10)

    -- Barra de progreso
    love.graphics.setColor(0, 1, 1)
    love.graphics.rectangle("fill", barX, barY, barWidth * (progress / 100), barHeight, 10, 10)

    -- Porcentaje
    love.graphics.setFont(fontPercent)
    love.graphics.setColor(0, 1, 1)
    love.graphics.printf(string.format("%d%%", math.floor(progress)), 0, barY + 50, width, "center")

    -- Texto parpadeante cuando se congela en 99%
    if progress >= maxProgress and showText then
        love.graphics.setFont(fontText)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Cargando...", 0, barY + 90, width, "center")
    end
end
