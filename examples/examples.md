# Examples 
We added some examples to introduce you turtle library.

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
