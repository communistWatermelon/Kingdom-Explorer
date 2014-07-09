local hero

function loadCharacter()
	hero = { x = 500, y = 32, speed = 100 }
end

function transitionCharacter(x, y)
	hero.x = x
	hero.y = y
end

function moveCharacter(dt)
	local tempx = hero.x result = false
	local tempy = hero.y

	if love.keyboard.isDown("left") then
		tempx = hero.x - (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.x = tempx
		end
	end
	if love.keyboard.isDown("right") then
		tempx = hero.x + (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.x = tempx
		end
	end
	if love.keyboard.isDown("up") then
		tempy = hero.y - (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.y = tempy
		end	
	end
	if love.keyboard.isDown("down") then
		tempy = hero.y + (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.y = tempy
		end	
	end
end

function drawCharacter()
	love.graphics.rectangle("fill", hero.x, hero.y, 32, 32)
end