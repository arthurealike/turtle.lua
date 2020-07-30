package.path = package.path .. ";../../turtle/?.lua"
local Turtle = require "turtle"

local koch = Turtle(love.graphics.getWidth() / 2 - 150, love.graphics.getHeight() / 2 - 150)

local function snowflake(l, c)
    if c > 7 then
        print("error: do not exceed number 7")
        return nil
    elseif c < 1 then
        koch:fd(l)
        return nil
    end
    l = l / 3
    snowflake(l, c-1)
    koch:left(60)
    snowflake(l, c-1)
    koch:right(120)
    snowflake(l, c-1)
    koch:left(60)
    snowflake(l, c-1)
end

function initSnowflake()
    koch:ondrawfinish(function ()
        print (koch:name() .." is fully drawn")
    end)

    koch:pd():speed(10):color(1,0.75,1)
    for i = 1, 3 do
        snowflake(300, 4)
        koch:right(120):color(i/3,i/3,i/3)
    end
end

function love.load()
    initSnowflake()
end

function love.draw()
    koch:draw()
end

function love.keypressed(key)
    if key == "space" then
        koch:toggle()
    elseif key == "c" then
        koch:clear()()
    end
end
