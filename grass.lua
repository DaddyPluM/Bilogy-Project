function grass(x, y, size)
	local timer = 0
	--local reproduce_chance = 0
	local function mutate_p()
		return math.random(-40, 40)
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
				
				if timer >= 5 then
					reproduce_chance = math.random(0, 5)
					timer = 0
				end
				
				if reproduce_chance == 1 then
					self:reproduce()
					reproduce_chance = 0
				end

				if #GRASSES < 1000 and day < 40 then
					self:reproduce()
				end
			end
		end,
		
		reproduce = function(self)
			local children = math.random(4, 10)
			if #GRASSES < 2500 then
				for i = 1, 4 do
					table.insert(GRASSES, grass(math.random(11, box_size)--[[self.x + mutate_p()]], math.random(11, box_size)--[[self.y + mutate_p()]], self.size))
					reproduce_chance = 0
				end
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