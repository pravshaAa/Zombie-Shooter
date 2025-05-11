
function ObjectsFunc(table)
	local width = 16
	local height = 16
	return {
		Draw = function(self)
			for i, v in ipairs(table) do
				if table[i].typeObjects == "pp" then
					local width = table[i].width or 16
					local height = table[i].height or 16
					love.graphics.setColor(1,0,0)
					love.graphics.rectangle("fill", table[i].x, table[i].y, width, height)
				elseif table[i].typeObjects == "pt" then
					local width = table[i].width or 16
					local height = table[i].height or 16
					love.graphics.setColor(0,0,1)
					love.graphics.rectangle("fill", table[i].x, table[i].y, width, height)
				end
			end
		end
	}
end

return ObjectsDraw
