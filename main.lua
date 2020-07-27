Object = require "object"

local Turtle = require "turtle"

local t = Turtle(love.graphics.getWidth() / 2 - 150, love.graphics.getHeight() / 2 - 150, 100)

local function snowflake(l, c)
    if c > 7 then
        print("Do not exceed number 7")
        return nil
    elseif c < 1 then
        t:f(l)
        return nil
    end
    l = l / 3
    snowflake(l, c-1)
    t:rot(-60)
    snowflake(l, c-1)
    t:rot(120)
    snowflake(l, c-1)
    t:rot(-60)
    snowflake(l, c-1)
end

function love.load()
    for i = 1, 3 do
        snowflake(300, 4)
        t:rot(120)
    end
end

function love.update(dt)
end

function love.draw()
    t:draw()
end
