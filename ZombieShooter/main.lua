require"Player"
require"Objects"
require"ObjectsDraw"
require"Enemy"

function love.load()
	
	love.graphics.setDefaultFilter("nearest", "nearest")
	
	debug = true
	Player = Player(debug)
	Enemy = Enemy(debug)
	ObjectsFunc = ObjectsFunc(Objects)
	
	Enemy:Spawn()
end


function love.update(dt)
	Player:Walk(dt)
	Player:ShootUpdate()
end

function love.mousepressed(x, y, button)
	if button == 1 then
		Player:Shoot()
	end
end

function love.draw()
	love.graphics.translate(CameraX, CameraY)
	
	
	love.graphics.scale(3.5,3.5)
	ObjectsFunc:Draw()
	Player:Draw()
	Player:Camera()
	Player:ShootDraw()
	Enemy:Draw()
	
	love.graphics.origin()
end