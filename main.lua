local Turtle = require "turtle/turtle"

local fps 
local w, h = love.graphics.getWidth(), love.graphics.getHeight()

local t = Turtle()

function snowflake(l, c)
    if c > 7 then 
        print("Do not exceed number 7")
        return nil
    elseif c < 1 then
        t:forward(l)
        return nil
    end
    l = l / 3
    snowflake(l, c-1)
    t:left(60)
    snowflake(l, c-1)
    t:right(120)
    snowflake(l, c-1)
    t:left(60)
    snowflake(l, c-1)
end

function circle() 
    t:penup()
    for i=1, 360 do
        t:pendown():right(1):fd(2)
    end
    t:penup()
end

local line = Turtle()
local circle = Turtle(100,100,1)
local triangle = Turtle(100,150,1, {1, 1, 1})

function love.load()
    local red = {1, 0, 0}

    line:clear():speed(.02):right(35):forward(100)

    circle:penup():go_to(w/2,h/2 + 100):color(1,1,1)

    for i=1, 360 do
        circle:pendown():right(1):forward(2)
    end

    triangle:color():left(60):forward(50):right(120):forward(50):left(60):backward(50)
end

function backup() 
    local cl = {1, 1, 1}

    local l = 300
    t:setcolor(cl):speed(.2)
    for i=1, 3 do
        snowflake(300, 4)
        t:right(120)
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
    circle:draw()
    triangle:draw()
end
