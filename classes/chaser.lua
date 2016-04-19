-----------------------------------------------------------------------------------------
--
-- chaser.lua
--
-----------------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Build chaser
--------------------------------------------------------------------------------

function chaser_new (positon_x,position_y,speed)
    local chaser = display.newCircle(positon_x, position_y,10)
    chaser: setFillColor(0.7,0.1,0.1)
  	chaser.anchorX = 0.5 -- Slightly more "realistic" than center-point rotating
  	chaser.speed = speed
  	physics.addBody( chaser, { density=2, friction=0.5, bounce=0.3 } )

	return chaser
end


return chaser
