-----------------------------------------------------------------------------------------
--
-- gate.lua
--
-----------------------------------------------------------------------------------------

function gateR_new (position_y,speed)
    local gateR = display.newImage('img/gateRight.png',356,position_y)
    gateR.IsOpen = 0
    gateR.anchorX,gateR.anchorY = 1,0.5
    gateR.angular = 0
    --local gateRight = display.newImage('img/gateRight.png',display.contentCenterX+80,position_y)
    --rect.alpha = 0
    physics.addBody( gateR,'static', { density=2, friction=0.5, bounce=0.3 } )
    --physics.addBody( gateRight,'static', { density=10, friction=0.5, bounce=0.3 } )

    -- if(speed == nil) then
    -- 	gateLeft.speed,gateRight.speed = 1,1
    -- else
    -- 	gateLeft.speed,gateRight.speed = speed,speed
    -- end

    -- function gateLeft:move1()
    --
    -- end
    return gateR
end


return gateR
