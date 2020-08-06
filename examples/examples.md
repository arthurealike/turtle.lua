# Examples 
We added some examples to introduce you turtle library. We've put code snippets to emphasize crucial point of
every example, if you get confused look into the examples/ and peruse the source code for better understanding.

## Colorful
```lua
function love.load()
    love.window.setTitle("Colorful")
    love.graphics.setBackgroundColor(.15, .15, .15)
    rainbow:pd():speed(1000)
    print(rainbow:isvisible())
    while x < 1000 do
        local idx = math.floor(c)
        color = colors[idx]
        rainbow:color(color)
        rainbow:forward(x / 2.5)
        rainbow:right(98)
        x = x + 1
        c = c + 0.1
    end
end

```
<div style='float: center'>
  <img style='width: 600px' src="https://github.com/arthurealike/turtle.lua/blob/master/gif/examples/colorful.gif"></img>
</div>

## Logo

```lua

function adidas(t, lineCount, offset_y, lineWidth)
    t:speed(20)
    --circle1
    t:pu():go_to(270, 280):pd()
    :begin_fill()
    :circle(120, 90)
    :right(90)
    :circle(120, 90):end_fill()

    local dx, dy = 135, 85
    --circle2
    t:pu():go_to(t:xcor() + dx, t:ycor() - dy):pd():begin_fill()
    :right(135)    
    :circle(155, 90)
    :right(90)    
    :circle(155, 90)
    :end_fill()

    --circle3
    t:pu():setx(t:xcor() + dx):sety(t:ycor() + dy):pd()
    :pd():begin_fill()
    :right(135)    
    :circle(120, 90)
    :right(90)    
    :circle(120, 90)
    :end_fill()

    local lineCount = lineCount or 3
    local offset_y = offset_y or 25
    local lineWidth = lineWidth or 15

    t:color(bg_color)
    t:pensize(lineWidth)
    --lines
    for i=1, lineCount do 
        t:up():go(240, 325 + (i - 1) * offset_y):down():seth(0):fd(300)
    end
end

```

<div style='float: center'>
  <img style='width: 600px' src="https://github.com/arthurealike/turtle.lua/blob/master/gif/examples/logo.gif"></img>
</div>

## Beauty
```lua
function love.load()
    for i=1, 360 * 3  do 
        speed = speed + 3
        turtle:fd(i * 3 / steps + 1):lt(360 / steps + 1):color(1- i / 900, 1 - i / 500, 0.7):speed(speed)
    end
end
```

<div style='float: center'>
  <img style='width: 600px' src="https://github.com/arthurealike/turtle.lua/blob/master/gif/examples/beauty.gif"></img>
</div>

## Spores
```lua
function love.load()
    for i=1, 20 do
        local spore = Spore()
        spore:st():up():setx(love.math.random(0, w)):sety(love.math.random(0, h)):speed(100):down()
        spawn(spore)
        table.insert(spores, spore)
    end
end


function love.draw()
    for _,spore in pairs(spores) do 
        spore:draw()
    end
end

function spawn(t)
	...
end

```
<div style='float: center'>
  <img style='width: 600px' src="https://github.com/arthurealike/turtle.lua/blob/master/gif/examples/spores.gif"></img>
</div>


## Snake

```lua
function love.update()
    if love.keyboard.isDown("w") then
        if love.keyboard.isDown("a") then
            snake:left(3)
        elseif love.keyboard.isDown("d") then
            snake:right(3)
        end
        snake:forward(speed)
    end
end
```
<div style='float: center'>
  <img style='width: 600px' src="https://github.com/arthurealike/turtle.lua/blob/master/gif/examples/snake.gif"></img>
</div>


## Spidey
```lua
local Spider = require "turtle"

local spider = Spider()
function love.load()
    spider:name("spidey"):setsprite("spider.png"):home():speed(15)
    spiderweb(spider)
end
```
<div style='float: center'>
  <img style='width: 600px' src="https://github.com/arthurealike/turtle.lua/blob/master/gif/examples/spidey.gif"></img>
</div>

## Machine 
```lua
function machine(t)
    t:pu():turtlecolor(0.3, 0, 0.5)
    for i=1, 181 do
        t:forward(120):color(.8, .8, .8)
        t:right(30)
        t:forward(50):color(.9, .9, .9)
        t:left(60)
        t:forward(100):color(sc)
        t:right(30)

        t:penup()
        t:home()
        t:pendown()

        t:right(2)
    end
end
```
<div style='float: center'>
  <img style='width: 600px' src="https://github.com/arthurealike/turtle.lua/blob/master/gif/examples/machine.gif"></img>
</div>
