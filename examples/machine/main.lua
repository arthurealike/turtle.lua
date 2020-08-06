-----------------------------------------------------------
--            (c) 2020 Mustafa Erkam Badin               --
-----------------------------------------------------------
-- Source: https://github.com/arthurealike/turtle.lua    --
-----------------------------------------------------------
package.path = package.path .. ";../../turtle/?.lua"
local Turtle = require "turtle"

local w, h = love.graphics.getWidth(), love.graphics.getHeight()

local shape = Turtle()
local bg_color 

function love.load()
    love.window.setTitle("Machine")
    bg_color = {.2, .2, .2}
    love.graphics.setBackgroundColor(bg_color)

    shape:speed(200)
    :pu():home():sety(200):pd()
    machine(shape)

end

function love.keypressed(key)
    if key == "space" then
        shape:toggle()
    elseif key == "c" then
        shape:clear()
    end
end

function love.draw()
    shape:draw()
end

function machine(t)
    t:pu():turtlecolor(0.3, 0, 0.5)
    for i=1, 181 do
        t:forward(120):color(.8, .8, .8)
        t:right(30)
        t:forward(50):color(.9, .9, .9)
        t:left(60)
        t:forward(100):color(sc)
        t:right(30)

        t:penup()
        t:home()
        t:pendown()

        t:right(2)
    end
end

