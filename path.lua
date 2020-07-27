local Vector2 = require "vector"

local Path = {}
Path.__index = Path

local function Node(x, y, d, a)
    return {
        pos = Vector2(x, y) ,
        distance = d ,
        angle = a
    }
end

local function new(initialPos)
    return setmetatable(
    {
        nodes = {} ,
        totalDistance = 0 ,
        initialPos = initialPos:clone() ,
        pathDrawRatio = 0.0 ,
        nodeDrawRatio = 1.0 ,
        nodeIndex = -1 ,
        lastPos = nil 
    }
    , Path)
end

function Path:angle()
    if self.nodeIndex == -1 then return 0 end
    return self.nodes[self.nodeIndex].angle
end

function Path:addNodeWithDistance(distance, angle)
    local pos = self.initialPos
    print("pos = ".. pos:__tostring())
    if next(self.nodes) ~= nil then
        pos = self.nodes[#self.nodes].pos
    end

    pos = addScalarWithAngle(pos, distance, angle)
    self.nodes[#self.nodes+1] = Node(pos.x, pos.y, -1, angle)

    local dist = 0

    local lastPos = self.initialPos
    for i = 1, #self.nodes, 1 do
        local node = self.nodes[i]
        local d = node.pos:distance(lastPos)

        node.distance = d
        dist = dist + d

        lastPos = node.pos
    end
    self.totalDistance = dist
end

function Path:addRatio(p)
    if p == 0 then return end
    self.pathDrawRatio = math.min(1.0, math.max(0.0, self.pathDrawRatio + p))

    local lastPos = self.initialPos
    local reachDistance = self.totalDistance * self.pathDrawRatio

    for i = 1, #self.nodes, 1 do
        local node = self.nodes[i]
        local diff = reachDistance - node.distance

        if diff <= 0 then
            self.nodeDrawRatio = reachDistance / node.distance
            self.nodeIndex = i
            self.lastPos = lerp(lastPos, node.pos, self.nodeDrawRatio)
            break
        end

        reachDistance = diff
        lastPos = node.pos
    end
end

function Path:draw()
    local lastPos = self.initialPos
    for i = 1, #self.nodes, 1 do
        local node = self.nodes[i]
        if i == self.nodeIndex then
            love.graphics.line(lastPos.x, lastPos.y, self.lastPos.x, self.lastPos.y)
            break
        else
            love.graphics.line(lastPos.x, lastPos.y, node.pos.x, node.pos.y)
        end
        lastPos = node.pos
    end
end

return setmetatable({new = new},
{__call = function(_, ...) return new(...) end})
