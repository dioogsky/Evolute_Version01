-----------------------------------------------------------------------------------------
--
-- gate.lua
--
-----------------------------------------------------------------------------------------

function gateL_new (position_y,speed)
    local gateL = display.newImage('img/gateLeft.png',15,position_y)
    gateL.IsOpen = 0
    gateL.anchorX,gateL.anchorY = 0,0.5
    gateL.angular = 0
    physics.addBody( gateL,'static', { density=2, friction=0.5, bounce=0.3 } )


    -- if(speed == nil) then
    -- 	gateLeft.speed,gateRight.speed = 1,1
    -- else
    -- 	gateLeft.speed,gateRight.speed = speed,speed
    -- end


    -- function gateLeft:move1()
    --
    -- end
    return gateL
end


return gateL
