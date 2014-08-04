local arrow = {}
-- each item should have its own lua file in the items folder
function loadBow()
	bow = { atk = 1, speed = 300, sprite = lg.newImage("items/bow.png"), arrow = lg.newImage("items/arrow.png")}
	local img = love.graphics.newImage("items/bowAnim.png")
   	bowAnim = newAnimation(img, 128, 128, 0.08, 9)
   	bowAnim:setMode("once")
   	bowAnim:stop()
end

function useBow(x, y)
	fireArrow(x, y)
	bowAnim:play()
	bowAnim:reset()
end

function fireArrow(x, y)
	local facing = getFacing()

	local modx = 0
	local mody = 0

	if facing == 0 then
		modx = -10
		mody = 16
	elseif facing < 0 then
		modx = 16
		mody = 10
	elseif facing > 0 and facing < 3 then
		modx = -16
		mody = -10
	elseif facing > 3 then
		modx = 10
		mody = -16
	end

	local dx, dy = bow.speed * math.cos(facing - (math.pi/2)), bow.speed * math.sin(facing - (math.pi / 2))
	table.insert( arrow, { x = (x+modx), y = (y+mody), dx = dx, dy = dy, facing = facing - (math.pi / 2)} )
end

function BowCollision(x, y)
	local facing = getFacing()
	local mobx, moby = getMobLocation()
	local bowx, bowy
	local boww, bowh

	if facing == 0 then
		bowx = x - 5
		bowy = y
		boww = 5
		bowh = 32 
	elseif facing < 0 then
		bowx = x
		bowy = y + 5
		boww = 32
		bowh = 5 
	elseif facing > 0 and facing < 3 then
		bowx = x
		bowy = y - 5
		boww = 32
		bowh = 5 
	elseif facing > 3 then
		bowx = x + 5
		bowy = y
		boww = 5
		bowh = 32 
	end

 	for a,b in ipairs(arrow) do
		if mobx < b.x + boww and
			b.x < mobx + mobw and
			moby < b.y + bowh and
			b.y < moby + mobh then
				changeMobHealth(-bow.atk)
				table.remove(arrow, a)
        end


        if b.x > lg.getWidth() or b.y > lg.getHeight() or b.x < 1 or b.y < 1 then
        	print("arrow offscreen!")
        	table.remove(arrow, a)
        end

        if not checkTile(b.x, b.y) then
        	table.remove(arrow, a)
        end
	end

end

function animateBow(x, y)
	bowAnim:draw(x, y, getFacing(), 1, 1, bowAnim:getWidth()/2, bowAnim:getHeight()/2)
	for i, v in ipairs (arrow) do
		lg.draw( bow.arrow, v.x, v.y, v.facing)
	end

	--BowCollision(x, y)
end

function updateBow(dt)
	bowAnim:update(dt)
	for i, v in ipairs ( arrow ) do
		v.x = v.x + v.dx * dt
		v.y = v.y + v.dy * dt
	end

	tempx, tempy = getLocation()
	BowCollision(tempx, tempy)
end

function drawBow(x, y)
	lg.draw(bow.sprite, x-8, y)
end


