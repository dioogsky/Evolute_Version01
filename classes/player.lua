-----------------------------------------------------------------------------------------
--
-- player.lua
--
-----------------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Build Player
--------------------------------------------------------------------------------

function player_new (positon_x,position_y,speed,r,g,b)
    local player = display.newCircle(positon_x, position_y,10)
    player: setFillColor(r,g,b)
	player.anchorX = 0.5 -- Slightly more "realistic" than center-point rotating
	player.speed = speed
	player.orignspeed = speed
	player.isSpeedUp = false
	physics.addBody( player, { density=2, friction=0.5, bounce=0.3 } )

	

	
  
    function player:move1()

    if(dist_y == nil and dist_x == nil) then
        player.y=player.y
    elseif(touch_x >= display.contentCenterX and touch_y >= display.contentCenterY) then
         player.y=player.y+dist_y
         player.x=player.x+dist_x
    elseif(touch_x <= display.contentCenterX and touch_y >= display.contentCenterY) then
        player.y=player.y+dist_y
        player.x=player.x+dist_x
    elseif(touch_x <= display.contentCenterX and touch_y <= display.contentCenterY ) then
        player.y=player.y-dist_y
        player.x=player.x-dist_x
    elseif(touch_x >= display.contentCenterX and touch_y <= display.contentCenterY ) then
        player.y=player.y-dist_y
        player.x=player.x-dist_x
    end

	end
	
	function player:move2()
	
	local n = 0.8
    if(dist_y == nil and dist_x == nil) then
        player.y=player.y
    elseif(touch_x >= display.contentCenterX and touch_y >= display.contentCenterY) then
         player.y=player.y+n*dist_y
         player.x=player.x+n*dist_x
    elseif(touch_x <= display.contentCenterX and touch_y >= display.contentCenterY) then
        player.y=player.y+n*dist_y
        player.x=player.x+n*dist_x
    elseif(touch_x <= display.contentCenterX and touch_y <= display.contentCenterY ) then
        player.y=player.y-n*dist_y
        player.x=player.x-n*dist_x
    elseif(touch_x >= display.contentCenterX and touch_y <= display.contentCenterY ) then
        player.y=player.y-n*dist_y
        player.x=player.x-n*dist_x
    end

	end
		
	function player:speedUp()
		--print("up")
		player.orignspeed = player.speed
		player.speed = 1.4 * player.speed
		player:setFillColor(math.random(1),0.5,0)
		player.isSpeedUp = true
		print("speed up!!!")
		print(player.speed)
		return true
	end
	
	function player:stop()		
		player.isStop = 1
		Runtime:removeEventListener( "enterFrame", myListener )
		
		Runtime:removeEventListener( "touch", myTouchListener  )		
	end
	
	function player:speedDown()
		--print("down")
		player.speed = player.orignspeed
		print(player.speed)
		print(player)
		if (player ~= nil) then
			player:setFillColor(0.38,0.38,0.38)
		end
		player.isSpeedUp = false
		return true
	end
	
	return player 
end


return player



