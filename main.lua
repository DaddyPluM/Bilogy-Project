--A simulation game where you control a cell and try to survive and grow in a microscopic environment. You can interact with other cells, consume nutrients, avoid predators, and divide into new cells. You can also evolve your cell by acquiring new traits and abilities. The game could teach you about the basic concepts of cell biology, such as organelles, metabolism, reproduction, and adaptation.
--Evolution
require "player"
require "bean"
require "rice"
require "grass"
require "data"
local camera = require "camera"

local timer = 0
data_table = {"day,grass population,rice population,bean population,rice speed,bean speed,rice range,bean range"}
day = 0
local day_timer = 0
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
box_size = 3000

mouse_x, mouse_y = love.mouse.getPosition()
win_width, win_height = love.window.getMode()


function mutate()
	return math.random(-3, 8)
end
function average(total, numbers)
	return math.floor((total/numbers) + .5)
end
function vary(x, y)
	return(math.random(math.min(x, y), math.max(x, y)) + mutate())
end
function love.load()
	ween = player(box_size/2, box_size/2, 500, 500, 10, 20, 80)
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
			table.insert(BEANS, bean("male", math.random(-100, box_size), math.random(-100, box_size), 120, 10, 12, 130))
			table.insert(BEANS, bean("female", math.random(-100, box_size), math.random(-100, box_size), 120, 10, 12, 130))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
			table.insert(GRASSES, grass(math.random(100, box_size - 20), math.random(100, box_size - 20), 10))
		end
	end
	  local function lopp(count)
		for i =1, count do
			table.insert(RICES, rice("male", math.random(100, box_size - 20), math.random(100, box_size - 20), math.random(170, 190), 14, 17, 270))
			table.insert(RICES, rice("female", math.random(100, box_size - 20), math.random(100, box_size - 20), math.random(170, 190), 14, 17, 270))
		end
	end
	lopp(4)
	loop(80)
end

function love.update(dt)
	math.randomseed(os.time() * math.random())
	day_timer = day_timer + dt
	--if work == true then
	cam:zoomTo(scale)
	timer = timer + dt
	ween:update(dt)
	mouse_x, mouse_y = love.mouse.getPosition()
	cursor.x = mouse_x + (ween.x - (win_width/2))
	cursor.y = mouse_y + (ween.y - (win_height/2))
	if day_timer >= 3 then
		day = day + 1
		record()
		day_timer = 0
	end
	if day == 80 then
		data.save("test11", table.concat(data_table, "\n"))
		love.event.quit()
	end
	for index, grass in pairs(GRASSES) do
		grass:update(dt)
		if grass.alive == false then
			table.remove(GRASSES, index)
		end
	end
	for index_b, bean in pairs(BEANS) do
		bean:update(dt)
		if bean.alive == false then
			table.remove(BEANS, index_b)
		end
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
			if distance_between(bean.x, bean2.x, bean.y, bean2.y) <= bean.range * 2 and bean.search == true and bean2.gender == "female" and bean.gender == "male" and bean2.following == false then
				bean:follow(bean2.x, bean2.y)
				bean2:follow(bean.x, bean.y)
			end
			if distance_between(bean.x, bean2.x, bean.y, bean2.y) <= 3 and bean.search == true and bean2.gender == "female" and bean.gender == "male" then
				bean2:reproduce({max_vx = bean.max_vx, max_vy = bean.max_vy, size = bean.size, range = bean.range, max_speed = bean.max_speed})
				bean:reproduce()
				bean.search = false
			end
		end
		for index_g, grass in pairs(GRASSES) do
			if distance_between(bean.x, grass.x, bean.y, grass.y) <= bean.range and bean.hunger < bean.max_hunger then
				bean:follow(grass.x, grass.y)
			end
			if distance_between(bean.x, grass.x, bean.y, grass.y) <= bean.size + 2 and bean.hunger < bean.max_hunger then
				bean:eat()
				grass:kill()
				table.remove(GRASSES, index_g)
			end
		end
	end
	local function find_nearest_bean(range, x, y)
		local t = {}
		local nearest_bean
		local min_distance = range
		for index, bean in pairs(BEANS) do
			if distance_between(x, bean.x, y, bean.y) < min_distance then
				table.insert(t, bean)
			end
		end
		for i, v in pairs(t) do
			if distance_between(x, v.x, y, v.y) < min_distance then
				min_distance = distance_between(x, v.x, y, v.y)
				nearest_bean = v
			end
		end
		return nearest_bean
	end
	for index_r, rice in pairs(RICES) do
		rice:update(dt)
		if rice.alive == false then
			rice:kill()
			table.remove(RICES, index_r)
		end
		for index_r2, rice2 in pairs(RICES) do
			if distance_between(rice.x, rice2.x, rice.y, rice2.y) <= rice.range * 2 and rice.search == true and rice2.gender == "female" and rice.gender == "male" and rice2.following == false then
				rice:follow(rice2.x, rice2.y)
				rice2:follow(rice.x, rice.y)
			end
			if (distance_between(rice.x, rice2.x, rice.y, rice2.y) <= rice.size - 2 or distance_between(rice2.x, rice.x, rice2.y, rice.y) <= rice2.size - 2) and rice.search == true and rice2.gender == "female" and rice.gender == "male" then
				rice2:reproduce({max_speed = rice.max_speed, size = rice.size, range = rice.range, max_hunger = rice.max_hunger})
				rice:reproduce()
				rice.search = false
			end
		end
		if rice.hunger < rice.max_hunger then
			local b = find_nearest_bean(rice.range, rice.x, rice.y)
			if b ~= nil then
				rice:follow(b.x, b.y)
				b.search = false
			end
		end
		for index_b, bean in pairs(BEANS) do
			if distance_between(rice.x, bean.x, rice.y, bean.y) <= rice.size + 2 or distance_between(bean.x, rice.x, bean.y, rice.y) <= bean.size + 2 and rice.hunger < rice.max_hunger then
				rice:eat()
				bean:kill()
				table.remove(BEANS, index_b)
				rice.following = false
			end
			if distance_between(bean.x, rice.x, bean.y, rice.y) <= bean.range then
				bean:run(rice.x, rice.y)
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
	--local saved = false
