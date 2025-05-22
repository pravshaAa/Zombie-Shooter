CameraX = 0
CameraY = 0
require"Objects"
require"animation"
require"spritesName"
require"Enemy"

function Player(debugging)
	debugging = debugging or false
	local width = 16
	local height = 16
	bullets = {}
	local bulletSpeed = 200
	
	local Animations = Animations(0.12)
	
	return {
		x = (love.graphics.getWidth()/2)/3.5-16,
		y = (love.graphics.getHeight()/2)/3.5-16,
		speed = 75,
		cameraSpeed = 3.5, 
		hp = 100,
		oldX = 0,
		oldY = 0,
		
	Walk = function(self, dt)
			local moveX, moveY = 0, 0
			local speed = self.speed / love.timer.getFPS()

			self.oldX = self.x
			self.oldY = self.y
    
			if not love.keyboard.isDown("w") and not love.keyboard.isDown("s") and not love.keyboard.isDown("d") and not love.keyboard.isDown("a") and PlayerGoDown then
				PlayerSprite = PlayerDefaultDown
			end
    
			if not love.keyboard.isDown("w") and not love.keyboard.isDown("s") and not love.keyboard.isDown("d") and not love.keyboard.isDown("a") and PlayerGoUp then
				PlayerSprite = PlayerDefaultUp
			end
    
			if not love.keyboard.isDown("w") and not love.keyboard.isDown("s") and not love.keyboard.isDown("d") and not love.keyboard.isDown("a") and PlayerGoRight then
				PlayerSprite = PlayerDefaultRight
			end
    
			if not love.keyboard.isDown("w") and not love.keyboard.isDown("s") and not love.keyboard.isDown("d") and not love.keyboard.isDown("a") and PlayerGoLeft then
				PlayerSprite = PlayerDefaultLeft
			end
    
			if love.keyboard.isDown("w") then
				moveY = moveY - speed
			elseif love.keyboard.isDown("s") then
				moveY = moveY + speed
			end
    
			if love.keyboard.isDown("d") then
				moveX = moveX + speed
			elseif love.keyboard.isDown("a") then
				moveX = moveX - speed
			end
    
			if moveX > 0 then
				Animations.PlayPlayer(PlayerGoRightTable)
				PlayerGoDown = false
				PlayerGoUp = false
				PlayerGoLeft = false
				PlayerGoRight = true
			elseif moveX < 0 then
				Animations.PlayPlayer(PlayerGoLeftTable)
				PlayerGoDown = false
				PlayerGoUp = false
				PlayerGoLeft = true
				PlayerGoRight = false
			elseif moveY < 0 then 
				Animations.PlayPlayer(PlayerGoUpTable)
				PlayerGoDown = false
				PlayerGoUp = true
				PlayerGoLeft = false
				PlayerGoRight = false
			elseif moveY > 0 then
				Animations.PlayPlayer(PlayerGoDownTable)
				PlayerGoDown = true
				PlayerGoUp = false
				PlayerGoLeft = false
				PlayerGoRight = false
			end
    
			local newX = self.x + moveX
			local newY = self.y + moveY
    
			local canMoveX = true
			local canMoveY = true
    
			for i, obj in ipairs(Objects) do
				if obj.collision then
					if CheckCollision(newX, self.y, width, height, obj.x, obj.y, obj.width or 16, obj.height or 16) then
						canMoveX = false
					end
            
					if CheckCollision(self.x, newY, width, height, obj.x, obj.y, obj.width or 16, obj.height or 16) then
						canMoveY = false
					end
				end
			end
    
			for i, enemy in ipairs(enemies) do
				if enemy.collision then
					if CheckCollision(newX, self.y, width, height, enemy.x, enemy.y, enemy.width, enemy.height) then
						canMoveX = false
					end
					if CheckCollision(self.x, newY, width, height, enemy.x, enemy.y, enemy.width, enemy.height) then
						canMoveY = false
					end
				end
			end
    
			if canMoveX then
				self.x = newX
			end
    
			if canMoveY then
				self.y = newY
			end
    
			if moveX ~= 0 and moveY ~= 0 then
				if not canMoveX and canMoveY then
					self.y = newY
				elseif canMoveX and not canMoveY then
					self.x = newX
				end
			end
		end,
		
		Draw = function(self)
			love.graphics.setColor(1,1,1)
			love.graphics.draw(PlayerSprite, self.x+1, self.y, 0, 1)
			
			if debugging then
				love.graphics.setColor(1,0,0)
				love.graphics.rectangle("line", self.x, self.y, width, height)
			end
		end,
		
		Shoot = function(self)
			local startX = self.x + width / 2
			local startY = self.y + height / 2
			
			local Xmouse, Ymouse = love.mouse.getPosition() 
			
			local worldX = (Xmouse - love.graphics.getWidth()/2) / 3.5 + startX
			local worldY = (Ymouse - love.graphics.getHeight()/2) / 3.5 + startY
    
			local angle = math.atan2(worldY - startY, worldX - startX)
		
			local bulletDx = bulletSpeed * math.cos(angle)
			local bulletDy = bulletSpeed * math.sin(angle)
		
			table.insert(bullets, {x = startX, y = startY, dx = bulletDx, dy = bulletDy, timer=0})
		end,
		
		ShootDraw = function(self)
			love.graphics.setColor(0.5, 0.5, 0.5)
			for i,v in ipairs(bullets) do
				love.graphics.circle("fill", v.x, v.y, 3)
			end
		end,
		
		ShootUpdate = function(self)
			for i,v in ipairs(bullets) do
				v.x = v.x + (v.dx / love.timer.getFPS())
				v.y = v.y + (v.dy / love.timer.getFPS())
			end
			
			
		end,
		
		Camera = function(self)
			CameraY = -self.y *3.5 + love.graphics.getHeight()/2-32
			CameraX = -self.x *3.5 + love.graphics.getWidth()/2-32
		end
	}
end

function CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2) 
	return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1 
end

return Player
