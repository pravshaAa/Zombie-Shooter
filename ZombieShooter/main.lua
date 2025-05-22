require"Player"
require"Objects"
require"ObjectsDraw"
require"Enemy"

function love.load()
	love.graphics.setBackgroundColor(1,1,1)
	
	debug = false
	Player = Player(debug)
	Enemy = Enemy(debug)
	ObjectsFunc = ObjectsFunc(Objects)
	
	for i = 1, 20 do
		Enemy:Spawn()
	end
end


function love.update(dt)
	
	for i, v in ipairs(bullets) do
		bullets[i].timer = bullets[i].timer + dt
	end
	
	for i, v in ipairs(bullets) do
		if bullets[i].timer >= 10 then
			table.remove(bullets, i)
		end
	end
	
	Player:Walk(dt)
	Player:ShootUpdate()
	Enemy:AI(Player, dt)
end

function love.mousepressed(x, y, button)
	if button == 1 then
		Player:Shoot()
	end
end

function love.draw()
    Player:Camera()
    
    love.graphics.push()
    love.graphics.translate(CameraX, CameraY)
    love.graphics.scale(3.5, 3.5)
    

    table.sort(Objects, function(a, b) return a.y < b.y end)
    
    local playerDrawn = false
    for i, obj in ipairs(Objects) do
        if obj.y > Player.y and not playerDrawn then
            Player:Draw()
            playerDrawn = true
        end
        ObjectsFunc:DrawSingle(obj)
    end
    if not playerDrawn then Player:Draw() end
    
    Player:ShootDraw()
    Enemy:Draw()
	
    love.graphics.pop()
	
	love.graphics.setColor(0.8, 0, 0)
	love.graphics.rectangle("fill", 10, 10, Player.hp/100*200, 20) --нынешнее кол-во хп / максимальное кол-во хп * длину полоски хп
end
