CameraX = 0
CameraY = 0
require"Objects"
require"animation"


function Player(debugging)
	debugging = debugging or false
	local width = 16
	local height = 16
	local bullets = {}
	local bulletSpeed = 200
	
	local WalkPlayerAnim = WalkPlayerAnim(0.12)
	
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
				PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0476_Capa-477.png")
			end
			
			if not love.keyboard.isDown("w") and not love.keyboard.isDown("s") and not love.keyboard.isDown("d") and not love.keyboard.isDown("a") and PlayerGoUp then
				PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0482_Capa-483.png")
			end
			
			if not love.keyboard.isDown("w") and not love.keyboard.isDown("s") and not love.keyboard.isDown("d") and not love.keyboard.isDown("a") and PlayerGoRight then
				PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0479_Capa-480.png")
			end
			
			if not love.keyboard.isDown("w") and not love.keyboard.isDown("s") and not love.keyboard.isDown("d") and not love.keyboard.isDown("a") and PlayerGoLeft then
				PlayerSprite = love.graphics.newImage("sprites/Zombie-Tileset---_0485_Capa-486.png")
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
				WalkPlayerAnim:Right()
			elseif moveX < 0 then
				WalkPlayerAnim:Left()
			elseif moveY < 0 then 
				WalkPlayerAnim:Up()
			elseif moveY > 0 then
				WalkPlayerAnim:Down()
			end
    
			local newX = self.x + moveX
			local newY = self.y + moveY
    
			local collided = false
			for i, v in ipairs(Objects) do 
				if Objects[i].collision then
					local widthLocal = Objects[i].width or 16
					local heightLocal = Objects[i].height or 16
					if CheckCollision(newX, newY, width, height, Objects[i].x, Objects[i].y, widthLocal, heightLocal) then  collided = true
						if not CheckCollision(self.x, newY, width, height, Objects[i].x, Objects[i].y, widthLocal, heightLocal) then
							self.y = newY
						elseif not CheckCollision(newX, self.y, width, height, Objects[i].x, Objects[i].y, widthLocal, heightLocal) then
							self.x = newX
						else
							self.x = self.oldX
							self.y = self.oldY
						end
					end
				end
			end
    
			if not collided then
				self.x = newX
				self.y = newY
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
		
			table.insert(bullets, {x = startX, y = startY, dx = bulletDx, dy = bulletDy})
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