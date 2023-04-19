--A simulation game where you control a cell and try to survive and grow in a microscopic environment. You can interact with other cells, consume nutrients, avoid predators, and divide into new cells. You can also evolve your cell by acquiring new traits and abilities. The game could teach you about the basic concepts of cell biology, such as organelles, metabolism, reproduction, and adaptation.
--Evolution
require "player"
require "bean"
require "rice"
local camera = require "camera"

local cam = camera()
local timer = 0
BEANS = {}
RICES = {}
create = true
mob_count = 1
rice_count = 2
cursor = {}
math.randomseed(os.time() * math.random())

mouse_x, mouse_y = love.mouse.getPosition()
win_width, win_height = love.window.getMode()

function love.load()
	--ween = player(win_width / 2, win_height / 2, 200, 200, 10, 20)
	--table.insert(BEANS, bean(math.random(100, 700), math.random(100, 500), math.random(-5, 5), math.random(-5, 5), math.random(10, 15)))
	table.insert(BEANS, bean(200, 300, 3, 3, 10))
	--table.insert(RICES, rice(100, 500, 200, 200, 10, 15))
	--table.insert(RICES, rice(500, 500, 200, 200, 10, 15))
	table.insert(RICES, rice(800, 700, 200, 200, 10, 15))
	--table.insert(RICES, rice(1000, 500, 200, 200, 10, 15))
	cursor.y = mouse_y
end

function love.update(dt)
	timer = timer + dt
	if mob_count < 100 and create == true then
		table.insert(BEANS, bean(math.random(100, 1500), math.random(100, 1000), math.random(-5, 5), math.random(-5, 5), math.random(10, 15)))
		mob_count = mob_count + 1
		table.insert(BEANS, bean(math.random(100, 1500), math.random(100, 1000), math.random(-5, 5), math.random(-5, 5), math.random(10, 15)))
		mob_count = mob_count + 1
		table.insert(BEANS, bean(math.random(100, 1500), math.random(100, 1000), math.random(-5, 5), math.random(-5, 5), math.random(10, 15)))
		mob_count = mob_count + 1
	elseif mob_count >= 100 then
		create = false
	end
	--ween:update(dt)
	mouse_x, mouse_y = love.mouse.getPosition()
	--[[cursor.x = mouse_x + (ween.x - 400)
	cursor.y = mouse_y + (ween.y - 300)]]
	for index, bean in pairs(BEANS) do
		bean:update(dt)
		--[[if distance_between(ween.x, bean.x, ween.y, bean.y ) <= ween.size + 1 then
			ween:eat()
			bean:kill()
			table.remove(BEANS, index)
			mob_count = mob_count - 1
		end]]
	end
	for index_r, rice in pairs(RICES) do
		rice:update(dt)
		if rice.hunger <= 0 then
			table.remove(RICES, index_r)
		end
		for index_b, bean in pairs(BEANS) do
			if distance_between(rice.x, bean.x, rice.y, bean.y) <= 40 and rice.hunger < 10 then
				rice:follow(bean.x, bean.y)
      elseif distance_between(rice.x, bean.x, rice.y, bean.y) <= 80 and rice.hunger < 10 then
        rice:follow(bean.x, bean.y)
			end
			if distance_between(rice.x, bean.x, rice.y, bean.y) <= rice.size + 2 and rice.hunger < 10 then
				rice:eat()
				rice.following = false
				bean:kill()
				table.remove(BEANS, index_b)
				mob_count = mob_count - 1
			end
		end
	end
	--cam:lookAt(ween.x, ween.y)
end

function love.draw()
	--cam:attach()
		--love.graphics.print(ween.hunger)
		love.graphics.setColor(1, 1, 1)
		for index, bean in pairs(BEANS) do
      --if distance_between(RICES[1].x, bean.x, RICES[1].y, bean.y) <= 100 then
        bean:draw()
      --end
		end
		for index, rice in pairs(RICES) do
			rice:draw()
		end
		--ween:draw()
	--cam:detach()
	love.graphics.print(mob_count--[[RICES[1].follow_x]])
end

function distance_between(x1, x2, y1, y2)
	return math.sqrt(((x2 - x1) ^ 2) + ((y2 - y1) ^ 2))
end

function angle_between(x1, x2, y1, y2) -- Math formula for angle between two points ; Player - mouse
       return math.atan2( y1 - y2, x1 - x2) + math.pi -- Added math.pi = 180 degrees
end

function love.keypressed(key)
	if key == "q" then
		BEANS[1]:reproduce()
	end
  if key == "escape" then
    love.event.quit()
  end
end

print(win_width)