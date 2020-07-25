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
        t:pendown():right(1):forward(2)
    end
    t:penup()
end

function love.load()
    local cl = {1, 1, 1}

    local l = 300
    t:setcolor(cl):speed(.0002)
    for i=1, 3 do
        snowflake(300, 4)
        t:right(120)
    end
    --circle()
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
