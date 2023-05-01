function rice(gender, x, y, max_speed, max_hunger, size, range)

	local move_timer = 0
	local hunger_timer = 0
	local interval = math.random(2, 8)
	local age_timer = 0
	local age = 0
	local function mutate()
		return math.random(-3, 3)
	end
	
	return{
		x = x,
		y = y,
		max_vx = max_speed,
		max_vy = max_speed,
		vx = math.random(-max_speed, max_speed),
		vy = math.random(-max_speed, max_speed),
		max_speed = max_speed,
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
				age_timer = age_timer + dt

				if age_timer >= 3 then
					age = age + 1
					age_timer = 0
				end

				if age >= 10 then
					self:kill()
				end

				local angle_between_food = angle_between(self.x, self.follow_x, self.y, self.follow_y)
				move_timer = move_timer + dt
				hunger_timer = hunger_timer + dt
				
				if self.following == true then
					self.x = self.x + math.cos(angle_between_food) * self.max_vx * dt
					self.y = self.y + math.sin(angle_between_food) * self.max_vy * dt
				else
					self.x = self.x + self.vx * dt
					self.y = self.y + self.vy * dt
				end
				
				if move_timer >= interval then
					self.vx = math.random(-self.max_vx, self.max_vx)
					self.vy = math.random(-self.max_vy, self.max_vy)
					move_timer = 0
					interval = math.random(1, 6)
					if self.search == false and self.hunger > self.max_hunger/2 then
						local g = math.random(0, ((self.max_hunger/self.hunger)))
						if g == 1 then
							self.search = true
						end
					end
					--reproduce_chance = math.random(0, 3)
					--self.following = false
				end
				
				--[[if gender == "male" then
					if self.hunger == self.max_hunger then
						self.search = true
					elseif self.hunger <= 3 then
						self.search = false
					end
				end]]

				local function negative_check(value)
					if value < 0 then
						return value * -1
					elseif value >= 0 then
						return value
					end
				end
	
				self.hunger = self.hunger - (average(negative_check(self.vx) + negative_check(self.vy),2)/60000)
				
				--[[if hunger_timer >= 2 then
					self.hunger = self.hunger - 1
					hunger_timer = 0
				end]]
					
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
				elseif self.hunger <= self.max_hunger/2 then
					self.search = false
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
			self.following = false
			if self.alive then
				if self.hunger < self.max_hunger then
					self.hunger = self.hunger + 2
				end
				hunger_timer = 0
			end
		end,
		
		draw = function(self)
			if self.alive then
				if gender == "female" then
					love.graphics.setColor(0.6, 0.6, 1)
				end
				love.graphics.circle("fill", self.x, self.y, self.size)
				love.graphics.setColor(1, 1, 1)
			end
		end,
		
		reproduce = function(self, male)
			reproduce_chance = 0
			self.hunger = math.floor(self.max_hunger/2)
			self.following = false
			if gender == "female" then
				local twins = math.random(0, 2)
				local t = male
				if twins ~= 1 then
					table.insert(RICES, rice(pick_gender(), self.x, self.y, vary(self.max_speed, t.max_speed),  self.max_hunger, self.size, vary(self.range, t.range)))
				elseif twins == 1 then
					table.insert(RICES, rice(pick_gender(), self.x, self.y, vary(self.max_speed, t.max_speed), self.max_hunger, self.size, vary(self.range, t.range)))
					table.insert(RICES, rice(pick_gender(), self.x, self.y, vary(self.max_speed, t.max_speed), self.max_hunger, self.size, vary(self.range, t.range)))
				end
			end
		end,
		
		kill = function(self)
			self.alive = false
		end
	}

end