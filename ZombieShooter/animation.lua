local timeSinceLastTick = 0
function WalkPlayerAnim(tickInterval)
	PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0476_Capa-477.png")
	PlayerGoDown = false
	PlayerGoUp = false
	PlayerGoLeft = false
	PlayerGoRight = false
	return {
		Down = function()
			local dt = love.timer.getDelta()
			timeSinceLastTick = timeSinceLastTick + dt
			
			if timeSinceLastTick >= tickInterval and timeSinceLastTick < tickInterval*2 then
				--timeSinceLastTick = 0
				PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0477_Capa-478.png")
			end	
			
			if timeSinceLastTick >= tickInterval*2 then
				PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0478_Capa-479.png")
			end
				
			if timeSinceLastTick >= tickInterval*3 then
				timeSinceLastTick = 0
			end
			
			PlayerGoDown = true
			PlayerGoUp = false
			PlayerGoLeft = false
			PlayerGoRight = false
			
		end,
		
		Up = function()
			local dt = love.timer.getDelta()
			timeSinceLastTick = timeSinceLastTick + dt
			
			if timeSinceLastTick >= tickInterval and timeSinceLastTick < tickInterval*2 then
				--timeSinceLastTick = 0  Zombie-Tileset---_0482_Capa-483.png
				PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0483_Capa-484.png")
			end	
			
			if timeSinceLastTick >= tickInterval*2 then
				PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0484_Capa-485.png")
			end
				
			if timeSinceLastTick >= tickInterval*3 then
				timeSinceLastTick = 0
			end
			
			PlayerGoDown = false
			PlayerGoUp = true
			PlayerGoLeft = false
			PlayerGoRight = false
			
		end,
		
		Right = function()
			local dt = love.timer.getDelta()
			timeSinceLastTick = timeSinceLastTick + dt
			
			if timeSinceLastTick >= tickInterval and timeSinceLastTick < tickInterval*2 then
				--timeSinceLastTick = 0  Zombie-Tileset---_0479_Capa-480.png
				PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0480_Capa-481.png")
			end	
			
			if timeSinceLastTick >= tickInterval*2 then
				PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0481_Capa-482.png")
			end
				
			if timeSinceLastTick >= tickInterval*3 then
				timeSinceLastTick = 0
			end
			
			PlayerGoDown = false
			PlayerGoUp = false
			PlayerGoLeft = false
			PlayerGoRight = true
			
		end,
		
		Left = function()
			local dt = love.timer.getDelta()
			timeSinceLastTick = timeSinceLastTick + dt
			
			if timeSinceLastTick >= tickInterval and timeSinceLastTick < tickInterval*2 then
				--timeSinceLastTick = 0  Zombie-Tileset---_0485_Capa-486.png
				PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0486_Capa-487.png")
			end	
			
			if timeSinceLastTick >= tickInterval*2 then
				PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0487_Capa-488.png")
			end
				
			if timeSinceLastTick >= tickInterval*3 then
				timeSinceLastTick = 0
			end
			
			PlayerGoDown = false
			PlayerGoUp = false
			PlayerGoLeft = true
			PlayerGoRight = false
			
		end
	}
end

return WalkPlayerAnim