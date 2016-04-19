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
local turret = require('classes.turret')
local bullet = require('classes.bullet')
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
          openDoor = audio.loadSound('sounds/openDoor.mp3'),
					key = audio.loadSound('sounds/key.wav'),
					voiceover = audio.loadSound('sounds/Scene03.mp3')
				}

				audio.play(soundTable["bgm"],{
			    channel = 1,
			    loops = -1,
			    fadein = 5000
				})

				audio.play(soundTable["voiceover"],{
					channel = 2,
					fadein = 1000
				})


				local wallUp = display.newRect(display.contentCenterX,0,346,20)
	    	physics.addBody( wallUp,'static', { density=20, friction=0.5, bounce=0.3 } )
				wallUp: setFillColor(0,0,0,0)
				wallUp.myName = "wallUp"

				local wallUp2 = display.newRect(display.contentCenterX,1400,346,20)
	    	physics.addBody( wallUp2,'static', { density=20, friction=0.5, bounce=0.3 } )
				wallUp2: setFillColor(0,0,0,0)
				wallUp2.myName = "wallUp"

				local wall_h = display.newImage('img/wall_h.png',display.contentCenterX,1634)
				wall_h:scale(1.02,1.02)
				physics.addBody( wall_h,'static', { density=20, friction=0.5, bounce=0.3 } )

				sceneGroup:insert(wall_h)


        local lockTriggerOn = display.newImage('img/lockTrigger.png',display.contentCenterX,300)
        lockTriggerOn.alpha = 0
        local lockTriggerOff = display.newImage('img/lockTrigger_unactivated.png',display.contentCenterX,300)

        sceneGroup:insert(lockTriggerOn)
        sceneGroup:insert(lockTriggerOff)

				local key = display.newImage('img/key.png',40,1420)
				key.myName = 'key'
				physics.addBody( key,'static' ,{ density=2, friction=0.5, bounce=0.3 } )
        sceneGroup:insert(key)

        local gate1 = gateL_new(450,1)
        sceneGroup:insert(gate1)

        local gate2 = gateR_new(450,1)
        sceneGroup:insert(gate2)

        local gateRollerLeft = display.newImage('img/gateRollerLeft.png',20,450)
        sceneGroup:insert(gateRollerLeft)

        local gateRollerRight = display.newImage('img/gateRollerRight.png',359,450)
        sceneGroup:insert(gateRollerRight)

				local base = display.newImage('img/base.png',30,800)
        sceneGroup:insert(base)
				local turret1 = turret_new(40,800)
        sceneGroup:insert(turret1)
				local bullet1 = bullet_new()
        sceneGroup:insert(bullet1)

				local rect = {}
				for i=1,4 do
						rect[i] = rect_new(display.contentCenterX,i*130+750,1)
						transition.to( rect[i], { alpha = 1,time = 250,delay = 100*i })
						sceneGroup:insert(rect[i])
				end

				local wormHole1 = wormHole_new(10,300)
				wormHole1.myName = "wormHole1"
				local wormHole2 = wormHole_new(365,1550)
				wormHole2.myName = "wormHole2"

				sceneGroup:insert(wormHole1)
				sceneGroup:insert(wormHole2)

				local missionPoint = display.newImage('img/missionPoint.png',display.contentCenterX,1360)
				missionPoint:scale(0.9,0.9)
				local missionPointTrigger = display.newRect(display.contentCenterX,1360,400,10)
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
				sceneGroup:insert(player1)
				camera:add(sceneGroup)

				local pauseButton = display.newImage("img/pause.png",354,21)

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

          if(math.sqrt((player1.x-display.contentCenterX)*(player1.x-display.contentCenterX)+(player1.y-300)*(player1.y-300)) <= 20 and player1.hasKey == 1)then
              transition.to(lockTriggerOff,{alpha = 0})
              transition.to(lockTriggerOn,{alpha = 1})
              gate1.IsOpen = 1
          end

					if(math.sqrt((player1.x-bullet1.x)*(player1.x-bullet1.x)+(player1.y-bullet1.y)*(player1.y-bullet1.y)) <= 20 )then
						gate1.IsOpen = 0
						audio.stop(1)
						audio.dispose( bgm )
						audio.stop(5)
						audio.dispose( openDoor )
						player1.stop()
						player1.isStop = 1
						pauseButton:removeSelf()
						local failbg = display.newRect(display.contentCenterX,display.contentCenterY,375,667)
						failbg:setFillColor(0.8,0,0,0.7)
						local failtext = display.newImage("img/fail.png",display.contentCenterX,display.contentCenterY-100)
						failtext.alpha = 0
						transition.to( failtext, { alpha = 1,time = 800,delay = 200 })

						local buttonBack = display.newImage("img/backButton.png",80,500)
						buttonBack.alpha = 0
						transition.to( buttonBack, { alpha = 1,time = 800,delay = 300 })

						local function myBackListener()
								failbg:removeSelf()
								failbg = nil
								failtext:removeSelf()
								failtext = nil
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

					for i=1,4  do
							if (i%2 == 0)then
									rect[i].move1()
							else
									rect[i].move2()
							end
					end

          if (gate1.IsOpen == 1)then
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

            end
          end

					player1.move1()
					turret1.move1()
					bullet1.fire()
					--turret1.bulletMove()
		    	player_x = player1.x
		      player_y = player1.y

		   		if( player1.isSpeedUp == 1 and player1.isStop == 0 ) then
		   				timer.performWithDelay ( 1500, player1.speedDown,1 )
		   		end
			end


			local function myPauseListener()
					dist_x = nil
					dist_y = nil
					audio.stop(1)
					audio.dispose( bgm )
					audio.stop(2)
          audio.dispose( voiceover )
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

					if (self.myName == "wormHole1") then
						local translateObject = function()  event.other.x = 340 event.other.y = 1550 end
						timer.performWithDelay(1,translateObject,1)
					end

					if (self.myName == "wormHole2") then
						local translateObject = function()  event.other.x = 30 event.other.y = 300 end
						timer.performWithDelay(1,translateObject,1)
					end

					if (self.myName == "missionPointTrigger") then
							self.myName = nil

              audio.stop(1)
              audio.dispose( bgm )
							audio.stop(2)
		          audio.dispose( voiceover )
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

				if (self.myName == "key") then
					self:removeSelf()
					self.myName = nil
					player1.hasKey = 1
					audio.play(soundTable["key"],{
				    channel = 7,
					})
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

			key.postCollision = onLocalPostCollision
			key:addEventListener( "postCollision", key )

			wallUp.postCollision = onLocalPostCollision
			wallUp:addEventListener( "postCollision", wallUp )

			wallUp2.postCollision = onLocalPostCollision
			wallUp2:addEventListener( "postCollision", wallUp2 )

			wormHole1.postCollision = onLocalPostCollision
			wormHole1:addEventListener( "postCollision", wormHole1 )

			wormHole2.postCollision = onLocalPostCollision
			wormHole2:addEventListener( "postCollision", wormHole2 )

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
