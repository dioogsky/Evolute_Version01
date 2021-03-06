-----------------------------------------------------------------------------------------
--
-- scene1.lua
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
local map = require('classes.mapfor02')
local saw = require('classes.saw')
local scene = composer.newScene()
local physics = require("physics")
local perspective = require("perspective")

--local particleDesigner = require( "particleDesigner" )

-- Value for walkable tiles
local walkable = 0

local Grid = require ("jumper.grid")
-- Calls the pathfinder class
local Pathfinder = require ("jumper.pathfinder")

local map = map.new()


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

		    local wallUp = display.newRect(display.contentCenterX,0,346,20)
		    physics.addBody( wallUp,'static', { density=20, friction=0.5, bounce=0.3 } )
				wallUp: setFillColor(0,0,0,0)
				wallUp.myName = "wallUp"

				local missionPoint = display.newImage('img/missionPoint.png',display.contentCenterX,1660)
				local missionPointTrigger = display.newRect(display.contentCenterX,1660,400,10)
				missionPointTrigger:setFillColor(0,0,0,0)
		    physics.addBody( missionPointTrigger,'static', { density=20, friction=0.5, bounce=0.3 } )
				missionPointTrigger.myName = "missionPointTrigger"
				sceneGroup:insert(missionPoint)
				sceneGroup:insert(missionPointTrigger)

		    local player1 = player_new(display.contentCenterX,display.contentCenterY,2,0.38,0.38,0.38)

				camera:prependLayer()
		    camera.damping = 10 -- A bit more fluid tracking
				camera:setFocus(player1) -- Set the focus to the player
				camera:track() -- Begin auto-tracking

				local rect = {}
				local saw = {}
				local tri = {}


				for i=1,2 do
						rect[i] = rect_new(display.contentCenterX,i*100+390,1)
						transition.to( rect[i], { alpha = 1,time = 250,delay = 100*i })
						sceneGroup:insert(rect[i])
				end


				saw[1] = saw_new(display.contentCenterX,700,20)
				transition.to( saw[1], { alpha = 1,time = 250,delay = 250 })

				saw[2] = saw_new(display.contentCenterX,800,20)
				transition.to( saw[2], { alpha = 1,time = 250,delay = 350 })

				for i=3,10 do
						rect[i] = rect_new(display.contentCenterX,i*100+590,1)
						transition.to( rect[i], { alpha = 1,time = 250,delay = 100*i })
						sceneGroup:insert(rect[i])
				end


				saw[3] = saw_new(display.contentCenterX,1250,20)
				transition.to( saw[3], { alpha = 1,time = 250,delay = 700 })

				saw[4] = saw_new(display.contentCenterX,1350,20)
				transition.to( saw[4], { alpha = 1,time = 250,delay = 800 })

				tri[1] = tri_new(100,200,3)
				tri[2] = tri_new(200,750,10)
				tri[3] = tri_new(300,380,5)

				local chaser1 = chaser_new(display.contentCenterX,display.contentCenterY-200,2.4)

				for i = 1,#rect do
					camera:add(rect[i],1)
					sceneGroup:insert(rect[i])
				end

				for i = 1,#saw do
					camera:add(saw[i],1)
					sceneGroup:insert(saw[i])
				end

				for i = 1,#tri do
					camera:add(tri[i],1)
					sceneGroup:insert(tri[i])
				end

				sceneGroup:insert(player1)
				sceneGroup:insert(chaser1)
				camera:add(sceneGroup)

		-- Core control function
		    function myTouchListener( event )

		   	 		if event.phase == "began" then
		   	 		touch_x = event.x
		   	 		touch_y = event.y

          	xSide = event.x - player1.x-10
          	ySide = event.y - display.contentCenterY

	        	local k = xSide/ySide
	        	dist_x= player1.speed*k/(math.sqrt(k*k+1))
	        	dist_y= player1.speed/(math.sqrt(k*k+1))

		    		end
				end

		-- Sound control
				local soundTable={
					bgm = audio.loadSound('sounds/deep_space.mp3'),
					saw = audio.loadSound('sounds/saw.wav'),
					warning = audio.loadSound('sounds/warning.mp3'),
					voiceover = audio.loadSound('sounds/Scene02.mp3')
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

				local pauseButton = display.newImage("img/pause.png",354,21)

		-- Frame event
		    function myListener( event )

						for i = 1,#rect,2 do
							rect[i].move1()
							rect[i+1].move2()
						end


						for i = 1,#saw,2 do
							saw[i].move1()
							saw[i].rotate1()
							saw[i+1].move2()
							saw[i+1].rotate1()
						end

						for i = 1,#tri do
							tri[i].rotate1()
						end

		    		player1.move1()


						if( math.abs(saw[1].y-player1.y) <= 300 )then
							audio.play(soundTable["saw"],{
						    channel = 3,
						    loops = -1 ,
						    fadein = 10000
							})

						end

						if( math.abs(saw[3].y-player1.y) <= 300 )then
							audio.play(soundTable["saw"],{
								channel = 3,
								loops = -1 ,
								fadein = 10000
							})

						end

		    		player_x = player1.x
		        player_y = player1.y

		   			if( player1.isSpeedUp == 1 and player1.isStop == 0 ) then
		   				timer.performWithDelay ( 3000, player1.speedDown )
		   			end

						_x = 375/20
						_y = 667/26

						for i = 1,180 do
							for j = 1,20 do
								map[i][j]=0
							end
						end
						-- update the map
						for i = 1,#rect do
							for j = -3,3,1 do
								--map[math.ceil(rect[i].y/_y)][math.ceil((rect[i].x/_x)+j)] = 1 --1 means unwalkable
								map[math.round(rect[i].y/_y)][math.round((rect[i].x/_x)+j)] = 1
								-- local rect = display.newRect(math.round((rect[i].x/_x)+j)*_x,math.round(rect[i].y/_y)*_y,_x,_y)
								-- sceneGroup:insert(rect)
								--map[math.ceil(rect[i].y/_y)-1][math.ceil((rect[i].x/_x)+j)] = 1
							end
						end

						for i = 1,#saw do
							for j = -2,2,1 do
								map[math.round(saw[i].y/_y)][math.round((saw[i].x/_x)+j)] = 1
								--map[math.round(saw[i].y/_y+1)][math.round((saw[i].x/_x)+j)] = 1
								--map[math.round(saw[i].y/_y)-1][math.round((saw[i].x/_x)+j)] = 1
							end
						end

						-- Creates a grid object
						local grid = Grid(map)
						local movePath = {}
						-- Creates a pathfinder object using Jump Point Search algorithm
						local myFinder = Pathfinder(grid, 'ASTAR', walkable)
						myFinder:clearAnnotations()
						--print(chaser1.x)
						local startx, starty = math.round(chaser1.x/_x),math.round(chaser1.y/_y)
						--local endx, endy = 14,25
						if(player1.isMovingUp == 0) then
							if(math.floor(player1.x/_x) >=1 ) then
								endx, endy = math.floor(player1.x/_x),math.floor(player1.y/_y)
							elseif(math.floor(player1.x/_x) == 0) then
								endx, endy = 1,math.floor(player1.y/_y)
							end
						elseif(player1.isMovingUp == 1)then
							if(math.floor(player1.x/_x) >=1 ) then
							endx, endy = math.ceil(player1.x/_x),math.ceil(player1.y/_y)
							elseif(math.floor(player1.x/_x) == 0) then
							endx, endy = 1,math.ceil(player1.y/_y)
							end
						end

						local rect = display.newRect(endx*_x,endy*_y,10,10)
						sceneGroup:insert(rect)
						local path = myFinder:getPath(startx, starty, endx, endy)

						if path then
							print(('Path found! Length: %.2f'):format(path:getLength()))
							timer.performWithDelay ( 1,function ()
									for node, count in path:nodes() do
										movePath[count] = { x=node:getX(), y=node:getY() }
									end
									--print(movePath[2].x,movePath[2].y )
									if(movePath[3])then
										local a = math.sqrt((movePath[3].x*_x - chaser1.x)^2+(movePath[3].y*_y - chaser1.y)^2)
										chaser1.x = chaser1.x + 1.6*(movePath[3].x*_x - chaser1.x)/a
										chaser1.y = chaser1.y + 1.6*(movePath[3].y*_y - chaser1.y)/a
										--transition.to(chaser1,{x=movePath[3].x*_x, y=movePath[3].y*_y,time =115})
									elseif(movePath[2])then
										local a = math.sqrt((movePath[2].x*_x - chaser1.x)^2+(movePath[2].y*_y - chaser1.y)^2)
										chaser1.x = chaser1.x + 2.0*(movePath[2].x*_x - chaser1.x)/a
										chaser1.y = chaser1.y + 2.0*(movePath[2].y*_y - chaser1.y)/a
									end
								end )
						end

						if ((math.sqrt((player1.x-chaser1.x)^2 +(player1.y-chaser1.y)^2)) <= _y+1) then
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

							audio.stop(1)
							audio.dispose( bgm )
							audio.stop(2)
							audio.dispose( voiceover )
							audio.stop(3)
							audio.dispose( saw )

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



				end


				local function myPauseListener()
						dist_x = nil
						dist_y = nil

						audio.stop(1)
						audio.dispose( bgm )
						audio.stop(2)
						audio.dispose( voiceover )
						audio.stop(3)
						audio.dispose( saw )

						pauseButton:removeSelf()
						showMenu()
						Runtime:removeEventListener( "touch", myTouchListener )
						Runtime:removeEventListener( "enterFrame", myListener )
						physics.stop()
						camera:destroy()
				end
				pauseButton:addEventListener("tap",myPauseListener)

		-- Collison event
				function onLocalPostCollision( self, event )

					if (self.myName == "wallUp" and event.other.name == "player") then
						local warning = display.newText("You can't go back, Captain.",display.contentCenterX, 250 )
						warning:setFillColor(0.7,0.7,0.7,1)
						timer.performWithDelay ( 1000, transition.to( warning, { time=1000, alpha=0 } ) )
						audio.play(soundTable["warning"],{
					    channel = 3,
					    loops = 0
						})

					end

					if (self.myName == "tri" and event.other.name == "player") then
						--print(event.target.name)
						self:removeSelf()
						self.myName = nil
						player1.speedUp()
					end

					if (self.myName == "saw" and event.other.name == "player") then
						self.myName = nil
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

						audio.stop(1)
						audio.dispose( bgm )
						audio.stop(2)
						audio.dispose( voiceover )
						audio.stop(3)
						audio.dispose( saw )

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

					if (self.myName == "missionPointTrigger" and event.other.name == "player" ) then
						self.myName = nil
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

						audio.stop(1)
						audio.dispose( bgm )
						audio.stop(2)
						audio.dispose( voiceover )
						audio.stop(3)
						audio.dispose( saw )

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

					return true
				end

				for i = 1,#tri do
				tri[i].postCollision = onLocalPostCollision
				tri[i]:addEventListener( "postCollision", tri[i] )
				end

				wallUp.postCollision = onLocalPostCollision
				wallUp:addEventListener( "postCollision", wallUp )


				for i = 1,#saw do
				saw[i].postCollision = onLocalPostCollision
				saw[i]:addEventListener( "postCollision", saw[i] )
				end


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
