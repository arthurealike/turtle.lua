# Methods Overview

turtle:setsprite(name)

turtle:ondrawfinish(ondrawfinish) 

turtle:nodecount() 

turtle:forward(d)

turtle:undo(c)

turtle:clear()

turtle:reset()

turtle:name(...)

turtle:rt(deg)

turtle:right(deg)

turtle:lt(deg)

turtle:left(deg)

turtle:xcor()

turtle:ycor()

turtle:setx(x)

turtle:sety(y)

turtle:position(...)

turtle:go(x, y) return self:go_to(x, y)  

turtle:setposition(x, y) return self:go_to(x, y)  

turtle:setpos(x, y) return self:go_to(x, y)  

turtle:go_to(x, y)

turtle:seth(deg) return self:setheading(deg)  

turtle:heading()

turtle:setheading(deg)

turtle:distance(x, y) 

turtle:home()

turtle:isdown()

turtle:pd() return self:pendown()  

turtle:down() return self:pendown()  

turtle:pendown()

turtle:pu() return self:penup()  

turtle:up() return self:penup()  

turtle:penup()

turtle:pentoggle() 

turtle:pensize(...) 

turtle:isvisible()

turtle:st() return self:showturtle()  

turtle:showturtle() 

turtle:ht() return self:hideturtle()  

turtle:hideturtle() 

turtle:play() 
   
turtle:pause() 

turtle:toggle() 

turtle:tl() return self:heading(-90)         -- Turn left

turtle:tr() return self:heading(90)          -- Turn right

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

turtle: _end_fill()

turtle:debugon()

turtle:debugoff()

turtle:_drawDebug()

turtle:circle(radius, ext ) 

turtle:print()

  turtle:draw()


--TODO

turtle:shape() 
 

turtle:dot()
 

turtle:stamp()
 

--

