local Turtle = require "turtle/turtle"

local fps 
local w, h = love.graphics.getWidth(), love.graphics.getHeight()

function circle(t, l) 
    t:penup()
    for i=1, 360 do
        t:pendown():right(1):fd(l)
    end
    t:penup()
end

function snowflake(l, c, t) 
    if t then
        if c > 7 then 
            print("Do not exceed number 7")
            return nil
        elseif c < 1 then
            t:forward(l)
            return nil
        end
        l = l / 3
        snowflake(l, c-1, t)
        t:left(60)
        snowflake(l, c-1, t)
        t:right(120)
        snowflake(l, c-1, t)
        t:left(60)
        snowflake(l, c-1, t)
    end
end

local line = Turtle()
local circle1 = Turtle(100,100,1)
local circle2 = Turtle(100,100,1)
local circle3 = Turtle(100,100,1)
local circle4 = Turtle(100,100,1)
local circle5 = Turtle(100,100,1)
local circle6 = Turtle(100,100,1)

local triangle = Turtle(100,150,1, {1, 1, 1})
local koch = Turtle()

function love.load()
    local red = {1, 0, 0}

    line:clear():speed(.02):right(35):forward(100)

    circle1:home():speed(1):color(1,0,0)
    circle2:home():speed(1):color(1,1,0)
    circle3:home():speed(1):color(1,0,1)
    circle4:home():speed(1):color(0,1,1)
    circle5:home():speed(1):color(0,1,0)
    circle6:home():speed(1):color(0,0,1)

    circle(circle1, 0.5)
    circle(circle2, 1)
    circle(circle3, 1.5)
    circle(circle4, 2)
    circle(circle5, 2.5)
    circle(circle6, 3)

    triangle:home():color():left(60):forward(50):right(120):forward(50):left(60):backward(50)

    for i=1, 3 do
        snowflake(300, 4, koch)
        koch:right(120)
    end
end

function love.update(dt)
    fps = love.timer.getFPS()
    mx, my = love.mouse.getPosition() 
end
function love.draw()
    love.graphics.print(fps)
    love.graphics.scale(sx, sy)
    --t:draw()
    line:draw()
    circle1:draw()
    circle2:draw()
    circle3:draw()
    circle4:draw()
    circle5:draw()
    circle6:draw()

    triangle:draw()

    koch:draw()
end
