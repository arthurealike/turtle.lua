local turtle = {
    currentPosition = {x = 0, y = 0} ,
    cursorPosition = {x = 0, y = 0} ,
    lineSegments = {} ,
    drawing = true ,
    direction = 0 , 
    color = {r=1, g=1, b=0} ,
    turtleVisibility = true ,
    size = 1 ,
    speed = 0.1
}

turtle.__index = turtle

local newline = function(x1, y1, x2, y2) 
    local line = {p1 = {x = x1, y = y1 }, p2 = {x = x2, y = y2}}
    return line
end

function turtle:init(x, y, color, speed)
    self.currentPosition.x = x or love.graphics.getWidth() / 2
    self.currentPosition.y = y or love.graphics.getHeight() / 2
    self.color = color or {1, 0, 0}
    self.speed = speed or 1
    self.direction = 0 
end

function turtle:getLines() 
    return self.lineSegments
end

function turtle:draw()
    for _,line in pairs(self.lineSegments) do
        love.graphics.line(line.p1.x,line.p1.y, line.p2.x, line.p2.y)
    end
end

function turtle:clear()
    love.graphics.setColor(1, 1, 1)
    self.lineSegments = {}
    love.graphics.setLineWidth(1)
end

function turtle:penup()
    self.drawing = false
end

function turtle:pendown()
    self.drawing = true
end

function turtle:showturtle()
    self.turtleVisibility = true
end

function turtle:hideturtle()
    self.turtleVisibility = false
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
    local x, y = self.currentPosition.x + distance * math.cos(self.direction) , self.currentPosition.y + distance * math.sin(self.direction)
    local line = newline(self.currentPosition.x, self.currentPosition.y, x, y) 
    if self.drawing ~= false then
        table.insert(self.lineSegments, line) 
    end

    self.currentPosition.x, self.currentPosition.y = x, y
end

function turtle:backward(distance)
    self:forward(-distance)
end

function turtle:go_to(x, y)
    local line = newline(self.currentPosition.x, self.currentPosition.y, x, y)
    table.insert(self.lineSegments, line)
end

function turtle:right(angle)
    self.direction = self.direction - math.rad(angle)
end

function turtle:left(angle)
    self.direction = self.direction + math.rad(angle)
end

return turtle
