local Vector2 = require "vector"
local Path = require "path"

local loadSprite = function (name)
    local fileLoc = "sprites/" .. name
    local f = io.open(fileLoc)
    if f then
        f:close()
        return love.graphics.newImage(fileLoc)
    end
end

local Turtle = Object:extend()

function Turtle:new(x, y, speed)
    self.pos = Vector2(x, y)
    self.sprite = loadSprite("turtle.png")
    self.speed = speed or 20
    self.path = Path(self.pos)
    self.ratio = 0
    self.angle = 0
end

function Turtle:f(d)
    self.path:addNodeWithDistance(d, self.angle)
    return self
end

function Turtle:l() return self:rot(-90) end
function Turtle:r() return self:rot(90) end

function Turtle:rot(deg)
    self.angle = self.angle + math.rad(deg)
    return self
end

function Turtle:draw()
    self.path:draw()
    love.graphics.draw(self.sprite, self.pos.x, self.pos.y, self.path:angle(), 1, 1, 8, 8)
end

function Turtle:update(dt)
    local ratio = dt * self.speed / 1000

    self.path:addRatio(ratio)
    self.pos = self.path.lastPos:clone()
end

function Turtle:print()
    for _, value in ipairs(self.path.nodes) do
        print(value)
    end
end

return Turtle