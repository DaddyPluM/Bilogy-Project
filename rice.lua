function rice(x, y, max_vx, max_vy, max_hunger, size, range)

	local move_timer = 0
	local hunger_timer = 0
	local interval = 1
	local reproduce_chance = math.random(0, 1)
	local alive = true
	local function mutate()
		return math.random(-5, 5)
	end
	
return{
	x = x,
	y = y,
	max_vx = max_vx,
	max_vy = max_vy,
	vx = 1,
	vy = 1,
	max_hunger = max_hunger,
	hunger = 8,
	size = size,
	follow_x = 0,
	follow_y = 0,
	following = false,
	range = range,
	
	update = function(self, dt)
		if alive then
			local angle = angle_between(self.x, self.follow_x, self.y, self.follow_y)
			move_timer = move_timer + dt
			hunger_timer = hunger_timer + dt
			
			if self.following == true then
				self.x = self.x + math.cos(angle) * max_vx * dt
				self.y = self.y + math.sin(angle) * max_vy * dt
			else
				self.x = self.x + self.vx * dt
				self.y = self.y + self.vy * dt
			end
			
			if move_timer >= interval then
				self.vx = math.random(-self.max_vx, self.max_vx)
				self.vy = math.random(-self.max_vy, self.max_vy)
				interval = math.random(1, 6)
				move_timer = 0
				reproduce_chance = math.random(0, 3)
				self.following = false
			end
			
			if hunger_timer >= 1 then
				self.hunger = self.hunger - 1
				hunger_timer = 0
			end
				
			--[[if self.x + self.size/2 >= win_width and self.vx > 0 then
				self.vx = self.vx * -1
			end
			if self.y + self.size/2 >= win_height and self.vy > 0 then
				self.vy = self.vy * -1
			end
			if self.x - self.size/2 <= 0 and self.vx < 0 then
				self.vx = self.vx * -1
			end
			if self.y - self.size/2 <= 0  and self.vy < 0 then
				self.vy = self.vy * -1
			end]]

			if reproduce_chance == 1 then
				self:reproduce()
				reproduce_chance = 0
			end
			
			if self.hunger <= 0 then
				self:kill()
			end
			
			self.following = false
		end
	end,
	
	follow = function(self, x, y)
		if alive then
			self.follow_x = x
			self.follow_y = y
			self.following = true
		end
	end,
	
	eat = function(self)
		if alive then
			if self.hunger < self.max_hunger then
				self.hunger = self.hunger + 1
				self.following = false
			else
				self.following = false
			end
		end
	end,
	
	draw = function(self)
		if alive then
			love.graphics.circle("fill", self.x, self.y, self.size)
		end
	end,
	
	reproduce = function(self)
		if self.hunger >= 8 then
			table.insert(RICES, rice(self.x, self.y, self.max_vx + mutate(), self.max_vy + mutate(), self.max_hunger + mutate(), self.size + mutate(), self.range + mutate()))
			self.hunger = self.hunger - 6
			reproduce_chance = 0
		end
	end,
	
	kill = function(self)
		alive = false
	end
}

end