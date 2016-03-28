-----------------------------------------------------------------------------------------
--
-- rect.lua
--
-----------------------------------------------------------------------------------------

function rect_new (positon_x,position_y,speed)
    local rect = display.newImage('img/rect.png',positon_x,position_y)
    rect.alpha = 0
    physics.addBody( rect,'static', { density=2, friction=0.5, bounce=0.3 } )

    if(speed == nil) then
    	rect.speed = 1
    else
    	rect.speed = speed
    end


  	local i = 0
  	local n
  	local PI = math.pi

    function rect:move1()
      i = i+1
  		n = (i/360)*(2*PI)
  		n = math.cos(n)
        	if (rect ~= nil)then
          		rect.x = rect.x + 2*n
        	return true
        	end
		return true
    end

    function rect:move2()
    	i = i+1
		n = (i/360)*(2*PI)
		n = math.cos(n)
		if (rect ~= nil)then
    		rect.x = rect.x - 2*n
    	return true
    	end
    	--print(n)
		return true
    end

    function rect:setColor()
        self:setFillColor(1, 0, 0)
    end

    return rect
end


return rect
