local Turtle = require "turtle"

local turtles = {}
turtles["heart1"] = Turtle()
turtles["heart2"] = Turtle()
turtles["koch"] = Turtle()
turtles["circle"] = Turtle()
turtles["line"] = Turtle()

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
    t1:color(1,0,0):left(140):fd(120)
    t2:color(1,0,0):left(40):fd(120)
    for i = 1, 200 do
        t1:right(1):forward(1)
        t2:left(1):forward(1)
    end
end

function randomizeTurtles(turtles)
    for _, t in turtles do
        t:go():speed():right():forward()
    end
end

function initSnowflake(koch, speed)
    print(koch:pensize())
    koch:ondrawfinish(function ()
        print (koch:name() .." is fully drawn")
    end)

    koch:speed(speed):color(1,0,1)
    for i = 1, 3 do
        snowflake(koch, 300, 4)
        koch:right(120):color(i/3,0,i/3)
    end
end

function initLine(line, speed)
    line:ondrawfinish(function ()
        print (line:name() .." is fully drawn")
    end)

    line:speed(1):go_to(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    for i = 1, love.graphics.getWidth(), 15 do
        line:speed(math.max(10, i / 8)):forward(15):color(math.random(), math.random(), math.random())
    end
end

function initCircle(circle, radius, speed)
    circle:ondrawfinish(function ()
        print (circle:name() .." is fully drawn")
    end)

    local s = 2 * math.pi * radius / 360 
    circle:speed(speed)
    for i = 1, 360, 1 do
        circle:speed(math.max(10, i / 6)):fd(s):right(1):color(math.random(), math.random(), math.random())
    end
end

function love.load()
    love.graphics.setBackgroundColor(.15, .15, .15)
    initSnowflake(turtles["koch"], 1)
    initLine(turtles["line"])
    initCircle(turtles["circle"], 100, 0.1)
    turtles["heart1"]:sety(400):speed(0.5):pensize(5)
    turtles["heart2"]:sety(400):speed(0.5):pensize(5)
    initHeart(turtles["heart1"], turtles["heart2"])
end

function love.update(dt)
end

function love.draw()
    --  koch:draw()
    --  line:draw()
    --  circle:draw()
     turtles["heart1"]:draw()
     turtles["heart2"]:draw()
end

function love.keypressed(key)
    if key == "space" then
        for _,turtle in pairs(turtles) do 
            turtle:toggle()
        end
    elseif key == "c" then
        for _,turtle in pairs(turtles) do 
            turtle:reset()
        end
    end
end
