local Turtle = require "turtle"

local fps 
local w, h = love.graphics.getWidth(), love.graphics.getHeight()

local t = Turtle()

function kuadrado(lado) 
    t:pendown()
    for i=1, 36 do
        t:forward(lado)
        t:right(90)
        t:forward(lado)
        t:right(90)
        t:forward(lado)
        t:right(90)
        t:forward(lado)
        t:right(100)
    end
    for i=1 ,100 do
        t:forward(i)
        t:right(80)   
    end
    t:penup()
end

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
        t:pendown():right(1):forward(2)
    end
    t:penup()
end

function love.load()
    local cl = {1, 0, 1}

    local l = 300
    t:speed(0.0000000000000002)
    for i=1, 3 do
        snowflake(300, 2)
        t:right(120)
    end

    t:setcolor(cl):clear():speed(2.2)
    circle()
    kuadrado(86)
end

function love.update(dt)
    fps = love.timer.getFPS()
    mx, my = love.mouse.getPosition() 
end

function love.draw()
    love.graphics.print(fps)
    love.graphics.scale(sx, sy)
    t:draw()
end
