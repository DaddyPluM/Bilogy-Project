function grass(x, y, size)
	local timer = 0
	local reproduce_chance = 0
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
				
				if timer >= 2 then
					reproduce_chance = math.random(0, 3)
					timer = 0
				end
				
				if reproduce_chance == 1 then
					self:reproduce()
					reproduce_chance = 0
				end
			end
		end,
		
		reproduce = function(self)
			table.insert(GRASSES, grass(self.x + mutate(), self.y + mutate(), self.size + mutate()))
			reproduce_chance = 1
		end,
		
		kill = function(self)
			self.alive = false
		end,
		
		draw = function(self)
			love.graphics.circle("fill", self.x, self.y, self.size)
		end,
	} 

end