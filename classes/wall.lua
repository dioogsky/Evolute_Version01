-----------------------------------------------------------------------------------------
--
-- wall.lua
--
-----------------------------------------------------------------------------------------

function wall_new (positon_x,position_y)
    local wall = display.newImage('img/wall.png',positon_x,position_y)
    physics.addBody( wall,'static', { density=2, friction=0.5, bounce=0.3 } )
	
	function wall:setColor()
      wall:setFillColor(1, 0, 0)
    end
	
	return wall  
end


return wall



