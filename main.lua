--A simulation game where you control a cell and try to survive and grow in a microscopic environment. You can interact with other cells, consume nutrients, avoid predators, and divide into new cells. You can also evolve your cell by acquiring new traits and abilities. The game could teach you about the basic concepts of cell biology, such as organelles, metabolism, reproduction, and adaptation.
--Evolution
require "player"
require "bean"
require "rice"
require "grass"
local camera = require "camera"

local timer = 0
BEANS = {}
RICES = {}
GRASSES = {}
mob_count = 1
rice_count = 1
cursor = {}
local scale = 0.2
local cam = camera()
local work = false
math.randomseed(os.time() * math.random())
local thread_code
box_size = 2000

mouse_x, mouse_y = love.mouse.getPosition()
win_width, win_height = love.window.getMode()


function mutate()
	return math.random(-5, 11)
end
function vary(x, y)
	return(math.random(math.min(x, y), math.max(x, y)) + mutate())
end
function love.load()
	ween = player(box_size/2, box_size/2, 300, 300, 10, 20, 80)
	--table.insert(BEANS, bean(math.random(100, 700), math.random(100, 500), math.random(-5, 5), math.random(-5, 5), math.random(10, 15)))
	--table.insert(BEANS, bean(200, 300, 3, 3, 10))
	--[[table.insert(RICES, rice(100, 500, 200, 200, 10, 15))
	table.insert(RICES, rice(500, 500, 200, 200, 10, 15))
	table.insert(RICES, rice(800, 700, 200, 200, 10, 15))]]
	--[[table.insert(RICES, rice("male", 100, 500, 200, 200, 12, 15, 120))
	table.insert(RICES, rice("female", 130, 500, 200, 200, 12, 15, 120))
	table.insert(RICES, rice("female", 130, 500, 200, 200, 12, 15, 120))
	table.insert(RICES, rice("female", 200, 600, 200, 200, 12, 15, 120))
	table.insert(RICES, rice("male", math.random(100, 1900), math.random(100, 1900), 200, 200, 12, 15, 120))
	table.insert(RICES, rice("female", math.random(100, 1900), math.random(100, 1900), 200, 200, 12, 15, 120))]]
	table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
	--[[table.insert(RICES, rice("female", 200, 500, 200, 200, 12, 15, 80))
	table.insert(RICES, rice("male", 110, 500, 200, 200, 12, 15, 80))
	table.insert(RICES, rice("male", 120, 500, 200, 200, 12, 15, 80))
	table.insert(RICES, rice("male", 100, 500, 200, 200, 12, 15, 80))
	table.insert(RICES, rice("female", 130, 500, 200, 200, 12, 15, 80))
	table.insert(RICES, rice("female", 200, 500, 200, 200, 12, 15, 80))
	table.insert(RICES, rice("male", 110, 500, 200, 200, 12, 15, 80))
	table.insert(RICES, rice("male", 120, 500, 200, 200, 12, 15, 80))
	table.insert(RICES, rice("male", 100, 500, 200, 200, 12, 15, 80))
	table.insert(RICES, rice("female", 130, 500, 200, 200, 12, 15, 80))
	table.insert(RICES, rice("female", 200, 500, 200, 200, 12, 15, 80))
	table.insert(RICES, rice("male", 110, 500, 200, 200, 12, 15, 80))
	table.insert(RICES, rice("male", 120, 500, 200, 200, 12, 15, 80))]]
	cursor.y = mouse_y
	cursor.x = mouse_x
	function pick_gender()
		local a = math.random(1, 2)
		if a == 1 then
			return "male"
		elseif a == 2 then
			return "female"
		end
	end
	local function loop(count)
		for i=1, count do
			table.insert(BEANS, bean(pick_gender(), math.random(-100, box_size), math.random(-100, box_size), math.random(-5, 185), math.random(-5, 185), 10, math.random(10, 15)))
			table.insert(BEANS, bean(pick_gender(), math.random(-100, box_size), math.random(-100, box_size), math.random(-5, 185), math.random(-5, 185), 10, math.random(10, 15)))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
			table.insert(GRASSES, grass(math.random(100, 1900), math.random(100, 1900), 10))
		end
	end
	local function lopp(count)
		for i =1, count do
			table.insert(RICES, rice("male", math.random(100, 1900), math.random(100, 1900), 200, 200, 12, 15, 120))
			table.insert(RICES, rice("female", math.random(100, 1900), math.random(100, 1900), 200, 200, 12, 15, 120))
		end
	end
	lopp(5)
	loop(100)
end

