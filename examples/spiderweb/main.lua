package.path = package.path .. ";../../turtle/?.lua"
local Spider = require "turtle"

local spider = Spider()

local spiderweb = function(turtle) 
    turtle:pendown()
    for i=1, 6 do
        turtle:speed(15):forward(150):backward(150):right(60)
    end
    local side = 150
    for i=1, 15 do
        turtle:penup():speed(11)
        :pendown()
        :setheading(0)
        :forward(side)
        :right(120)
        for j=1, 6 do
            turtle:forward(side)
            turtle:right(60)
        end 
        turtle:setheading(0):speed(15)
        turtle:backward(side)
        side = side - 30
    end
end

function love.keypressed(key)
    if key == "space" then
        spider:toggle()
    elseif key == "c" then
        spider:clear()
    end
end

function love.load()
    love.window.setTitle("Spidey")
    spider:name("spidey"):setsprite("spider.png"):home():speed(15)
    spiderweb(spider)
end

function love.draw()
    spider:draw()
end
