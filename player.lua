require("rice")
function player (x, y, max_vx, max_vy, max_hunger, size, range)

	local alive = true
	local auto_move = false
	local timer = 0
	local reproduce_chance = math.random(0, 1)
	local function mutate()
		return math.random(-5, 5)
	end
	
	return{
	x = x,
	y = y,
	size = size,
	max_vx = max_vx,
	max_vy = max_vy,
	max_hunger = max_hunger,
	hunger = max_hunger,
	range = range,
	
	eat = function(self)
	
		if alive then
			if self.hunger < self.max_hunger then
				self.hunger = self.hunger + 1
			end
		end
	end,
	
	update = function(self, dt)
		if alive then
			local angle = angle_between(self.x, cursor.x, self.y, cursor.y)
			timer = timer + dt 
			
			if timer >= 1 then
				--self.hunger = self.hunger - 1
				timer = 0
				reproduce_chance = math.random(0, 3)
			end
			
			if auto_move == false then
				if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
					self.y = self.y - self.max_vy * dt
				end
				if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
					self.y = self.y  + self.max_vy * dt
				end
				if love.keyboard.isDown("a") or love.keyboard.isDown("left")  then
					self.x = self.x - self.max_vx * dt
				end
				if love.keyboard.isDown("d") or love.keyboard.isDown("right")  then
					self.x = self.x + self.max_vx * dt
				end
				
			else
				if love.keyboard.isDown("w") or love.keyboard.isDown("up") or love.keyboard.isDown("s") or love.keyboard.isDown("down") or love.keyboard.isDown("a") or love.keyboard.isDown("left") or love.keyboard.isDown("d") or love.keyboard.isDown("right") then
					auto_move = false
				end
				
				if distance_between(cursor.x, self.x, cursor.y, self.y) > 0 then
					self.x = self.x + math.cos(angle) * self.max_vx * dt
					self.y = self.y + math.sin(angle) * self.max_vy * dt
				end
			end
			
			if self.hunger <= 0 then
				self:kill()
			end
			
			function love.keypressed(key)
				if key == "q" then
					auto_move = not auto_move
				end
			end
			
			if reproduce_chance == 2 then
				self:reproduce()
			end
		end
	end,
		
	draw = function(self)
		if alive then
			love.graphics.circle("fill", self.x, self.y, self.size)
		end
	end,
	
	kill = function()
		alive = false
	end,
	
	reproduce = function(self)
		--[[if self.hunger >= 8 then
			table.insert(RICES, rice(self.x, self.y, self.max_vx + mutate(), self.max_vy + mutate(), self.max_hunger + mutate(), self.size, self.range + mutate()))
			self.hunger = self.hunger - 6
			reproduce_chance = 0
		end]]
	end,
	}
end