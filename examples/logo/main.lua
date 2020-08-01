package.path = package.path .. ";../../turtle/?.lua"
local Turtle = require "turtle"

local logo = Turtle()

local bg_color = {.3, .2, .3}

function love.load()
    love.graphics.setBackgroundColor(bg_color)
    love.window.setTitle("Logo drawing")
    -- UNCOMMENT ONE OF THEM 
    --adidas(logo)
    adidas(logo, 8, 8, 4)
end

function love.draw() 
    logo:draw()
end

function love.keypressed(key)
    if key == "space" then
        logo:toggle()
    elseif key == "c" then
        logo:clear()
    end
end

function adidas(t, lineCount, offset_y, lineWidth)
    t:speed(20)
    --circle1
    t:pu():go_to(270, 280):pd()
    :begin_fill()
    :circle(120, 90)
    :right(90)
    :circle(120, 90):end_fill()

    local dx, dy = 135, 85
    --circle2
    t:pu():go_to(t:xcor() + dx, t:ycor() - dy):pd():begin_fill()
    :right(135)    
    :circle(155, 90)
    :right(90)    
    :circle(155, 90)
    :end_fill()

    --circle3
    t:pu():setx(t:xcor() + dx):sety(t:ycor() + dy):pd()
    :pd():begin_fill()
    :right(135)    
    :circle(120, 90)
    :right(90)    
    :circle(120, 90)
    :end_fill()

    local lineCount = lineCount or 3
    local offset_y = offset_y or 25
    local lineWidth = lineWidth or 15

    t:color(bg_color)
    t:pensize(lineWidth)
    --lines
    for i=1, lineCount do 
        t:up():go(240, 325 + (i - 1) * offset_y):down():seth(0):fd(300)
    end
end