function love.update(dt)
	--if work == true then
	cam:zoomTo(scale)
	timer = timer + dt
	ween:update(dt)
	mouse_x, mouse_y = love.mouse.getPosition()
	cursor.x = mouse_x + (ween.x - (win_width/2))
	cursor.y = mouse_y + (ween.y - (win_height/2))
	for index, grass in pairs(GRASSES) do
		grass:update(dt)
		if grass.alive == false then
			table.remove(GRASSES, index)
		end
	end
	for index_b, bean in pairs(BEANS) do
		bean:update(dt)
		--[[if distance_between(ween.x, bean.x, ween.y, bean.y) <= 80 then
			bean:run(ween.x, ween.y)
		end
		if distance_between(ween.x, bean.x, ween.y, bean.y ) <= ween.size + 1 then
			ween:eat()
			bean:kill()
			table.remove(BEANS, index_b)
			mob_count = mob_count - 1
		end]]
		for index_b2, bean2 in pairs(BEANS) do
			if distance_between(bean.x, bean2.x, bean.y, bean2.y) <=500 and bean.search == true and bean2.gender == "female" and bean.gender == "male" and bean2.following == false --[[and bean2.hunger == max_hunger]] then
				bean:follow(bean2.x, bean2.y)
				bean2:follow(bean.x, bean.y)
			end
			if distance_between(bean.x, bean2.x, bean.y, bean2.y) <= 3 and bean.search == true and bean2.gender == "female" and bean.gender == "male" then
				bean2:reproduce({max_vx = bean.max_vx, max_vy = bean.max_vy, size = bean.size})
				bean:reproduce()
				bean.search = false
			end
		end
		for index_g, grass in pairs(GRASSES) do
			if distance_between(bean.x, grass.x, bean.y, grass.y) <= 80 and bean.hunger < bean.max_hunger then
				bean:follow(grass.x, grass.y)
			end
			if distance_between(bean.x, grass.x, bean.y, grass.y) <= bean.size + 2 then
				bean:eat()
				grass:kill()
				table.remove(GRASSES, index_g)
			end
		end
	end
	for index_r, rice in pairs(RICES) do
		rice:update(dt)
		if rice.alive == false then
			rice:kill()
		end
		for index_r2, rice2 in pairs(RICES) do
			if distance_between(rice.x, rice2.x, rice.y, rice2.y) <= 1000 and rice.search == true and rice2.gender == "female" and rice.gender == "male" and rice2.hunger >= rice2.max_hunger - 2 and rice2.following == false then
				rice:follow(rice2.x, rice2.y)
				rice2:follow(rice.x, rice.y)
			end
			if (distance_between(rice.x, rice2.x, rice.y, rice2.y) <= rice.size - 2 or distance_between(rice2.x, rice.x, rice2.y, rice.y) <= rice2.size - 2) and rice.search == true and rice2.gender == "female" and rice.gender == "male" then
				rice2:reproduce({max_vx = rice.max_vx, max_vy = rice.max_vy, size = rice.size, range = rice.range})
				rice:reproduce()
				rice.search = false
			end
		end
		for index_b, bean in pairs(BEANS) do
			if distance_between(rice.x, bean.x, rice.y, bean.y) <= rice.range/2 and rice.hunger < rice.max_hunger then
				rice:follow(bean.x, bean.y)
				bean:run(rice.x, rice.y)
				bean.search = false
			elseif distance_between(rice.x, bean.x, rice.y, bean.y) <= rice.range and rice.hunger < rice.max_hunger then
				rice:follow(bean.x, bean.y)
				bean:run(rice.x, rice.y)
				bean.search = false
			end
			if distance_between(rice.x, bean.x, rice.y, bean.y) <= rice.size + 2 or distance_between(bean.x, rice.x, bean.y, rice.y) <= bean.size + 2 and rice.hunger < rice.max_hunger then
				rice:eat()
				bean:kill()
				table.remove(BEANS, index_b)
				rice.following = false
			end
		end
	end
	cam:lookAt(ween.x, ween.y)
	--[[end
	fps = love.timer.getFPS()
	--print(win_width / scale)
	if fps < 45 then
		work = false
	else
		work = true
	end]]
end

function love.draw()
	cam:attach()
		--love.graphics.print(ween.hunger)
		love.graphics.setColor(1, 1, 1)
		for index, bean in pairs(BEANS) do
			if distance_between(ween.x, bean.x, ween.y, bean.y) <= (win_width / scale) + 10 then
				bean:draw()
			end
		end
		for index, rice in pairs(RICES) do
			if distance_between(ween.x, rice.x, ween.y, rice.y) <= (win_width / scale) + 10 then
				rice:draw()
			end
		end
		for index, grass in pairs(GRASSES) do
			if distance_between(ween.x, grass.x, ween.y, grass.y) <= (win_width / scale) + 10 then
				grass:draw()
			end
		end
		--ween:draw()
	cam:detach()
	love.graphics.print(#GRASSES--[[#BEANS + #RICES]])
end

function distance_between(x1, x2, y1, y2)
	return math.sqrt(((x2 - x1) ^ 2) + ((y2 - y1) ^ 2))
end

function angle_between(x1, x2, y1, y2) -- Math formula for angle between two points ; Player - mouse
       return math.atan2( y1 - y2, x1 - x2) + math.pi -- Added math.pi = 180 degrees
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end

function love.quit()
	RICES = {}
	BEANS = {}
end
function love.wheelmoved(x, y)
		scale = scale + y/10
		
	if scale < 0.2 then
		scale = 0.2
	elseif scale > 2 then
		scale = 2
	end
end