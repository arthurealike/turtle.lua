# turtle.lua

# Quick example
```lua
local line = Turtle()
local circle = Turtle(100,100,1)
local rectangle = Turtle(100,150,1, {1, 1, 1})

function love.load()
    local red = {1, 0, 0}
    line:clear():right(35):forward(100)
    circle:setcolor(1,1,1):penup()
    for i=1, 360 do
        circle:pendown():right(1):forward(2)
    end
    triangle:setcolor(red):left(60):forward(50):right(120):forward(50):left(60):backward(50)
end

function love.draw()
    line:draw()
    circle:draw()
    rectangle:draw()
end


```


![snowflake](gif/kochsnowflake.gif)
![multiple](gif/multipleturtles.gif)