end

function love.draw()
	love.graphics.setBackgroundColor(.1, 0, .1)
	cam:attach()
		--love.graphics.print(ween.hunger)
		love.graphics.setColor(1, 1, 1)
		for index, grass in pairs(GRASSES) do
			if distance_between(ween.x, grass.x, ween.y, grass.y) <= (win_width / scale) + 10 then
				grass:draw()
			end
		end
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
		--ween:draw()
	cam:detach()
	love.graphics.printf("RED " .. tostring(#GRASSES), 0, 0, win_width, "center")
	love.graphics.printf("DAY " .. tostring(day), 0, 40, win_width, "center")
	love.graphics.printf("WHITE " .. tostring(#RICES), 0, 0, win_width, "left")
	love.graphics.printf("GREEN " .. tostring(#BEANS), 0, 0, win_width, "right")
end

function distance_between(x1, x2, y1, y2)
	return math.sqrt(((x2 - x1) ^ 2) + ((y2 - y1) ^ 2))
end

function angle_between(x1, x2, y1, y2) -- Math formula for angle between two points ; Player - mouse
       return math.atan2( y1 - y2, x1 - x2) + math.pi -- Added math.pi = 180 degrees
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
function record()
	local tab = {}
	local rice_total_speed = 0
	--local rice_pop = #RICES
	local rice_avg_speed = 0
	local rice_avg_range = 0
	local rice_total_range = 0
	local bean_total_speed = 0
	local bean_total_range = 0
	--local bean_pop = #BEANS
	local bean_avg_range = 0
	local bean_avg_speed = 0
	--table.insert(tab,"day,ricespeed,beanspeed,ricerange,beanrange")
	for i,v in pairs(RICES) do
		rice_total_speed = rice_total_speed + v.max_speed
		rice_total_range = rice_total_range + v.range
	end
	for i,v in pairs(BEANS) do
		bean_total_speed = bean_total_speed + v.max_speed
		bean_total_range = bean_total_range + v.range
	end
	rice_avg_speed = average(rice_total_speed, tonumber(#RICES))
	rice_avg_range = average(rice_total_range, tonumber(#RICES))
	bean_avg_speed = average(bean_total_speed, #BEANS)
	bean_avg_range = average(bean_total_range, tonumber(#BEANS))
	table.insert(data_table, tostring(day) .. "," .. tostring(#GRASSES) .. "," .. tostring(#RICES) .. "," .. tostring(#BEANS) .. "," .. tostring(rice_avg_speed) .. "," .. tostring(bean_avg_speed) .. "," .. tostring(rice_avg_range) .. "," .. tostring(bean_avg_range))
	local z = table.concat(tab, "\n")
	--data.save("test", z)
	--saved = true
	--love.event.quit()
end