local turtle = require "turtle"

local fps 

local w, h = love.graphics.getWidth(), love.graphics.getHeight()

local t = turtle()

function snowflake(l, c)
    if c > 7 then 
        print("Do not exceed number 7")
        return nil
    end
    if c < 1 then
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

function love.wheelmoved(x, y)
    iszoom = true

    sx = sy + y / 120
    sy = sy + y / 120
end

function love.load()
    --  turtle:init()
    local cl = {1, 0, 1}
    t:setcolor(cl):clear()
    local l = 300

    for i=1, 3 do
        snowflake(300, 5)
        t:right(120)
    end
end

function love.update(dt)
    fps = love.timer.getFPS()
    mx, my = love.mouse.getPosition() 
end

function love.draw()
    love.graphics.print(fps)
    --  love.graphics.translate(w -mx, h-my)
    love.graphics.scale(sx, sy)
    t:draw()
end
