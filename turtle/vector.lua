local Vector = {}
Vector.__index = Vector

local sqrt = math.sqrt

local function new(x, y)
    return setmetatable({
        x = x, y = y
    }
    , Vector)
end

function Vector.add(a, b)
    return new(a.x + b.x, a.y + b.y)
end

function Vector.sub(a, b)
    return new(a.x - b.x, a.y - b.y)
end

function Vector.div(v, divisor)
    assert(type(divisor) == "number", "error: divisor expects a number")
    assert(divisor ~= 0, "error: divisor must not be 0")
    return new(v.x / divisor, v.y / divisor)
end

function Vector.mul(v, multiplier)
    assert(type(multiplier) == "number", "error: multiplier expects a number")
    return new(v.x * multiplier, v.y * multiplier)
end

function addScalarWithAngle(v, d, angle)
    return new(v.x + d * math.cos(angle), v.y + d * math.sin(angle))
end

function lerp(a, b, t)
    return a + (b - a) * t
end

function Vector:angle(v)
    return math.atan((v.y - self.y) / (v.x - self.x))
end

function Vector:rotateAround(x, y, angle)
    local newPos = self + new(x, y)
    local sin, cos = math.sin(angle), math.cos(angle)
    return new(cos * (newPos.x - self.x) - sin * (newPos.y - self.y) + self.x, sin * (newPos.x - self.x) + cos * (newPos.y - self.y) + self.y)
end

function Vector:distance(v)
    local dx, dy = v.x - self.x, v.y - self.y
    return sqrt(dx * dx + dy * dy)
end

function Vector:clone()
    return new(self.x, self.y)
end

Vector.__add = Vector.add
Vector.__sub = Vector.sub
Vector.__div = Vector.div
Vector.__mul = Vector.mul

function Vector:__tostring()
    return "(" .. self.x .. ", " .. self.y .. ")"
end

return setmetatable({new = new},
{__call = function(_, ...) return new(...) end})

