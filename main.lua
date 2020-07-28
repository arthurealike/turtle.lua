local Turtle = require "turtle"

local koch = Turtle("snowflake", love.graphics.getWidth() / 2 - 150, love.graphics.getHeight() / 2 - 150)
local circle = Turtle("circle")
local line = Turtle("line", 0)

local function snowflake(t, l, c)
    if c > 7 then
        print("error: do not exceed number 7")
        return nil
    elseif c < 1 then
        t:f(l)
        return nil
    end
    l = l / 3
    snowflake(t, l, c-1)
    t:rl(60)
    snowflake(t, l, c-1)
    t:rr(120)
    snowflake(t, l, c-1)
    t:rl(60)
    snowflake(t, l, c-1)
end

function initSnowflake(speed)
    koch:setCallback(function ()
        print ("snowflake is fully drawn")
    end)

    koch:speed(speed or 240):color(1,0,1)
    for i = 1, 3 do
        snowflake(koch, 300, 4)
        koch:rot(120):color(i/3,0,i/3)
    end
end

function initLine(speed)
    line:setCallback(function ()
        print ("line is fully drawn")
    end)

    line:speed(speed or 100)
    for i = 1, love.graphics.getWidth(), 15 do
        line:speed(math.max(10, i / 8)):f(15):color(math.random(), math.random(), math.random())
    end
end

function initCircle(radius, speed)
    circle:setCallback(function ()
        print ("circle is fully drawn")
    end)

    local s = 2 * math.pi * radius / 360 
    circle:speed(speed or 20)
    for i = 1, 360, 1 do
        circle:speed(math.max(10, i / 6)):f(s):rr(1):color(math.random(), math.random(), math.random())
    end
end

function love.load()
    initSnowflake()
    initLine()
    initCircle(100)
end

function love.update(dt)
    koch:update(dt)
    line:update(dt)
    circle:update(dt)
end

function love.draw()
    koch:draw()
    line:draw()
    circle:draw()
end

function love.keypressed(key)
    if key == "space" then
        koch:toggle()
        line:toggle()
        circle:toggle()
    elseif key == "c" then
        koch:clear()
        line:clear()
        circle:clear()
    end
end