
function ObjectsFunc(table)
    return {
        Draw = function(self)
            for i, v in ipairs(table) do
                self:DrawSingle(v)
            end
        end,

        DrawSingle = function(self, obj)
            if obj.typeObjects == "pp" then
                local width = obj.width or 16
                local height = obj.height or 16
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("fill", obj.x, obj.y, width, height)
            elseif obj.typeObjects == "pt" then
                local width = obj.width or 16
                local height = obj.height or 16
                love.graphics.setColor(0, 0, 1)
                love.graphics.rectangle("fill", obj.x, obj.y, width, height)
            end
        end
    }
end

return ObjectsDraw
