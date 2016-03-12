-----------------------------------------------------------------------------------------
--
-- saw.lua
--
-----------------------------------------------------------------------------------------

function saw_new (positon_x,position_y,speed)

    local saw = display.newImage('img/saw.png',positon_x,position_y)
    saw.myName = "saw"
    physics.addBody( saw,'static' ,{ density=2, friction=0.5, bounce=0.3 } )
    
	local i = 0
	local n 
	local PI = math.pi
    
    function saw:move1()
    	i = i+1
		n = (i/360)*(2*PI)
		n = math.cos(n)
    	saw.x = saw.x + 2*n	
    	--print(n)
	--return true
    end
    
    function saw:move2()
    	i = i+1
		n = (i/360)*(2*PI)
		n = math.cos(n)
    	saw.x = saw.x - 2*n	
    	--print(n)
	--return true
    end
    
    
	function saw:rotate1()
		if(saw.myName ~= nil) then
    		saw:rotate(speed)
    	end	
	end
	
	return saw 
end


return saw



