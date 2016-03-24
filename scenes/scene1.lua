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
    	    	
    	
    	
    	local rect1 = rect_new(display.contentCenterX,500,1)
    	transition.to( rect1, { alpha = 1,time = 250,delay = 50 })

		local rect2 = rect_new(display.contentCenterX,600,1)
		transition.to( rect2, { alpha = 1,time = 250,delay = 150 })
		
		local rect3 = rect_new(display.contentCenterX,700,1)
		transition.to( rect3, { alpha = 1,time = 250,delay = 250 })
		
		local saw1 = saw_new(display.contentCenterX,800,20)
		transition.to( saw1, { alpha = 1,time = 250,delay = 350 })
		
		local rect4 = rect_new(display.contentCenterX,900,1)
    	transition.to( rect4, { alpha = 1,time = 250,delay = 450 })

		local rect5 = rect_new(display.contentCenterX,1000,1)
		transition.to( rect5, { alpha = 1,time = 250,delay = 550 })
		
		local rect6 = rect_new(display.contentCenterX,1100,1)
		transition.to( rect6, { alpha = 1,time = 250,delay = 650 })
		
		local tri1 = tri_new(100,200,3)
		
		local tri2 = tri_new(200,750,5)
		
		local wormHole1 = wormHole_new(365,500)
		local wormHole2 = wormHole_new(365,1200)
			
		local chaser1 = chaser_new(display.contentCenterX,display.contentCenterY-100,2.4)
		
		camera:add(chaser1,1)	
		camera:add(rect1,1)
		camera:add(rect2,1)
		camera:add(rect3,1)
		camera:add(saw1,1)
		camera:add(rect4,1)
		camera:add(rect5,1)
		camera:add(rect6,1)
		camera:add(tri1,1)
		camera:add(tri2,1)
		camera:add(wormHole1,1)
		camera:add(wormHole2,1)
		
		sceneGroup:insert(rect1)
		sceneGroup:insert(rect2)
		sceneGroup:insert(rect3)
		sceneGroup:insert(saw1)
		sceneGroup:insert(rect4)
		sceneGroup:insert(rect5)
		sceneGroup:insert(rect6)
		sceneGroup:insert(tri1)
		sceneGroup:insert(tri2)
		sceneGroup:insert(wormHole1)
		sceneGroup:insert(wormHole2)
		sceneGroup:insert(player1)
		sceneGroup:insert(chaser1)		
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
    		
    		rect1.move2()
    		rect2.move1()
    		rect3.move2()
    		--timer.performWithDelay ( 1000, rect2.move1 )
   		    --timer.performWithDelay ( 2100, rect3.move2 )
   		    saw1.move2()
   		    saw1.rotate1()
   		    rect4.move1()
    		rect5.move2()
   		    rect6.move1()  		      		   
   		    tri1.rotate1()
   		    tri2.rotate1()  		    
    		player1.move1()
    		chaser1.move1()

    		player_x = player1.x
        	player_y = player1.y
    		
   			if( player1.isSpeedUp == true and player1.isStop == 0 ) then
   				timer.performWithDelay ( 3000, player1.speedDown )
   			end
			
		end
		
		function onLocalPostCollision( self, event )
			
			if (self.myName == "tri") then					
				self:removeSelf()
				self.myName = nil
				player1.speedUp()
			end
			
			if (self.myName == "wormHole") then	
				print("wormHole!!")
			end
			
			if (self.myName == "saw") then	
				self.myName = nil
				player1.stop()
				
				local failbg = display.newRect(display.contentCenterX,display.contentCenterY,375,667)
				failbg:setFillColor(0.8,0,0,0.7)
				local failtext = display.newImage("img/fail.png",display.contentCenterX,display.contentCenterY-100)
				failtext.alpha = 0
				transition.to( failtext, { alpha = 1,time = 800,delay = 200 })
				local buttonBack = display.newCircle(100,500,20,20)
				
				camera:add(failbg)
				camera:add(failtext)
				camera:add(buttonBack)
				
				sceneGroup:insert(failbg)
				sceneGroup:insert(failtext)	
				sceneGroup:insert(buttonBack)
				
    			local function myBackListener()
    				showMenu()
					Runtime:removeEventListener( "touch", myTouchListener )
					Runtime:removeEventListener( "enterFrame", myListener )
					physics.stop()
					camera:destroy()
    			end
    			buttonBack:addEventListener("tap",myBackListener)								
				
			end
			return true
		end
		
		
		--player1.postCollision = onLocalPostCollision
		--player1:addEventListener( "postCollision", player1 )
		
		tri1.postCollision = onLocalPostCollision
		tri1:addEventListener( "postCollision", tri1 )
		tri2.postCollision = onLocalPostCollision
		tri2:addEventListener( "postCollision", tri2 )
		
		wormHole1.postCollision = onLocalPostCollision
		wormHole1:addEventListener( "postCollision", wormHole1 )
		
		saw1.postCollision = onLocalPostCollision
		saw1:addEventListener( "postCollision", saw1 )
		
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


