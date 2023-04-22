function rice(gender, x, y, max_vx, max_vy, max_hunger, size, range)

	local move_timer = 0
	local hunger_timer = 0
	local interval = 1
	
return{
	x = x,
	y = y,
	max_vx = max_vx,
	max_vy = max_vy,
	vx = 1,
	vy = 1,
	max_hunger = max_hunger,
	hunger = max_hunger - 2,
	size = size,
	follow_x = 0,
	follow_y = 0,
	following = false,
	range = range,
	search = false,
	gender = gender,
	alive = true,
	
	update = function(self, dt)
		if self.alive then
			local angle_between_food = angle_between(self.x, self.follow_x, self.y, self.follow_y)
			move_timer = move_timer + dt
			hunger_timer = hunger_timer + dt
			
			if self.following == true then
				self.x = self.x + math.cos(angle_between_food) * max_vx * dt
				self.y = self.y + math.sin(angle_between_food) * max_vy * dt
			else
				self.x = self.x + self.vx * dt
				self.y = self.y + self.vy * dt
			end
			
			if move_timer >= interval then
				self.vx = math.random(-self.max_vx, self.max_vx)
				self.vy = math.random(-self.max_vy, self.max_vy)
				interval = math.random(3, 10)
				move_timer = 0
				--reproduce_chance = math.random(0, 3)
				--self.following = false
			end
			
			if gender == "male" then
				if self.hunger == self.max_hunger then
					self.search = true
				elseif self.hunger <= 3 then
					self.search = false
				end
			end
			
			if hunger_timer >= 2 then
				self.hunger = self.hunger - 1
				hunger_timer = 0
			end
				
			if self.x + self.size/2 >= box_size and self.vx > 0 then
				self.vx = self.vx * -1
			end
			if self.y + self.size/2 >= box_size and self.vy > 0 then
				self.vy = self.vy * -1
			end
			if self.x - self.size/2 <= 0 and self.vx < 0 then
				self.vx = self.vx * -1
			end
			if self.y - self.size/2 <= 0  and self.vy < 0 then
				self.vy = self.vy * -1
			end

			if self.hunger <= 0 then
				self:kill()
			end
			
			self.following = false
		end
	end,
	
	follow = function(self, x, y)
		if self.alive then
			self.follow_x = x
			self.follow_y = y
			self.following = true
		end
	end,
	
	eat = function(self)
		if self.alive then
			if self.hunger < self.max_hunger then
				self.hunger = self.hunger + 1
				self.following = false
			else
				self.following = false
			end
			hunger_timer = 0
		end
	end,
	
	draw = function(self)
		if self.alive then
			if gender == "female" then
				love.graphics.setColor(.6, .6, 1)
			end
			love.graphics.circle("fill", self.x, self.y, self.size)
			love.graphics.setColor(1, 1, 1)
		end
	end,
	
	reproduce = function(self, male)
		reproduce_chance = 0
		self.hunger = self.hunger - 6
		self.following = false
		if gender == "female" then
			local f = male
			--print(male.max_vx)
			table.insert(RICES, rice(pick_gender(), self.x, self.y, vary(self.max_vx, f.max_vx), vary(self.max_vy, f.max_vy), self.max_hunger, vary(self.size, f.size), vary(self.range, f.range)))
		end
	end,
	
	kill = function(self)
		self.alive = false
		table.remove(RICES, index)
	end
}

end