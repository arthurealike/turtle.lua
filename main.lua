local turtle = require "turtle"

function snowflake(l, c)
    if c < 1 then
        turtle:forward(l)
        return nil
    end
    l = l / 3
    snowflake(l, c-1)
    turtle:left(60)
    snowflake(l, c-1)
    turtle:right(120)
    snowflake(l, c-1)
    turtle:left(60)
    snowflake(l, c-1)
end

function love.load()
    turtle:init()
    local l = 300
    turtle:penup()
    turtle:backward(l / 2)
    turtle:pendown()

    for i=1, 3 do
        snowflake(300, 3)
        turtle:right(120)
    end
end

function love.update(dt)

end

function love.draw()
    turtle:draw()
end
