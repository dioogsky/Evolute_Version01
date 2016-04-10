-----------------------------------------------------------------------------------------
--
-- scene3.lua
--
-----------------------------------------------------------------------------------------
display.setStatusBar(display.HiddenStatusBar)
local composer = require( "composer" )
local physics = require("physics")
local rect = require('classes.rect')
local tri = require('classes.tri')
local wall = require('classes.wall')
local wormHole = require('classes.wormHole')
local player = require('classes.player')
local chaser = require('classes.chaser')
local saw = require('classes.saw')
local gateL = require('classes.gateL')
local gateR = require('classes.gateR')
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
	  local wallLeft = wall_new(5,600)
	  local wallRight = wall_new(373, 600)

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

				local soundTable={
					bgm = audio.loadSound('sounds/deep_space.mp3'),
					saw = audio.loadSound('sounds/saw.wav'),
					warning = audio.loadSound('sounds/warning.mp3'),
          openDoor = audio.loadSound('sounds/openDoor.mp3')
				}

				audio.play(soundTable["bgm"],{
			    channel = 1,
			    loops = -1,
			    fadein = 5000
				})

				local wallUp = display.newRect(display.contentCenterX,0,346,20)
	    	physics.addBody( wallUp,'static', { density=20, friction=0.5, bounce=0.3 } )
				wallUp: setFillColor(0,0,0,0)
				wallUp.myName = "wallUp"


        local lockTriggerOn = display.newImage('img/lockTrigger.png',display.contentCenterX,300)
        lockTriggerOn.alpha = 0
        local lockTriggerOff = display.newImage('img/lockTrigger_unactivated.png',display.contentCenterX,300)

        camera:add(lockTriggerOn,1)
        sceneGroup:insert(lockTriggerOn)

        camera:add(lockTriggerOff,1)
        sceneGroup:insert(lockTriggerOff)


        local gate1 = gateL_new(450,1)
        camera:add(gate1,1)
        sceneGroup:insert(gate1)

        local gate2 = gateR_new(450,1)
        camera:add(gate2,1)
        sceneGroup:insert(gate2)

        local gateRollerLeft = display.newImage('img/gateRollerLeft.png',20,450)
        camera:add(gateRollerLeft,1)
        sceneGroup:insert(gateRollerLeft)

        local gateRollerRight = display.newImage('img/gateRollerRight.png',359,450)
        camera:add(gateRollerRight,1)
        sceneGroup:insert(gateRollerRight)

				local missionPoint = display.newImage('img/missionPoint.png',display.contentCenterX,1660)
				local missionPointTrigger = display.newRect(display.contentCenterX,1660,400,10)
				missionPointTrigger:setFillColor(0,0,0,0)
	    	physics.addBody( missionPointTrigger,'static', { density=20, friction=0.5, bounce=0.3 } )
				missionPointTrigger.myName = "missionPointTrigger"
				sceneGroup:insert(missionPoint)
				sceneGroup:insert(missionPointTrigger)

	    	local player1 = player_new(display.contentCenterX,display.contentCenterY,2,0.38,0.38,0.38)
				camera:add(player1, 1) -- Add player to layer 1 of the camera
				camera:setFocus(player1)
				camera:prependLayer()
	    	camera.damping = 10 -- A bit more fluid tracking
				camera:setFocus(player1) -- Set the focus to the player
				camera:track() -- Begin auto-tracking

				local tri = {}
				for i=1,8 do
						tri[i] = tri_new(math.random(2,9)*35,200*i,math.random(2,5))
						camera:add(tri[i],1)
						sceneGroup:insert(tri[i])
				end


			sceneGroup:insert(player1)
			camera:add(sceneGroup)

	    function myTouchListener( event )

	   	    if event.phase == "began" then
			   			touch_x = event.x
			   	 		touch_y = event.y
			        	--eliminate the camera damping via getting an excatly touch coordination
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
          if(math.sqrt((player1.x-display.contentCenterX)*(player1.x-display.contentCenterX)+(player1.y-300)*(player1.y-300)) <= 20 )then
              transition.to(lockTriggerOff,{alpha = 0})
              transition.to(lockTriggerOn,{alpha = 1})
              gate1.IsOpen = 1
          end
          if (gate1.IsOpen == 1)then

            print(gate1.x)
            gate1:rotate(0.1)
            gate2:rotate(-0.1)
            gate1.angular,gate2.angular = gate1.angular + 0.1,gate2.angular - 0.1
            audio.play(soundTable["openDoor"],{
    			    channel = 5,
    			    loops = 0,
    			    fadein = 1000
    				})

            if(gate1.angular > 35 or gate2.angular > 35)then
              gate1.IsOpen = 0
              gate2.IsOpen = 0
              audio.fadeOut({channel=5, time= 3000})

            end
          end

					player1.move1()

		    	player_x = player1.x
		      player_y = player1.y

		   		if( player1.isSpeedUp == 1 and player1.isStop == 0 ) then
		   				timer.performWithDelay ( 1500, player1.speedDown,1 )
		   		end
			end

			local pauseButton = display.newImage("img/pause.png",354,21)
			local function myPauseListener()
					dist_x = nil
					dist_y = nil

					audio.stop(1)
					audio.dispose( bgm )
          audio.stop(5)
          audio.dispose( openDoor )

					pauseButton:removeSelf()
					showMenu()
					Runtime:removeEventListener( "touch", myTouchListener )
					Runtime:removeEventListener( "enterFrame", myListener )
					physics.stop()
					camera:destroy()
			end
			pauseButton:addEventListener("tap",myPauseListener)

			function onLocalPostCollision( self, event )

					if (self.myName == "missionPointTrigger") then
							self.myName = nil
              audio.stop(1)
              audio.dispose( bgm )
              audio.stop(5)
              audio.dispose( openDoor )
							player1.stop()
							pauseButton:removeSelf()

							local successbg = display.newRect(display.contentCenterX,display.contentCenterY,375,667)
							successbg:setFillColor(0.53,0.85,0.16,0.7)
							local successText = display.newImage("img/success.png",display.contentCenterX,display.contentCenterY-100)
							successText.alpha = 0
							transition.to( successText, { alpha = 1,time = 800,delay = 200 })

							local buttonBack = display.newImage("img/backButton.png",80,500)
							buttonBack.alpha = 0
							transition.to( buttonBack, { alpha = 1,time = 800,delay = 300 })

		    			local function myBackListener()
		    					successbg:removeSelf()
		    					successbg = nil
		    					successText:removeSelf()
		    					successText = nil

			    				buttonBack:removeSelf()
			    				buttonBack = nil
			    				dist_x = nil
			   	 				dist_y = nil
			    				showMenu()
									Runtime:removeEventListener( "touch", myTouchListener )
									Runtime:removeEventListener( "enterFrame", myListener )
									physics.stop()
									camera:destroy()
		    		end
		    		buttonBack:addEventListener("tap",myBackListener)
					end




				if (self.myName == "tri") then
					self:removeSelf()
					self.myName = nil
					timer.performWithDelay ( 1, player1.speedUp )
				end

				if (self.myName == "wallUp") then
					local warning = display.newText("You can't go back, Captain.",display.contentCenterX, 250 )
					warning:setFillColor(0.7,0.7,0.7,1)
					timer.performWithDelay ( 1000, transition.to( warning, { time=1000, alpha=0 } ) )
					audio.play(soundTable["warning"],{
						channel = 3,
						loops = 0
					})
				end

				return true
			end


			for i=1,8 do
				tri[i].postCollision = onLocalPostCollision
				tri[i]:addEventListener( "postCollision", tri[i] )
			end

			wallUp.postCollision = onLocalPostCollision
			wallUp:addEventListener( "postCollision", wallUp )

			missionPointTrigger.postCollision = onLocalPostCollision
			missionPointTrigger:addEventListener( "postCollision", missionPointTrigger )

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
