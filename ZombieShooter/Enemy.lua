enemies = {}

function Enemy(debugging)
	
	local width = 16
	local height = 16
	local hp = 100
	
	return {
		Spawn = function()
			local x = love.math.random(0,1280/3.5)
			local y = love.math.random(-10,-30)
			for i,v in ipairs(enemies) do
				while enemies[i].x == x do
					x = love.math.random(0,1280/3.5)
				end
			end
			table.insert(enemies, {x=x, y=y, hp=hp})
		end,
		
		Draw = function()
			for i, v in ipairs(enemies) do
				if debugging then
					love.graphics.setColor(1,0,0)
					love.graphics.rectangle("line", v.x, v.y, width, height)
				end
				love.graphics.setColor(1,0,0)
				love.graphics.rectangle("fill", v.x, v.y, width, height)
			end
		end,
		
		Attack = function()
			
		end
	}
end	

return Enemy