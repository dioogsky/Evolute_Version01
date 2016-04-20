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
	player.name = "player"
	player.orignspeed = speed
	player.isSpeedUp = 0
	player.isStop = 0
  player.hasKey = 0
  player.isMovingUp = 0
	physics.addBody( player, { density=2, friction=0.5, bounce=0.3 } )

--  local trackPoint = {}

    function player:move1()

    if(dist_y == nil and dist_x == nil) then
        player.y=player.y
    elseif(touch_x >= display.contentCenterX and touch_y >= display.contentCenterY) then
         trackPoint()
         timer.performWithDelay( 500, function() player.isMovingUp = 0 end)
         player.y=player.y+dist_y
         player.x=player.x+dist_x
    elseif(touch_x <= display.contentCenterX and touch_y >= display.contentCenterY) then
        trackPoint()
        timer.performWithDelay( 500, function() player.isMovingUp = 0 end)
        player.y=player.y+dist_y
        player.x=player.x+dist_x
    elseif(touch_x <= display.contentCenterX and touch_y <= display.contentCenterY ) then
        trackPoint()
        timer.performWithDelay( 500, function() player.isMovingUp = 1 end)
        player.y=player.y-dist_y
        player.x=player.x-dist_x
    elseif(touch_x >= display.contentCenterX and touch_y <= display.contentCenterY ) then
        trackPoint()
        timer.performWithDelay( 500, function() player.isMovingUp = 1 end)
        player.y=player.y-dist_y
        player.x=player.x-dist_x
    end

	end

  function trackPoint()
    if(player.x%5 <= 0.5 or player.y%5 <= 0.5)then
      local trackPoint = display.newCircle(player.x,player.y,2)
      trackPoint:setFillColor(0.5,0.5,0.5,0.3)
      trackPoint:toBack()
      camera:add(trackPoint,1)
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
		player.speed = 1.5 * player.speed
		player:setFillColor(math.random(1),0.5,0)
		player.isSpeedUp = 1
		-- print("speed up!!!")
		-- print(player.speed)
		return true
	end

	function player:stop()
		player.isStop = 1
		Runtime:removeEventListener( "enterFrame", myListener )

		Runtime:removeEventListener( "touch", myTouchListener  )
	end

	function player:speedDown()
		-- print("speed down!")
		player.speed = player.orignspeed
		-- print(player.speed)
		-- print(player)
		if (player.isStop == 0 ) then
			player:setFillColor(0.38,0.38,0.38)
		end
		player.isSpeedUp = 0
		return true
	end

	return player
end


return player
