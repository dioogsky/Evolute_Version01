-----------------------------------------------------------------------------------------
--
-- start.lua
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

local function showMenu()
	-- local options = {
	-- 	effect = 'crossFade',
	-- 	time= 200
	-- }
	composer.gotoScene("scenes.menu")

end


-- "scene:create()"
function scene:create( event )

  local sceneGroup = self.view


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

				local logo = display.newImage('img/Start.png',display.contentCenterX,display.contentCenterY)
				-- local text = display.newText('>>> Tap here to start <<<',display.contentCenterX,570,"Lucida Grande",16)
				-- text:setFillColor(0.68,0.68,0.68,0.001)
				-- logo.myName = 'logo'
				sceneGroup:insert(logo)
				-- sceneGroup:insert(text)
				--
				-- local function onLogoTap( self, event )
	    	timer.performWithDelay( 1000, showMenu )
	    	-- 	return true
				-- end
				-- logo.tap = onLogoTap
				-- logo:addEventListener( "tap", logo )
				--
				-- function myListener( event )
	    	-- 	for i=0.001,1,0.001 do
				-- 		text:setFillColor(0.68,0.68,0.68,i)
				-- 	end
				-- end
				--Runtime:addEventListener( "enterFrame", myListener )

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
