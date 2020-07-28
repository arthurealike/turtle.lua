local Vector2 = require "vector"
local Path = require "path"

_TURTLEIMAGE = "turtle.png"

local turtle = {}
turtle.__index = turtle

local loadSprite = function (name)
    local fileLoc = "sprites/" .. name
    local f = io.open(fileLoc)
    if f then
        f:close()
        return love.graphics.newImage(fileLoc)
    end
end

local function new(x, y, speed, color)
    _x, _y = x or love.graphics.getWidth() / 2, y or love.graphics.getHeight() / 2
    pos = Vector2(_x, _y) 
    color = color or {1, 1, 1}
    return setmetatable(
    {
        _pos = pos,
        _sprite = loadSprite(_TURTLEIMAGE) ,
        _speed = speed or 10 ,
        _path = Path(pos) ,
        _color = color ,
        _ratio = 0 ,
        _angle = 0 

    }, turtle)
end

function turtle:speed(speed)
    self._speed = speed
    return self
end

function turtle:color(...)
    self._rainbowmode = false
    local c = self._color
    local nargs = select("#", ...)
    if nargs == 3 then
        c = {...}
    elseif nargs == 1 then 
        c = ... 
    end
    self._color = c
    return self
end

function turtle:fd(d)
    return self:forward(d)
end

function turtle:right(deg)
    self._angle = self._angle + math.rad(deg)
    return self
end

function turtle:left(deg)
    self._angle = self._angle - math.rad(deg)
    return self
end

function turtle:forward(d)
    self._path:addNodeWithDistance(d, self._angle)
    return self
end

function turtle:l() return self:rot(-90) end
function turtle:r() return self:rot(90) end

function turtle:rot(deg)
    self._angle = self._angle + math.rad(deg)
    return self
end

function turtle:draw()
    dt = love.timer.getDelta()
    local ratio =  self._speed / 100

    self._path:addRatio(ratio)
    if self._path.lastPos then
        self._pos = self._path.lastPos:clone()
    end
    love.graphics.setColor(self._color)
    self._path:draw()
    love.graphics.setColor(1, 1, 1)
    if self._sprite then
        love.graphics.draw(self._sprite, self._pos.x, self._pos.y, self._path:angle(), 1, 1, 8, 8)
    end
end

function turtle:print()
    for _, value in ipairs(self._path.nodes) do
        print(value)
    end
end

return setmetatable({new = new},
{__call = function(_, ...) return new(...) end})
