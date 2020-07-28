# turtle.lua

![](gif/love.gif)

<p float="left">
  <img src="gif/kochsnowflake.gif" width="320" />
  <img src="gif/multipleturtles.gif" width="320" /> 
</p>

# Turtle Methods

```lua

  forward() | fd()  
  backward() | bk() | back()
  right() | rt()
  left() | lt()
  tl()
  rt()
  speed()
  go_to() | go() | setpos() | setposition()
  setx()
  sety()
  setheading() | seth()
  home()
  callback()
  undo()
  clear()
  color()
  turtlecolor() | tc()
  pendown() | down() | pd()
  penup() | up() | pu()
  pensize()
  showturtle()
  hideturtle()
  isvisible()
  play()
  pause()
  toggle()
  name()
  print()
  
```

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
