local turtle = {}

turtle.__index = turtle

local newline = function(x1, y1, x2, y2, c) 
    return {p1 = {x = x1, y = y1 }, p2 = {x = x2, y = y2} , c = c or {1, 0, 0}}
end

local getcolor = function(color, mode)  
    local c = color
    if mode ~= false then
        c = {love.math.random(0, 1), love.math.random(0, 1),love.math.random(0, 1)}
    end 
    return c
end 

local function new(x, y, speed, color) 
    linesegments = {}
    currentposition = {}
    currentposition.x = x or love.graphics.getHeight() / 2
    currentposition.y = y or love.graphics.getWidth() / 2
    speed = speed or 1
    color = color or {1, 1, 0}
    direction = 0
    size = 1
    rainbowmode = false
    turtleVisibility = true
    return setmetatable({linesegments = linesegments, currentposition = currentposition, direction = direction, color = color, speed = speed}, turtle)
end

function turtle:setcolor(...)
    local c = self.color
    local size = select("#", ...)
    if size == 3 then
        c = {...}
    elseif size == 1 then 
        c = ... 
    end
    self.color = c
    return self
end

function turtle:getlines() 
    return self.lineSegments
end

function turtle:draw()
    for _,line in pairs(self.linesegments) do
        love.graphics.setColor(line.c)
        love.graphics.line(line.p1.x,line.p1.y, line.p2.x, line.p2.y)
    end
end

function turtle:clear()
    love.graphics.setColor(1, 1, 1)
    self.lineSegments = {}
    love.graphics.setLineWidth(1)
    self.rainbowmode = false
    return self
end

function turtle:penup()
    self.drawing = false
    return self
end

function turtle:pendown()
    self.drawing = true
    return self
end

function turtle:rainbow()
    self.rainbowmode = true
    return self
end

function turtle:showturtle()
    self.turtleVisibility = true
    return self
end

function turtle:hideturtle()
    self.turtleVisibility = false
    return self
end

function turtle:isvisible()
    return self.turtleVisibility
end

function turtle:pensize(size)
    self.size = size
    love.graphics.setLineWidth(size)
end

function turtle:setspeed(speed)
    self.speed = speed
end

function turtle:forward(distance)
    local x, y = self.currentposition.x + distance * math.cos(self.direction), self.currentposition.y + distance * math.sin(self.direction)

    local c = getcolor(self.color, self.rainbowmode)
    local line = newline(self.currentposition.x, self.currentposition.y, x, y, c) 
    if self.drawing ~= false then
        table.insert(self.linesegments, line) 
    end

    self.currentposition.x, self.currentposition.y = x, y
    return self
end

function turtle:backward(distance)
    self:forward(-distance)
    return self
end

function turtle:go_to(x, y)
    local c = self.getcolor(self.color, self.rainbowmode)
    local line = newline(self.currentposition.x, self.currentposition.y, x, y, c)
    table.insert(self.linesegments, line)
    return self
end

function turtle:right(angle)
    self.direction = self.direction - math.rad(angle)
    return self
end

function turtle:left(angle)
    self.direction = self.direction + math.rad(angle)
    return self
end

return setmetatable({new = new},
{__call = function(_, ...) return new(...) end})

