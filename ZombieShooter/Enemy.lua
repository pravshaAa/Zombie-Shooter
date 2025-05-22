enemies = {}

function Enemy(debugging)
    local width = 14
    local height = 16
    local hp = 100
    
    local Animations = Animations(0.2)
    
    return {
        speed = 25,
        
        AI = function(self, PlayerTable, dt)
            local xPlayer = PlayerTable.x
            local yPlayer = PlayerTable.y
            
            for i, enemy in ipairs(enemies) do
                -- Вычисляем направление к игроку
                local dirX, dirY = xPlayer - enemy.x, yPlayer - enemy.y
                local distance = math.sqrt(dirX^2 + dirY^2)
                
                if distance > 0 then
                    -- Нормализуем вектор направления
                    dirX, dirY = dirX/distance, dirY/distance
                    
                    -- Определяем основное направление для анимации
                    local primaryHorizontal = math.abs(dirX) > math.abs(dirY)
                    
                    -- Выбираем анимацию
                    if primaryHorizontal then
                        if dirX > 0 then
                            Animations.PlayZombie(ZombieGoRightTable, i)
                        else
                            Animations.PlayZombie(ZombieGoLeftTable, i)
                        end
                    else
                        if dirY > 0 then
                            Animations.PlayZombie(ZombieGoDownTable, i)
                        else
                            Animations.PlayZombie(ZombieGoUpTable, i)
                        end
                    end
                    
                    -- Вычисляем перемещение
                    local moveX = dirX * self.speed * dt
                    local moveY = dirY * self.speed * dt
                    
                    -- Новая позиция
                    local newX = enemy.x + moveX
                    local newY = enemy.y + moveY
                    
                    -- Проверка коллизий
                    local canMoveX, canMoveY = true, true
                    
                    -- С объектами
                    for _, obj in ipairs(Objects) do
                        if obj.collision then
                            if CheckCollision(newX, enemy.y, width, height, obj.x, obj.y, obj.width or 16, obj.height or 16) then
                                canMoveX = false
                            end
                            if CheckCollision(enemy.x, newY, width, height, obj.x, obj.y, obj.width or 16, obj.height or 16) then
                                canMoveY = false
                            end
                        end
                    end
                    
                    -- С игроком
                    if CheckCollision(newX, enemy.y, width, height, xPlayer, yPlayer, 16, 16) then
                        canMoveX = false
                    end
                    if CheckCollision(enemy.x, newY, width, height, xPlayer, yPlayer, 16, 16) then
                        canMoveY = false
                    end
                    
                    -- С другими врагами
                    for j, other in ipairs(enemies) do
                        if i ~= j then
                            if CheckCollision(newX, enemy.y, width, height, other.x, other.y, other.width, other.height) then
                                canMoveX = false
                            end
                            if CheckCollision(enemy.x, newY, width, height, other.x, other.y, other.width, other.height) then
                                canMoveY = false
                            end
                        end
                    end
                    
                    -- Применяем движение
                    if canMoveX then enemy.x = newX end
                    if canMoveY then enemy.y = newY end
                    
                    -- Проверка атаки
                    enemy.hit = checkCircleRectCollision(
                        xPlayer+8, yPlayer+8, 8, 
                        enemy.x, enemy.y, width, height
                    )
                end
            end
        end,
        
        Spawn = function(self)
            local x = love.math.random(0, 1280/3.5)
            local y = love.math.random(-20, -100)
            
            -- Проверка на пересечение с существующими врагами
            local validPosition = true
            for _, enemy in ipairs(enemies) do
                if CheckCollision(x, y, 14, 16, enemy.x, enemy.y, enemy.width, enemy.height) then
                    validPosition = false
                    break
                end
            end
            
            if validPosition then
                table.insert(enemies, {
                    types = "Zombie",
                    x = x,
                    y = y,
                    hp = hp,
                    collision = true,
                    width = width,
                    height = height,
                    hit = false,
                    sprite = ZombieDefaultDown,
                    timeSinceLastTick = 0,
                    prevX = x,
                    prevY = y
                })
            else
                -- Если позиция занята, пробуем еще раз
                self:Spawn()
            end
        end,
        
        Draw = function(self)
            for i, enemy in ipairs(enemies) do
                if debugging then
                    love.graphics.setColor(1, 0, 0)
                    love.graphics.rectangle("line", enemy.x, enemy.y, enemy.width, enemy.height)
                end
                
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(enemy.sprite, enemy.x + 1, enemy.y)
            end
        end
    }
end

function checkCircleRectCollision(circleX, circleY, circleR, rectX, rectY, rectW, rectH)
    local closestX = math.max(rectX, math.min(circleX, rectX + rectW))
    local closestY = math.max(rectY, math.min(circleY, rectY + rectH))
    
    local distanceX = circleX - closestX
    local distanceY = circleY - closestY
    local distanceSquared = (distanceX * distanceX) + (distanceY * distanceY)
    
    return distanceSquared < (circleR * circleR)
end

function CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2) 
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1 
end

return Enemy
