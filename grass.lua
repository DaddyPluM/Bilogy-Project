function grass(x, y, size)
	local timer = 0
	--local reproduce_chance = 0
	local function mutate()
		return math.random(-15, 15)
	end
	
	return{
		x = x,
		y = y,
		size = size,
		alive = true,
		
		update = function(self, dt)
			timer = timer + dt
			if self.alive == true then
				timer = timer + dt
				
				--[[if timer >= 3 then
					reproduce_chance = math.random(0, 3)
					timer = 0
				end]]
				
				--[[if reproduce_chance == 1 then
					self:reproduce()
					reproduce_chance = 0
				end]]

				if #GRASSES < 2000 then
					self:reproduce()
				end
			end
		end,
		
		reproduce = function(self)
		if #GRASSES < 2000 then
			table.insert(GRASSES, grass(math.random(100, box_size)--[[self.x + mutate()]], math.random(100, box_size)--[[self.y + mutate()]], self.size + mutate()))
			reproduce_chance = 1
		end
		end,
		
		kill = function(self)
			self.alive = false
		end,
		
		draw = function(self)
			love.graphics.setColor(.4, 0, 0)
			love.graphics.circle("fill", self.x, self.y, self.size)
			love.graphics.setColor(1, 1, 1)
		end,
	} 

end