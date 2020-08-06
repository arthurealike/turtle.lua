# Methods Overview
```lua

turtle:home()

turtle:draw() -- call this function in love.draw()

turtle:isdown() 

turtle:forward(d)

turtle:rt(deg)

turtle:right(deg)

turtle:lt(deg)

turtle:left(deg)

turtle:pd()

turtle:down()

turtle:pendown()

turtle:pu() 

turtle:up() 

turtle:penup()

turtle:pentoggle() 

turtle:pensize(...) 

turtle:position(...)

turtle:go(x, y) return self:go_to(x, y)  

turtle:setposition(x, y) return self:go_to(x, y)  

turtle:setpos(x, y) return self:go_to(x, y)  

turtle:go_to(x, y)

turtle:xcor()

turtle:ycor()

turtle:setx(x)

turtle:sety(y)

turtle:seth(deg) return self:setheading(deg)  

turtle:heading()

turtle:setheading(deg)

turtle:distance(x, y) 

turtle:setsprite(name)

turtle:ondrawfinish(ondrawfinish) 

turtle:nodecount() 

turtle:undo(c)

turtle:clear()

turtle:reset()

turtle:name(...)

turtle:isvisible()

turtle:st() return self:showturtle()  

turtle:showturtle() 

turtle:ht() return self:hideturtle()  

turtle:hideturtle() 

turtle:play() 
   
turtle:pause() 

turtle:toggle() 

turtle:tl()

turtle:tr() 

turtle:back(d) return self:forward(-d)     

turtle:bd(d) return self:forward(-d)     

turtle:backward(d) 

turtle:fd(d) return self:forward(d)    

turtle:speed(speed)                     

turtle:tc(...)

turtle:turtlecolor(...)

turtle:fillcolor(...)                          

turtle:color(...)  -- Set color or return color

turtle:begin_fill()

turtle:end_fill()

turtle:debugon()

turtle:debugoff()

turtle:_drawDebug()

turtle:circle(radius, ext ) 

turtle:print()

--TODO

turtle:shape() 
 

turtle:dot()
 

turtle:stamp()

--
```
