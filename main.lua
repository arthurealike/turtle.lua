local Turtle = require "turtle"

local heartpart1 = Turtle()
local heartpart2 = Turtle()
local koch = Turtle(love.graphics.getWidth() / 2 - 150, love.graphics.getHeight() / 2 - 150)
local circle = Turtle()
local line = Turtle("line", 0)

local function snowflake(t, l, c)
    if c > 7 then
        print("error: do not exceed number 7")
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

function initHeart(t1, t2)
    t1:color(1,0,0):speed(1):left(140):fd(120)
    t2:color(1,0,0):speed(1):left(40):fd(120)
    for i = 1, 200 do
        t1:right(1):forward(1)
        t2:left(1):forward(1)
    end
end

function initSnowflake(speed)
    print(koch:pensize())
    koch:callback(function ()
        print (koch:name() .." is fully drawn")
    end)

    koch:speed(speed):color(1,0,1)
    for i = 1, 3 do
        snowflake(koch, 300, 4)
        koch:right(120):color(i/3,0,i/3)
    end
end

function initLine(speed)
    line:callback(function ()
        print ("line is fully drawn")
    end)

    line:speed(1):go_to(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    for i = 1, love.graphics.getWidth(), 15 do
        line:speed(math.max(10, i / 8)):forward(15):color(math.random(), math.random(), math.random())
    end
end

function initCircle(radius, speed)
    circle:callback(function ()
        print (circle:name() .. "is fully drawn")
    end)

    local s = 2 * math.pi * radius / 360 
    circle:speed(speed)
    for i = 1, 360, 1 do
        circle:speed(math.max(10, i / 6)):fd(s):right(1):color(math.random(), math.random(), math.random())
    end
end

function love.load()
    initSnowflake(1)
    initLine()
    initCircle(100, 0.1)
    initHeart(heartpart1, heartpart2)
end

function love.update(dt)
end

function love.draw()
koch:draw()
--    line:draw()
    --circle:draw()
    heartpart1:draw()
    heartpart2:draw()
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
