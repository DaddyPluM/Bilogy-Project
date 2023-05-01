function bean(gender, x, y, max_speed, max_hunger, size, range)

	local timer = 0
	local age_timer = 0
	local age = 0
	local hunger_timer = 0
	local interval = math.random(1, 6)
	--local reproduce_chance = math.random(0, 8)
	local mutation = math.random(0, 1)

	return{
		x = x,
		y = y,
		follow_x = 0,
		follow_y = 0,
		max_vx = max_speed,
		max_vy = max_speed,
		vx = math.random(-max_speed, max_speed),
		vy = math.random(-max_speed, max_speed),
		size = size,
		running = false,
		following = false,
		run_x = 0,
		run_y = 0,
		alive = true,
		max_hunger = max_hunger,
		hunger = max_hunger - 2,
		gender = gender,
		search = false,
		range = range,
		max_speed = max_speed,
		
		update = function(self, dt)
			timer = timer + dt
			hunger_timer = hunger_timer + dt
			age_timer = age_timer + dt
			local angle_between_predator = angle_between(self.x, self.run_x, self.y, self.run_y)
			local angle_between_grass = angle_between(self.x, self.follow_x, self.y, self.follow_y)
			
			if self.alive == true then

				if age_timer >= 3 then
					age = age + 1
					age_timer = 0
				end

				if age >= 8 then
					self:kill()
				end

				if self.running == true then
					self.x = self.x + math.cos(angle_between_predator) * -self.max_vx * dt
					self.y = self.y + math.sin(angle_between_predator) * -self.max_vy * dt
				elseif self.following == true then
					self.x = self.x + math.cos(angle_between_grass) * self.max_vx * dt
					self.y = self.y + math.sin(angle_between_grass) * self.max_vy * dt
				else
					self.x = self.x + self.vx * dt
					self.y = self.y + self.vy * dt
				end
				
				if timer >= interval then
					self.vx = math.random(-self.max_vx,self. max_vx)
					self.vy = math.random(-self.max_vy, self.max_vy)
					mutation = math.random(0, 1)
					interval = math.random(1, 6)
					timer = 0
					if self.search == false and self.hunger > self.max_hunger/2 then
						local g = math.random(0, (self.max_hunger/self.hunger))
						if g == 1 then
							self.search = true
						end
					elseif self.hunger <= self.max_hunger/2 then
						self.search = false
					end
				end

				local function negative_check(value)
					if value < 0 then
						return value * -1
					elseif value >= 0 then
						return value
					end
				end
	
				self.hunger = self.hunger - (average(negative_check(self.vx) + negative_check(self.vy),2)/20000)
							
				--[[if gender == "male" then
					if self.hunger == self.max_hunger then
						self.search = true
					elseif self.hunger <= 3 then
						self.search = false
					end
				end]]
				
				--[[if hunger_timer >= 2 then
					self.hunger = self.hunger - 1
					hunger_timer = 0
				end]]
				
				if self.x + self.size/2 >= box_size and self.vx > 0 then
					self.vx = self.vx * -1
				end
				if self.y + self.size /2>= box_size and self.vy > 0 then
					self.vy = self.vy * -1
				end
				if self.x - self.size/2 <= 0 and self.vx < 0 then
					self.vx = self.vx * -1
				end
				if self.y - self.size/2 <= 0 and self.vy < 0 then
					self.vy = self.vy * -1
				end
				
				if self.hunger <= 0 then
					self:kill()
				end
				
				self.running = false
				self.following = false
			end
		end,
		
		draw = function(self)
			if self.alive == true then
				if gender == "female" then
					love.graphics.setColor(0, .5, 0)
					love.graphics.circle("fill", self.x, self.y, self.size)
					love.graphics.setColor(1, 1, 1)
				elseif gender == "male" then
					love.graphics.setColor(0, .5, .5)
					love.graphics.circle("fill", self.x, self.y, self.size)
					love.graphics.setColor(1, 1, 1)
				end
			end
		end,

		kill = function(self)
			self.alive = false
		end,
		
		reproduce = function(self, male)
			self.hunger = self.hunger - 5
			mob_count = mob_count + 1
			if gender == "female" then
				local t = male
				local twins = math.random(0, 1)
				if twins == 0 then
					table.insert(BEANS, bean(pick_gender(), self.x, self.y, vary(self.max_speed, t.max_speed), self.max_hunger, self.size, vary(self.range, t.range)))
				elseif twins == 1 then
					table.insert(BEANS, bean(pick_gender(), self.x, self.y, vary(self.max_speed, t.max_speed), self.max_hunger, self.size, vary(self.range, t.range)))
					table.insert(BEANS, bean(pick_gender(), self.x, self.y, vary(self.max_speed, t.max_speed), self.max_hunger, self.size, vary(self.range, t.range)))
				end
			end
		end,
	
		run = function(self, x, y)
			if self.alive then
				self.run_x = x
				self.run_y = y
				self.running = true
			end
		end,
		
		follow = function(self, x, y)
			if self.running == false then
				self.follow_x = x
				self.follow_y = y
				self.following = true
			end
		end,
		
		eat = function(self)
			if self.hunger < self.max_hunger then
				self.hunger = self.hunger + 1
			end
			hunger_timer = 0
		end
	}
end