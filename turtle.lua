local Vector2 = require "vector"
local Path = require "path"

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

local function new(x, y, speed)
    pos = Vector2(x, y) 
    return setmetatable(
    {
        _pos = pos ,
        _sprite = loadSprite("turtle.png") ,
        _speed = speed or 20 ,
        _path = Path(pos) ,
        _ratio = 0 ,
        _angle = 0 

    }, turtle)
end

function turtle:f(d)
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
    local ratio = dt * self._speed / 1000

    self._path:addRatio(ratio)
    self._pos = self._path.lastPos:clone()
    self._path:draw()
    love.graphics.draw(self._sprite, self._pos.x, self._pos.y, self._path:angle(), 1, 1, 8, 8)
end

function turtle:update(dt)
end

function turtle:print()
    for _, value in ipairs(self._path.nodes) do
        print(value)
    end
end

return setmetatable({new = new},
{__call = function(_, ...) return new(...) end})
