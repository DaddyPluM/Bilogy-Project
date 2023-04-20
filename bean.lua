function bean(x, y, max_vx, max_vy, size)

	local timer = 0
	local alive = true
	local interval = math.random(1, 6)
	local reproduce_chance = math.random(0, 5)
	local mutation = math.random(0, 1)
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
		running = false,
		run_x = 10,
		run_y = 10,
		
		update = function(self, dt)
			timer = timer + dt
			local angle = angle_between(self.x, self.run_x, self.y, self.run_y)
			
			if alive == true then
				if self.running == true then
					self.x = self.x + math.cos(angle) * -max_vx * dt
					self.y = self.y + math.sin(angle) * -max_vy * dt
				else
					self.x = self.x + self.vx * dt
					self.y = self.y + self.vy * dt
				end
				
				if timer >= interval then
					self.vx = math.random(-self.max_vx, self.max_vx) * dt
					self.vy = math.random(-self.max_vy, self.max_vy) * dt
					timer = 0
					reproduce_chance = math.random(0, 5)
					mutation = math.random(0, 1)
					interval = math.random(1, 6)
				end
				
				--[[if self.x + self.size/2 >= win_width and self.vx > 0 then
					self.vx = self.vx * -1
				end
				if self.y + self.size /2>= win_height and self.vy > 0 then
					self.vy = self.vy * -1
				end
				if self.x - self.size/2 <= 0 and self.vx < 0 then
					self.vx = self.vx * -1
				end
				if self.y - self.size/2 <= 0 and self.vy < 0 then
					self.vy = self.vy * -1
				end]]
				if reproduce_chance == 3 then
					self:reproduce()
					reproduce_chance = math.random(0, 3)
				end
				self.running = false
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
			if mutation ~= 1 then
				table.insert(BEANS, bean(self.x, self.y, self.max_vx, self.max_vy, self.size))
			else
				table.insert(BEANS, bean(self.x, self.y, self.max_vx + mutation_rate(), self.max_vy + mutation_rate(), self.size + mutation_rate()))
				mutation = 0
			end
		end,
	
	run = function(self, x, y)
		if alive then
			self.run_x = x
			self.run_y = y
			self.running = true
		end
	end,
	}
end