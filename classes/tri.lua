-----------------------------------------------------------------------------------------
--
-- tri.lua
--
-----------------------------------------------------------------------------------------

function tri_new (positon_x,position_y,speed)
    --local tri = display.newPolygon( positon_x, position_y, {positon_x,position_y+12 ,positon_x+7,position_y, positon_x-7,position_y} )
    --tri.anchorX = 0.2
    --tri.anchorY = 0.2
    --tri:setFillColor(1,0.96,0.47)
    --tri.strokeWidth = 1
    --tri:setStrokeColor( 0.88, 0.88, 0.88 )
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
    	--print(n)
	--return true
    end
    
    function tri:move2()
    	i = i+1
		n = (i/360)*(2*PI)
		n = math.cos(n)
    	tri.x = tri.x - 2*n	
    	--print(n)
	--return true
    end
    
    
	function tri:rotate1()
	if(tri.myName ~= nil) then
    	tri:rotate(speed)
    end	
	end
	
	return tri 
end


return tri



