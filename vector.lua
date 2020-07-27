local sqrt = math.sqrt

local Vector = Object:extend()

function Vector:new(x, y)
    self.x = x
    self.y = y
end

function Vector.add(a, b)
    return Vector(a.x + b.x, a.y + b.y)
end

function Vector.sub(a, b)
    return Vector(a.x - b.x, a.y - b.y)
end

function Vector.div(v, divisor)
    assert(type(divisor) == "number", "error: divisor expects a number")
    assert(divisor ~= 0, "error: divisor must not be 0")
    return Vector(v.x / divisor, v.y / divisor)
end

function Vector.mul(v, multiplier)
    assert(type(multiplier) == "number", "error: multiplier expects a number")
    return Vector(v.x * multiplier, v.y * multiplier)
end

function Vector.addScalarWithAngle(v, d, angle)
    return Vector(v.x + d * math.cos(angle), v.y + d * math.sin(angle))
end

function Vector.lerp(a, b, t)
    return a + (b - a) * t
end

function Vector:d(v)
    local dx, dy = v.x - self.x, v.y - self.y
    return sqrt(dx * dx + dy * dy)
end

function Vector:clone()
    return Vector(self.x, self.y)
end

Vector.__add = Vector.add
Vector.__sub = Vector.sub
Vector.__div = Vector.div
Vector.__mul = Vector.mul

function Vector:__tostring()
    return "(" .. self.x .. ", " .. self.y .. ")"
end

return Vector