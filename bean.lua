function bean(gender, x, y, max_vx, max_vy, max_hunger, size)

	local timer = 0
	local hunger_timer = 0
	local interval = math.random(1, 6)
	--local reproduce_chance = math.random(0, 8)
	local mutation = math.random(0, 1)

	return{
		x = x,
		y = y,
		follow_x = 0,
		follow_y = 0,
		vx = math.random(-max_vx, max_vx),
		vy = math.random(-max_vy, max_vy),
		max_vx = max_vx,
		max_vy = max_vy,
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
		
		update = function(self, dt)
			timer = timer + dt
			hunger_timer = hunger_timer + dt
			local angle_between_predator = angle_between(self.x, self.run_x, self.y, self.run_y)
			local angle_between_grass = angle_between(self.x, self.follow_x, self.y, self.follow_y)
			
			if self.alive == true then
				if self.running == true then
					self.x = self.x + math.cos(angle_between_predator) * -max_vx * dt
					self.y = self.y + math.sin(angle_between_predator) * -max_vy * dt
				elseif self.following == true then
					self.x = self.x + math.cos(angle_between_grass) * max_vx * dt
					self.y = self.y + math.sin(angle_between_grass) * max_vy * dt
				else
					self.x = self.x + self.vx * dt
					self.y = self.y + self.vy * dt
				end
				
				if timer >= interval then
					self.vx = math.random(-self.max_vx, max_vx)
					self.vy = math.random(-self.max_vy, max_vy)
					reproduce_chance = math.random(0, 8)
					mutation = math.random(0, 1)
					interval = math.random(1, 6)
					timer = 0
				end
							
				if gender == "male" then
					if self.hunger == self.max_hunger then
						self.search = true
					elseif self.hunger <= 3 then
						self.search = false
					end
				end
				
				if hunger_timer >= 4 then
					self.hunger = self.hunger - 1
					hunger_timer = 0
				end
				
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
			self.hunger = self.hunger - 3
			mob_count = mob_count + 1
			if gender == "female" then
				local t = male
				table.insert(BEANS, bean(pick_gender(), self.x, self.y, vary(self.max_vx, t.max_vx), vary(self.max_vy, t.max_vy), self.max_hunger, vary(self.size, t.size)))
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
		end
	}
end