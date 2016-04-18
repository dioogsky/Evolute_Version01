-----------------------------------------------------------------------------------------
--
-- turret.lua
--
-----------------------------------------------------------------------------------------

function bullet_new (positon_x,position_y,speed)
  local bullet = display.newRect(math.sin(turret_angular)*110,b-math.cos(turret_angular)*30,10,2)
  bullet:setFillColor(1,0.3,0.1,0)
  function bullet:fire()
    if(turret_angular == 70 or turret_angular == 90) then
      bullet.x,bullet.y = math.sin(turret_angular)*110,800-math.cos(turret_angular)*30
      bullet:setFillColor(1,0.3,0.1,0.4)
      bullet.rotation = turret_angular - 90
      transition.to(bullet,{x=math.sin(turret_angular)*1100 ,y=b-math.cos(turret_angular)*500,time = 4000 })
    end
  end



	return bullet
end


return bullet
