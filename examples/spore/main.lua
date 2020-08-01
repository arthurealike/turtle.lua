package.path = package.path .. ";../../turtle/?.lua"
local Spore = require "turtle"

local spores = {}

local w, h = love.graphics.getWidth(), love.graphics.getHeight()

function love.load()
    love.window.setTitle("Spores")
    bg_color = {.9, .7, .8}
    love.graphics.setBackgroundColor(bg_color)
    for i=1, 20 do
        local spore = Spore()
        spore:st():up():setx(love.math.random(0, w)):sety(love.math.random(0, h)):speed(100):down()
        spawn(spore)
        table.insert(spores, spore)
    end
end

function love.draw()
    for _,spore in pairs(spores) do 
        spore:draw()
    end
end

function spawn(t)
    local p0 = love.math.random(0, 1)
    local p1 = love.math.random(0, 1)

    local a = 0
    local b = 0
    while b < 210 do 
        local g = math.random(25, 55)

        g = g / 100
        local c = {p0, g, p1}
        print(g)
        t:color(c):fd(a):rt(b)
        a = a + 1
        b = b + 1
    end
end
