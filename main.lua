local Turtle = require "turtle"

local koch = Turtle(love.graphics.getWidth() / 2 - 150, love.graphics.getHeight() / 2 - 150)
local heart = Turtle()
local line = Turtle()

local function snowflake(t, l, c)
    if c > 7 then
        print("Do not exceed number 7")
        return nil
    elseif c < 1 then
        t:fd(l)
        return nil
    end
    l = l / 3
    snowflake(t, l, c-1)
    t:left(60)
    snowflake(t, l, c-1)
    t:right(120)
    snowflake(t, l, c-1)
    t:left(60)
    snowflake(t, l, c-1)
end

function love.load()
    koch:speed(1):color(1,0,1)
    for i = 1, 3 do
        snowflake(koch, 300, 1)
        koch:rot(120)
    end

    line:speed(20):fd(250)
end

function love.update(dt)
end

function love.draw()
    koch:draw()
    line:draw()
end
