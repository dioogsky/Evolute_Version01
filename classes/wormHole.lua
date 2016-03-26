-----------------------------------------------------------------------------------------
--
-- wormHole.lua
--
-----------------------------------------------------------------------------------------

function wormHole_new (positon_x,position_y)
    local wormHole = display.newRect(positon_x,position_y,6,100)
    wormHole:setFillColor(0.49, 0.24, 0.69)
    physics.addBody( wormHole,'static', { density=2, friction=0.5, bounce=0.3 } )
    
	
	function wormHole:setColor()
      wormHole:setFillColor(1, 0, 0)
    end
	
	return wormHole  
end

return wormHole



