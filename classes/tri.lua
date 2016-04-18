-----------------------------------------------------------------------------------------
--
-- tri.lua
--
-----------------------------------------------------------------------------------------

function tri_new (positon_x,position_y,speed)

    local tri = display.newImage('img/triangle.png',positon_x,position_y)
    tri.myName = "tri"
    physics.addBody( tri,'static' ,{ density=2, friction=0.5, bounce=0.3 } )

  	local i = 0
  	local n
  	local PI = math.pi

    function tri:move1()
    	i = i+1
  		n = (i/360)*(2*PI)
  		n = math.cos(n)
    	tri.x = tri.x + 2*n
    end

    function tri:move2()
    	i = i+1
  		n = (i/360)*(2*PI)
  		n = math.cos(n)
    	tri.x = tri.x - 2*n
    end

  	function tri:rotate1()
  	   if(tri.myName ~= nil) then
      	tri:rotate(speed)
       end
  	end

	return tri
end


return tri
