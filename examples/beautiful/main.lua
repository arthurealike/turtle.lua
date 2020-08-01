package.path = package.path .. ";../../turtle/?.lua"
local Turtle = require "turtle"
local turtle = Turtle()

function love.load()
    love.window.setTitle("Beautiful")
    turtle:ht()
    local speed = 200
    local steps = 3
    for i=1, 360 * 3  do 
        speed = speed + 3
        turtle:fd(i * 3 / steps + 1):lt(360 / steps + 1):color(1- i / 900, 1 - i / 500, 0.7):speed(speed)
    end
end

function love.draw()
    turtle:draw()
end

function love.keypressed(key)
    if key == "space" then
        turtle:toggle()
    elseif key == "c" then
        turtle:reset()
    end
end
