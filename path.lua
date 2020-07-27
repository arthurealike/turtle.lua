local Vector2 = require "vector"

local Path = Object:extend()
local Node = Object:extend()

function Node:new(x, y, d, a)
    self.pos = Vector2(x, y)
    self.distance = d
    self.angle = a
end

function Path:new(initialPos)
    self.nodes = {}
    self.totalDistance = 0
    self.initialPos = initialPos:clone()
    self.pathDrawRatio = 0.0
    self.nodeDrawRatio = 1.0
    self.nodeIndex = -1
    self.lastPos = nil
end

function Path:angle()
    if self.nodeIndex == -1 then return 0 end
    return self.nodes[self.nodeIndex].angle
end

function Path:addNodeWithDistance(distance, angle)
    local pos = self.initialPos
    if next(self.nodes) ~= nil then
        pos = self.nodes[#self.nodes].pos
    end

    pos = Vector2.addScalarWithAngle(pos, distance, angle)
    self.nodes[#self.nodes+1] = Node(pos.x, pos.y, -1, angle)
    
    local dist = 0

    local lastPos = self.initialPos
    for i = 1, #self.nodes, 1 do
        local node = self.nodes[i]
        local d = node.pos:d(lastPos)
        
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
            self.lastPos = Vector2.lerp(lastPos, node.pos, self.nodeDrawRatio)
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

return Path