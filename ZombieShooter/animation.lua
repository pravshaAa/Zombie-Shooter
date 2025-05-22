require"spritesName"

local timeSinceLastTickPlayer = 0

function Animations(tickInterval)
	PlayerSprite = PlayerDefaultDown
	PlayerGoDown = false
	PlayerGoUp = false
	PlayerGoLeft = false
	PlayerGoRight = false
	return {
		PlayPlayer = function(tableSprites)
			
			local dt = love.timer.getDelta()
			timeSinceLastTickPlayer = timeSinceLastTickPlayer + dt
			
			if timeSinceLastTickPlayer >= tickInterval and timeSinceLastTickPlayer < tickInterval*2 then
				--timeSinceLastTick = 0
				PlayerSprite = tableSprites.a
			end	
			
			if timeSinceLastTickPlayer >= tickInterval*2 then
				PlayerSprite = tableSprites.b
			end
				
			if timeSinceLastTickPlayer >= tickInterval*3 then
				timeSinceLastTickPlayer = 0
			end
		end,
		
		PlayZombie = function(tableSprites, i)
			local dt = love.timer.getDelta()
			enemies[i].timeSinceLastTick = enemies[i].timeSinceLastTick + dt
			
			if enemies[i].timeSinceLastTick >= tickInterval and enemies[i].timeSinceLastTick < tickInterval*2 then
				enemies[i].sprite = tableSprites.a
			end	
			
			if enemies[i].timeSinceLastTick >= tickInterval*2 then
				enemies[i].sprite = tableSprites.b
			end
				
			if enemies[i].timeSinceLastTick >= tickInterval*3 then
				enemies[i].timeSinceLastTick = 0
			end
		end,
	}
end

return Animations
