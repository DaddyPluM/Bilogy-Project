function bean(x, y, max_vx, max_vy, size)

	local timer = 0
	local alive = true
	local interval = math.random(1, 6)
	local reproduce_chance = math.random(0, 1)
	local mutation = math.random(0, 4)
	local function mutation_rate()
		return math.random(-1, 1)
	end

	return{
		x = x,
		y = y,
		vx = math.random(-max_vx, max_vx),
		vy = math.random(-max_vy, max_vy),
		max_vx = max_vx,
		max_vy = max_vy,
		size = size,
		followed = false,
		
		update = function(self, dt)
			timer = timer + dt
			if alive == true then
				self.x = self.x + self.vx
				self.y = self.y + self.vy
				
				if timer >= interval then
					self.vx = math.random(-self.max_vx, self.max_vx) * dt
					self.vy = math.random(-self.max_vy, self.max_vy) * dt
					timer = 0
					reproduce_chance = math.random(0, 3)
					mutation = math.random(0, 4)
					interval = math.random(1, 6)
				end
				
				if self.x + 7.5 >= win_width then
					self.vx = self.vx * -1
				end
				if self.y + 7.5 >= win_height then
					self.vy = self.vy * -1
				end
				if self.x - 7.5 <= 0 then
					self.vx = self.vx * -1
				end
				if self.y - 7.5 <= 0 then
					self.vy = self.vy * -1
				end
				
				if reproduce_chance == 3 then
					self:reproduce()
					reproduce_chance = math.random(0, 3)
				end
			end
		end,
		
		draw = function(self)
			if alive == true then
				love.graphics.setColor(0, .5, 0)
				love.graphics.circle("fill", self.x, self.y, self.size)
				love.graphics.setColor(1, 1, 1)
			end
		end,

		kill = function(self)
			alive = false
		end,
		
		reproduce = function(self)
			mob_count = mob_count + 1
			if mutation ~= 2 then
				table.insert(BEANS, bean(self.x, self.y, self.max_vx, self.max_vy, self.size))
			else
				table.insert(BEANS, bean(self.x, self.y, self.max_vx + mutation_rate(), self.max_vy + mutation_rate(), self.size + mutation_rate()))
				mutation = 0
			end
		end,
	}
end