_TURTLEIMAGE = "turtle.png"
local image_exists = love.filesystem.getInfo(_TURTLEIMAGE)
if image_exists then 
    turtleimage = love.graphics.newImage(_TURTLEIMAGE)
end

local turtle = {}
turtle.__index = turtle

local newline = function(x1, y1, x2, y2, c, d) 
    return {
      p1 = {x = x1, y = y1 }
    , p2 = {x = x2, y = y2}
    , pd = {x = x1, y = y1 }
    , dx = x2 - x1
    , dy = y2 - y1
    , c = c or {1, 0, 0}, direction = d}
end

local sign = function(x)
    return (x<0 and -1) or 1
end

local get_color = function(_color, mode)  
    local c = _color
    if mode ~= false then
        c = {love.math.random(0, 1), love.math.random(0, 1),love.math.random(0, 1)}
    end 
    return c
end 

local function new(x, y, speed, color) 
    _currentposition = {}
    _currentposition.x = x or love.graphics.getHeight() / 2
    _currentposition.y = y or love.graphics.getWidth() / 2
    _color = color or {1, 1, 1}
    _size = 1
    return setmetatable(
    { _linesegments = {}
    , _currentposition = _currentposition
    , _currentline = 1
    , _direction = 0
    , _speed = speed or 2
    , _color = _color 
    , _rainbowmode = false
    , _turtlevisible = true
}
,
turtle)
end

function turtle:color(...)
    self._rainbowmode = false
    local c = self._color
    local nargs = select("#", ...)
    if nargs == 3 then
        c = {...}
    elseif nargs == 1 and #... == 3 then 
        c = ... 
    end
    self._color = c
    return self
end

function turtle:getlines() 
    return self._linesegments
end

function turtle:draw()
    if #self._linesegments < 1 then return nil end

    if #self._linesegments >= self._currentline then
        --draw completed _linesegments
        if self._currentline > 1 then
            for i=1, self._currentline - 1 do
                local l = self._linesegments[i]
                love.graphics.setColor(l.c)
                love.graphics.line(l.p1.x,l.p1.y, l.p2.x, l.p2.y)
            end
        end

        print("eRR ".. self._currentline)
        local line = self._linesegments[self._currentline]
        
        local distance = math.sqrt(line.dx * line.dx, line.dy * line.dy) 

        local sx, sy = -sign(line.dx) * self._speed, -sign(line.dy) * self._speed

        local newpdx, newpdy = line.pd.x + sx, line.pd.y + sy  
        local newdistance = math.sqrt(((line.p2.x - newpdx)* (line.p2.x - newpdx)), ((line.p2.y - newpdy)* (line.p2.y - newpdy))) 

        if newdistance >= distance then
            line.pd.x, line.pd.y = line.p2.x, line.p2.y  
        else 
            line.pd.x, line.pd.y = line.pd.x + sx, line.pd.y + sy  
        end

        if line.pd.x == line.p2.x and line.pd.y == line.p2.y then
            self._currentline = self._currentline + 1
        end

        love.graphics.line(line.p1.x, line.p1.y, line.pd.x, line.pd.y)
        if image_exists then
            local x, y = line.pd.x - turtleimage:getWidth() / 2, line.pd.y - turtleimage:getHeight() / 2
            love.graphics.draw(turtleimage, line.pd.x, line.pd.y, line.direction, 1, 1, 0 + turtleimage:getWidth() / 2, 0 + turtleimage:getHeight() / 2)
        end
    else 
        for _,line in pairs(self._linesegments) do
            love.graphics.setColor(line.c)
            love.graphics.line(line.p1.x,line.p1.y, line.p2.x, line.p2.y)
        end
        local lastline = self._linesegments[self._currentline]
        if image_exists then
            print(image_exists)
            love.graphics.draw(turtleimage, lastline.p2.x, lastline.p2.y, lastline.direction, 1, 1, 0 + turtleimage:getWidth() / 2, 0 + turtleimage:getHeight() / 2)
        end
    end
end

function turtle:clear()
    love.graphics.setColor(1, 1, 1)
    self._color = {1, 1, 1}
    self._linesegments = {}
    love.graphics.setLineWidth(1)
    self._rainbowmode = false
    return self
end

function turtle:penup()
    self._drawing = false
    return self
end

function turtle:pendown()
    self._drawing = true
    return self
end

function turtle:rainbow()
    self._rainbowmode = true
    return self
end

function turtle:st()
    self:showturtle()
end

function turtle:showturtle()
    self._rurtleVisibility = true
    return self
end

function turtle:ht()
    self:hideturtle()
end

function turtle:hideturtle()
    self._turtleVisibility = false
    return self
end

function turtle:isvisible()
    return self._turtleVisibility
end

function turtle:pensize(size)
    self._size = size
    love.graphics.setLineWidth(size)
end

function turtle:speed(speed)
    self._drawspeed = speed
    return self
end

function turtle:fd(distance)
    self:forward(distance)
end

function turtle:forward(distance)
    local x, y = self._currentposition.x + distance * math.cos(self._direction), self._currentposition.y + distance * math.sin(self._direction)

    local c = get_color(self._color, self._rainbowmode)
    local line = newline(self._currentposition.x, self._currentposition.y, x, y, c, self._direction) 
    if self.drawing ~= false then
        table.insert(self._linesegments, line) 
    end

    self._currentposition.x, self._currentposition.y = x, y
    return self
end

function turtle:back(distance)
    self:backward(distance)
end

function turtle:bk(distance)
    self:backward(distance)
end

function turtle:backward(distance)
    self:forward(-distance)
    return self
end

function turtle:go_to(x, y)
    local c = get_color(self._color, self._rainbowmode)
    self._currentposition.x, self._currentposition.y = x, y
    return self
end

function turtle:rt(angle)
    turtle:right(angle)
end

function turtle:right(angle)
    self._direction = self._direction - math.rad(angle)
    return self
end

function turtle:lt(angle)
    turtle:left(angle)
end

function turtle:left(angle)
    self._direction = self._direction + math.rad(angle)
    return self
end

return setmetatable({new = new},
{__call = function(_, ...) return new(...) end})

