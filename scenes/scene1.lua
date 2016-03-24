-----------------------------------------------------------------------------------------
--
-- scene1.lua
--
-----------------------------------------------------------------------------------------
display.setStatusBar(display.HiddenStatusBar)
local composer = require( "composer" )
--local perspective = require("perspective")
local physics = require("physics")
local rect = require('classes.rect')
local tri = require('classes.tri')
local wall = require('classes.wall')
local wormHole = require('classes.wormHole')
local player = require('classes.player')
local chaser = require('classes.chaser')
local saw = require('classes.saw')
local scene = composer.newScene()
local physics = require("physics")
local perspective = require("perspective")

--local particleDesigner = require( "particleDesigner" )


camera = perspective.createView()
camera:setBounds(170, 205, 0, 2200)
physics.start()
physics.setGravity( 0, 0 )

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------

local function showMenu()
	--local options = {
--		effect = 'crossFade',
--		time= 200
--	}
	--scene:hide
	composer.gotoScene("scenes.menu")

end

-- "scene:create()"
function scene:create( event )
	
    local sceneGroup = self.view
    
    composer.removeScene('scenes.menu')
    
	local bg = display.newRect(display.contentCenterX,display.contentCenterY,450,8000)
	bg: setFillColor(0.93,0.93,0.93)	
    
    local wallLeft = wall_new(5,885)
    local wallRight = wall_new(373, 885)

	camera:add(wallLeft,1)
	camera:add(wallRight,1)
	
	sceneGroup:insert(bg)
	sceneGroup:insert(wallLeft)
	sceneGroup:insert(wallRight)

    -- Initialise the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )
	
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        
    -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
    	
    	local player1 = player_new(display.contentCenterX,display.contentCenterY,2,0.38,0.38,0.38)
		
		camera:add(player1, 1) -- Add player to layer 1 of the camera
		camera:setFocus(player1)
		camera:prependLayer()
    	
    	camera.damping = 10 -- A bit more fluid tracking
		camera:setFocus(player1) -- Set the focus to the player
		camera:track() -- Begin auto-tracking
    	
    	local tri = {}    	
		for i=1,8 do
			tri[i] = tri_new(math.random(1,10)*35,200*i,math.random(2,5))
			camera:add(tri[i],1)
			sceneGroup:insert(tri[i])
		end

		

		

		sceneGroup:insert(player1)	
		camera:add(sceneGroup)						
       
        function myTouchListener( event )
        	
   	 		if event.phase == "began" then 
   	 		touch_x = event.x
   	 		touch_y = event.y      
        	--eliminate the camera damping for getting an excatly touch coordination
        	if(event.x - display.contentCenterY <= 0) then
            	xSide = event.x - player1.x
            	ySide = event.y - display.contentCenterY
        	else
            	xSide = event.x - player1.x
            	ySide = event.y - display.contentCenterY
        	end
        	
        	local k = xSide/ySide
        	dist_x= player1.speed*k/(math.sqrt(k*k+1))
        	dist_y= player1.speed/(math.sqrt(k*k+1))

    		end
		end
    		
    	function myListener( event )
    	
   			for i=1,8 do
				tri[i].rotate1()
			end 		    
    		
    		player1.move1()
    		
    		player_x = player1.x
        	player_y = player1.y
    		
   			if( player1.isSpeedUp == 1 and player1.isStop == 0 ) then   				
   				  timer.performWithDelay ( 2000, player1.speedDown )
   			end
			
		end
		
		function onLocalPostCollision( self, event )
			
			if (self.myName == "tri") then					
				self:removeSelf()
				self.myName = nil
				if(player1.isSpeedUp == 0) then
					player1.speedUp()
				else timer.performWithDelay ( 2000, player1.speedDown )
				end
			end
			
			return true
		end
		
		
		for i=1,8 do
			tri[i].postCollision = onLocalPostCollision
			tri[i]:addEventListener( "postCollision", tri[i] )
		end
		
		
		Runtime:addEventListener( "touch", myTouchListener )
		
		Runtime:addEventListener( "enterFrame", myListener )
		
-- Example: start timers, begin animation, play audio, etc.
    end
end



-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    --local phase = event.phase
	
	
    --if ( phase == "will" ) then
        --camera:remove()
        --camera:destroy()
       
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    --elseif ( phase == "did" ) then
    	
		
    	
        -- Called immediately after scene goes off screen
    --end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view
    
    
    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene


