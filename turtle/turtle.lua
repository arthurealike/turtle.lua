-----------------------------------------------------------
--            (c) 2020 Mustafa Erkam Badin               --
-----------------------------------------------------------
-- Source: https://github.com/arthurealike/turtle.lua    --
-----------------------------------------------------------
local Vector2 = require "vector"

originx, originy = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2

_TURTLEIMAGE = "turtle.png"

local turtle = {}
turtle.__index = turtle

local loadSprite = function (name)
    local fileLoc = name
    local f = io.open(name, "r")
    if f then
        f:close()
        return love.graphics.newImage(fileLoc)
    end
end

local function Node(x, y)
    return {
        _pos = Vector2(x, y) ,
        _distance = 0 ,
        _angle = 0 ,
        _color = nil ,
        _speed = 0 ,
        _fillGroup = -1 ,
    }
end

local function new(x, y, speed, color, name, ondrawfinish)
    _x, _y = x or love.graphics.getWidth() / 2, y or love.graphics.getHeight() / 2
    pos = Vector2(_x, _y) 
    return setmetatable(
    {
        _name = name or "sweet_turtle" ,
        _pos = pos ,
        _currentPos = pos ,
        _sprite = loadSprite(_TURTLEIMAGE) ,
        _speed = 10 ,
        _pensize = 1 ,
        _nodes = {} ,
        _color = {1, 1, 1} ,
        _drawing = true ,
        _fill = false ,
        _fillGroupIndex = 1 ,
        _fillColors = {} ,
        _turtlevisible = true ,
        _turtlecolor = {1, 1, 1} ,
        _ratio = 0 ,
        _angle = 0 ,
        _drawAngle = 0 ,
        _currentDistance = 0 ,
        _totalDistance = 0 ,
        _dt = 0 ,
        _playing = true ,
        _nodeIndex = -1 ,
        _lastNodeDrawPos = nil ,
        _finalized = false ,
        _ondrawfinish = ondrawfinish ,
        _visible = true ,
        _debug = false ,

    }, turtle)
end

function turtle:_createNode(x, y)
    local node = Node(x, y)
    node._speed = self._speed
    node._color = self._color
    node._angle = self._angle
    node._size = self._pensize
    node._lineVisible = self._drawing
    if self._fill then
        node._fillGroup = self._fillGroupIndex
    end
    return node
end

function turtle:setsprite(name)
    self._sprite = loadSprite(name)
    return self
end

function turtle:ondrawfinish(ondrawfinish) 
    self._ondrawfinish = ondrawfinish 
end

function turtle:nodecount() return #self._nodes end

