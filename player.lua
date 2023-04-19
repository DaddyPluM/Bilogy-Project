function player (x, y, max_vx, max_vy, max_hunger, size)

	local alive = true
	local auto_move = false
	local timer = 0
	
	return{
	x = x,
	y = y,
	size = size,
	max_vx = max_vx,
	max_vy = max_vy,
	max_hunger = max_hunger,
	hunger = max_hunger,
	
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
				self.hunger = self.hunger - 1
				timer = 0
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
				
				if distance_between(mouse_x, self.x, mouse_y, self.y) > 0 then
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
	}
end