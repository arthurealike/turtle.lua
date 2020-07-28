# turtle.lua for LÖVE

![LÖVE](gif/love.gif)

<p float="left">
  <img src="gif/kochsnowflake.gif" width="300" />
  <img src="gif/multipleturtles.gif" width="300" /> 
</p>

# Turtle Methods

## 1. Turtle motion
  * Move and draw

  ```lua
   forward() | fd()  
   backward() | bk() | back()
   right() | rt()
   left() | lt()
   tl()
   rt()
   setheading() | seth()
   home()
   go_to() | go() | setpos() | setposition()
   setx()
   sety()
   undo()
   speed()
```
  * Turtle's state
```lua
   position()
   heading()
   distance()
   name()
   print()
```

## 2. Pen control
  * Drawing state
  ```lua
   pendown() | pd() | down()
   penup() | pu() | up()
   pensize() | width()
   isdown()
  ```
  * Color control
  ```lua
   color()
  ```
  * Drawing control
  ```lua 
   reset()
   clear()
  ```

## 3. Turtle state
  * Visibility
  ```lua
   showturtle() | st()
   hideturtle() | ht()
   isvisible()
```
  * Color
  ```lua
   turtlecolor() | tc()
  ```
## 4. Event

```lua 
 ondrawfinish() 
```
## 5. Animation

```lua
 play()
 pause()
 toggle()
  
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
