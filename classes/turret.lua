-----------------------------------------------------------------------------------------
--
-- turret.lua
--
-----------------------------------------------------------------------------------------
turret_angular = 90
function turret_new (positon_x,position_y,speed)
  a,b=positon_x,position_y
  local turret = display.newImage('img/turretGun.png',positon_x-30,position_y)
  turret.anchorX,turret.anchorY = 0,0.5
  turret.isClockWise = 1
  turret.isStop = 0

  if(speed) then
    turret.speed = speed
  else
    turret.speed = 1
  end

  function turret:move1()
    if(turret_angular < 120 and turret.isClockWise == 1 and turret.isStop == 0 )then
      turret:rotate(turret.speed)
      turret_angular = turret_angular+turret.speed
    elseif (turret_angular >= 100 and turret.isStop == 0)then
      turret.isClockWise = 0
    end
    if(turret_angular > 60 and turret.isClockWise == 0 and  turret.isStop == 0)then
      turret:rotate(-turret.speed)
      turret_angular = turret_angular-turret.speed
    elseif (turret_angular <= 60 and turret.isStop == 0)then
      turret.isClockWise = 1
    end

  end

	return turret
end


return turret
