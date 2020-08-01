package.path = package.path .. ";../../turtle/?.lua"
local Turtle = require "turtle"

local lheart, rheart = Turtle(), Turtle()

function initHeart()
    lheart:up():home():go_to(lheart:xcor(), lheart:ycor() + 100):down():speed(2):pensize(8):pd():play()
    rheart:up():home():go_to(rheart:xcor(), rheart:ycor() + 100):down():speed(2):pensize(8):pd():play()

    lheart:color(1,0,0):left(140):fd(120)
    rheart:color(1,0,0):left(40):fd(120)

    for _ = 1, 200 do
        lheart:right(1):forward(1)
        rheart:left(1):forward(1)
    end

    lheart:play()
    rheart:play()
end

function love.load()
    love.graphics.setBackgroundColor(.15, .15, .15)
    initHeart()
end

function love.draw()
    lheart:draw()
    rheart:draw()
end

function love.keypressed(key)
    if key == "space" then
        lheart:toggle()
        rheart:toggle()
    elseif key == "c" then
        lheart:clear()
        rheart:clear()
    end
end
