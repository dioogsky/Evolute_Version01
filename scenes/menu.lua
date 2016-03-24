-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

display.setStatusBar(display.HiddenStatusBar)
local composer = require( "composer" )
local rect = require('classes.rect')
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------
local function showScene1()
	local options = {
		effect = 'crossFade',
		time= 100
	}
	
	--composer.removeScene( "scenes.scene1" )
	
	composer.gotoScene("scenes.scene1",options)
	
end

		

-- "scene:create()"
function scene:create( event )
	
    local sceneGroup = self.view
    composer.removeScene('scenes.scene1')
	local bg = display.newRect(display.contentCenterX,display.contentCenterY,375,677)
	bg: setFillColor(0.93,0.93,0.93)
	
	local text1 = display.newImage('img/Departure.png', display.contentCenterX, 165)
	
	level1Button = display.newImage('img/level1.png',70,250)
	level1Button.name = "level1_Button"
	level1Button.alpha = 0
	transition.to( level1Button, { alpha = 1,time = 300,delay = 100 })
		
	level2Button = display.newImage('img/level2.png',150,250)
	level2Button.name = "level2_Button"
	level2Button.alpha = 0
	transition.to( level2Button, { alpha = 1,time = 300,delay = 300 })
	
		
	level3Button = display.newImage('img/level3.png',230,250)
	level3Button.name = "level3_Button"
	level3Button.alpha = 0
	transition.to( level3Button, { alpha = 1,time = 300,delay = 500 })
		
	sceneGroup:insert(bg)	
	sceneGroup:insert(level1Button)
	sceneGroup:insert(level2Button)
	sceneGroup:insert(level3Button)
	
    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen)
    
    elseif ( phase == "did" ) then

		local function onObjectTap( self, event )
    		print( "Tap event on: " .. self.name )
    		if (self.name == "level1_Button") then
    			showScene1()
    		return true
    		end
		end 

		level1Button.tap = onObjectTap
		level1Button:addEventListener( "tap", level1Button )
		
		level2Button.tap = onObjectTap
		level2Button:addEventListener( "tap", level2Button )
		
		level3Button.tap = onObjectTap
		level3Button:addEventListener( "tap", level3Button )

        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
    
    	
    	
        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view
	sceneGroup:removeSelf()
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



