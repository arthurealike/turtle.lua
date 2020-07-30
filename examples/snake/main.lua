package.path = package.path .. ";../../turtle/?.lua"
Turtle = require "turtle"

local snake = Turtle()
snake:name("sweet snake")

local gameText = love.graphics.newText(love.graphics.getFont(), "SNAKE")
local speed = 1

function love.load()
    love.graphics.setBackgroundColor(.15, .15, .15)
    snake:debugon()
    snake:pd():play()
end

function love.update()
    if love.keyboard.isDown("w") then
        if love.keyboard.isDown("a") then
            snake:left(3)
        elseif love.keyboard.isDown("d") then
            snake:right(3)
        end
        snake:forward(speed)
    end
end

function love.draw()
    snake:draw()
    love.graphics.draw(gameText, love.graphics.getWidth() - gameText:getWidth(), love.graphics.getHeight() - gameText:getHeight())
end

function love.keypressed(key)
    if key == "space" then
        snake:pentoggle()
    elseif key == "+" or key == "kp+" then
        speed = math.min(5, speed + 1)
    elseif key == "-" or key == "kp-" then
        speed = math.max(1, speed - 1)
    end
end