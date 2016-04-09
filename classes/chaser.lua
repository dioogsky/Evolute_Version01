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


	local i = 0
	local n
	local PI = math.pi

	function  chaser:move1()
		local n = 1.0
		if(dist_y == nil and dist_x == nil) then
        	chaser.y = chaser.y
    	elseif(touch_x >= display.contentCenterX and touch_y >= display.contentCenterY) then
        	chaser.y=chaser.y+n*dist_y
        	chaser.x=chaser.x+n*dist_x
    	elseif(touch_x <= display.contentCenterX and touch_y >= display.contentCenterY) then
        	chaser.y=chaser.y+n*dist_y
        	chaser.x=chaser.x+n*dist_x
    	elseif(touch_x <= display.contentCenterX and touch_y <= display.contentCenterY ) then
        	chaser.y=chaser.y-n*dist_y
        	chaser.x=chaser.x-n*dist_x
    	elseif(touch_x >= display.contentCenterX and touch_y <= display.contentCenterY ) then
        	chaser.y=chaser.y-n*dist_y
        	chaser.x=chaser.x-n*dist_x


        end
	end

	return chaser
end


return chaser