function turtle:forward(d)
    local pos = self._pos
    if next(self._nodes) ~= nil then
        pos = self._nodes[#self._nodes]._pos
    end
    pos = addScalarWithAngle(pos, d, self._angle)
    self._nodes[#self._nodes+1] = self:_createNode(pos.x, pos.y)
    self._finalized = false

    self:_calculateTotalDistance()
    return self
end

function turtle:undo(c)
    c = c or 1

    for i = #self._nodes, math.max(0, #self._nodes - c), -1 do
        table.remove(self._nodes, i)
    end

    self._nodeIndex = math.min(#self._nodes, self._nodeIndex)
    self:_calculateTotalDistance()
    return self
end

function turtle:_calculateTotalDistance()
    local dist = 0
    local lastPos = self._pos
    for i = 1, #self._nodes, 1 do
        local node = self._nodes[i]
        local vd = node._pos:distance(lastPos)

        node._distance = vd
        dist = dist + vd

        lastPos = node._pos
    end
    self._totalDistance = dist
end

function turtle:clear()
    self._currentPos = self._currentPos
    self._currentDistance = 0
    self._playing = false
    self._nodeIndex = -1
    self._lastNodeDrawPos = nil
    self._dt = 0
    self._finalized = false
end

function turtle:reset()
    self._currentPos = self._pos
    self._currentDistance = 0
    self._playing = false
    self._nodeIndex = -1
    self._lastNodeDrawPos = nil
    self._dt = 0
    self._finalized = false
end

function turtle:name(...)
    local nargs = select("#", ...)
    if nargs ~= 0 then 
        self._name = select("1", ...)
        return self
    end
    return self._name
end

function turtle:rt(deg)
    return self:right(deg)
end

function turtle:right(deg)
    self._angle = self._angle + math.rad(deg)
    return self
end

function turtle:lt(deg)
    return self:left(deg)
end

function turtle:left(deg)
    self._angle = self._angle - math.rad(deg)
    return self
end

function turtle:xcor()
    local x = self._currentPos.x
    if #self._nodes > 0 then
        print("not nil")
        x = self._nodes[#self._nodes]._pos.x    
    end
    return x
end

function turtle:ycor()
    local y = self._currentPos.y
    if #self._nodes > 0 then
        print("not nil")
        y = self._nodes[#self._nodes]._pos.y    
    end
    return y
end

function turtle:setx(x)
    self:go_to(x, self:ycor())
    return self
end

function turtle:sety(y)
    self:go_to(self:xcor(), y)
    return self
end

function turtle:position(...)
    local nargs = select("#", ...)
    if nargs == 2 then
        local x, y = select("1", ...), select("2", ...)
        self._currentPos.x, self._currentPos.y = x, y
        print(x, y)
    end 
    return self,self._currentPos.x, self._currentPos.y
end

function turtle:go(x, y) return self:go_to(x, y) end

function turtle:setposition(x, y) return self:go_to(x, y) end

function turtle:setpos(x, y) return self:go_to(x, y) end

function turtle:go_to(x, y)
    local pos = self._pos
    if next(self._nodes) ~= nil then pos = self._nodes[#self._nodes]._pos end
    local angle = Vector2(x, y):angle(pos)
    local node = self:_createNode(x, y)
    node._angle = angle
    node._visible = self._drawing
    self._nodes[#self._nodes + 1] = node
    return self
end

function turtle:seth(deg) return self:setheading(deg) end

function turtle:heading()
    return self._angle
end

function turtle:setheading(deg)
    self._angle = math.rad(deg)
    return self
end

function turtle:distance(x, y) 
    local dx, dy = x - self.x, y - self.y
    return math.sqrt(dx * dx + dy * dy)
end

function turtle:home()
    self:go_to(originx, originy)
    return self
end

function turtle:isdown()
    return self._drawing
end

function turtle:pd() return self:pendown() end
function turtle:down() return self:pendown() end
function turtle:pendown()
    self._drawing = true
    return self
end

function turtle:pu() return self:penup() end
function turtle:up() return self:penup() end
function turtle:penup()
    self._drawing = false
    return self
end

function turtle:pentoggle() 
    self._drawing = not self._drawing
    return self
end

function turtle:pensize(...) 
    local nargs = select("#", ...)
    if nargs ~= 0 then 
        self._pensize = select("1", ...)
        return self
    end
    return self._pensize
end

function turtle:isvisible()
    return self._visible
end 

function turtle:st() return self:showturtle() end
function turtle:showturtle() 
    self._visible = true
    return self
end

function turtle:ht() return self:hideturtle() end

function turtle:hideturtle() 
    self._visible = false
    return self
end

function turtle:play() 
    self._playing = true
    return self
end     

function turtle:pause() 
    self._playing = false
    return self
end   

function turtle:toggle() 
    self._playing = not self._playing
    return self
end

function turtle:tl() return self:heading(-90) end       -- Turn left
function turtle:tr() return self:heading(90) end        -- Turn right

function turtle:back(d) return self:forward(-d) end   
function turtle:bd(d) return self:forward(-d) end   

function turtle:backward(d) 
    return self:forward(-d)
end    -- backward

function turtle:fd(d) return self:forward(d) end  

function turtle:speed(speed)                     
    self._speed = speed
    return self
end

function turtle:tc(...)
    return self:turtlecolor(...)
end

function turtle:turtlecolor(...)
    local c = self._turtlecolor
    local nargs = select("#", ...)
    if nargs < 1 then
        return self._turtlecolor()
    elseif nargs == 3 then
        c = {...}
    elseif nargs == 1 then 
        c = ... 
    end
    self._turtlecolor = c
    print(self._turtlecolor[1], self._turtlecolor[2], self._turtlecolor[3])
    return self
end

function turtle:color(...)                          -- Set color
    local c = self._color
    local nargs = select("#", ...)
    if nargs < 1 then
        return self._turtlecolor()
    elseif nargs == 3 then
        c = {...}
    elseif nargs == 1 then 
        c = ... 
    end
    self._color = c
    return self
end

function turtle:fillcolor(...)                          -- Set color
    local c = self._color
    local nargs = select("#", ...)
    if nargs < 1 then
        return self._turtlecolor()
    elseif nargs == 3 then
        c = {...}
    elseif nargs == 1 then 
        c = ... 
    end
    self._fillColors[self._fillGroupIndex] = c
    return self
end


function turtle:begin_fill()
    self._fill = true
    return self
end

function turtle:end_fill()
    self._fill = false
    self._fillGroupIndex = self._fillGroupIndex + 1
    return self
end

function turtle:_drawPath()
    local lastPos = self._pos
    local fillVertices, fillGroup = {}, 0
    for i = 1, self._nodeIndex, 1 do
        local node = self._nodes[i]
        if node._lineVisible then
            local drawPos = node._pos
            if i == self._nodeIndex then
                drawPos = self._lastNodeDrawPos
            end
            if fillGroup ~= node._fillGroup then
                fillVertices = {}
                fillGroup = node._fillGroup
            end
            if node._fillGroup > 0 then
                if #fillVertices == 0 then 
                    table.insert(fillVertices, lastPos.x)
                    table.insert(fillVertices, lastPos.y)
                end
                table.insert(fillVertices, drawPos.x)
                table.insert(fillVertices, drawPos.y)
            end
            if #fillVertices >= 6 then
                if self._fillColors[fillGroup] ~= nil then
                    love.graphics.setColor(self._fillColors[fillGroup])
                elseif next(self._fillColors) ~= nil then
                    love.graphics.setColor(self._fillColors[#self._fillColors])
                end
                love.graphics.polygon("fill", fillVertices)
            end
            if node._color ~= nil then
                love.graphics.setColor(node._color)
            end
            love.graphics.setLineWidth(node._size)
            love.graphics.line(lastPos.x, lastPos.y, drawPos.x, drawPos.y)
        end
        lastPos = node._pos
    end
end

function turtle:draw()
    local dt = love.timer.getDelta()

    self:update(dt)
    self:_drawPath()

    love.graphics.setColor({1,1,1})

    love.graphics.setColor(self._turtlecolor)

    if self._visible == true and self._sprite then
        love.graphics.setColor(self._turtlecolor)
        love.graphics.draw(self._sprite, self._currentPos.x, self._currentPos.y, self._drawAngle, 1, 1, 8, 8)
    end

    if self._debug then
        self:_drawDebug()
    elseif self._sprite == nil and self._visible == true then
        self:_drawTriangle()
    end

    love.graphics.setColor(self._color or {1, 1, 1})
end

--TODO

function turtle:shape() 
end

function turtle:dot()
end

function turtle:stamp()
end

function turtle:update(dt)
    if next(self._nodes) == nil then return end
    if self._finalized or not self._playing then return end

    local lastPos = self._pos
    local node = self._nodes[math.max(self._nodeIndex, 1)]
    local speed = node._speed
    local angle = node._angle

    self._dt = self._dt + dt * speed * 100

    local ratio = math.min(1.0, math.max(0.0, self._dt / self._totalDistance))
    local reachDistance = self._totalDistance * ratio

    for i = 1, #self._nodes, 1 do
        local node = self._nodes[i]
        local diff = reachDistance - node._distance

        if diff < 0 then
            self._nodeIndex = i
            self._lastNodeDrawPos = lerp(lastPos, node._pos, reachDistance / node._distance)
            self._currentPos = self._lastNodeDrawPos
            break
        end

        reachDistance = diff
        lastPos = node._pos
        self._currentPos = lastPos
    end

    self._drawAngle = angle

    if ratio == 1.0 and not self._finalized then
        self._nodeIndex = #self._nodes
        self._lastNodeDrawPos = self._nodes[self._nodeIndex]._pos
        self._finalized = true
        if self._ondrawfinish ~= nil then self._ondrawfinish() end
    end
end

function turtle:debugon()
    self._debug = true
    self._debugTexts = {
        fps = love.graphics.newText(love.graphics.getFont(), "FPS: -") ,
        name = love.graphics.newText(love.graphics.getFont(), self._name) ,
        nodeCount = love.graphics.newText(love.graphics.getFont(), "NODES: 0") ,
        position = love.graphics.newText(love.graphics.getFont(), "...")
    }
    return self
end

function turtle:debugoff()
    self._debug = false
    self._debugTexts = {}
end

function turtle:_drawDebug()
    self._debugTexts.fps:set("FPS: " .. love.timer.getFPS())
    self._debugTexts.nodeCount:set("NODES: " .. #self._nodes)

    if self._lastNodeDrawPos ~= nil then 
        self._debugTexts.position:set(self._lastNodeDrawPos)

        local r, g, b, a = love.graphics.getColor()
        love.graphics.setColor({0.4, 0.4, 0.4})
        love.graphics.draw(self._debugTexts.name, self._lastNodeDrawPos.x + 8, self._lastNodeDrawPos.y - 8)

        if not self._drawing and self._visible == true then love.graphics.setColor(1, 0, 0) else love.graphics.setColor(1, 1, 0) end
        self:_drawTriangle()

        love.graphics.setColor(r, g, b, a)
    end

    love.graphics.draw(self._debugTexts.fps, 0, 0)
    love.graphics.draw(self._debugTexts.nodeCount, 0, 15)
    love.graphics.draw(self._debugTexts.position, 0, love.graphics.getHeight() - 15)
end

function turtle:circle(radius, extend) 
    local extend = extend or 360
    radius = math.abs(radius)
    local m = ((radius * 6) / math.deg(math.pi)) / 2
    print(m)
    for i=1, extend do 
        self:fd(m)
        if extend > 0 then self:rt(1)
        else self:lt(1) 
        end
    end
    return self
end

function turtle:_drawTriangle()
    local pos = self._currentPos
    local angle = self._angle

    if next(self._nodes) ~= nil then 
       -- angle = self._nodes[self._nodeIndex] or 0
    end

    local a, b, c = pos:rotateAround(-5, -5, angle), pos:rotateAround(-5, 5, angle), pos:rotateAround(5, 0, angle)
    love.graphics.polygon("fill", a.x, a.y, b.x, b.y, c.x, c.y)
end

function turtle:print()
    for _, value in ipairs(self._path.nodes) do
        print(value)
    end
end

return setmetatable({new = new},
{__call = function(_, ...) return new(...) end})
