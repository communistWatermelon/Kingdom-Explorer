function projectileCollison()
	local collided = false
	local collision = 0
	local target
	local hit
	local deadPro = {}

	for i=1, #projectiles do 
		for j=1, #projectiles[i].target do
			target = projectiles[i].target[j]
			collided, collision = checkCollisionsTable(projectiles[i], target)

			if collided then
				hit = target[collision]

				if projectiles[i].oneHit then
					table.insert(deadPro, i)
				end

				changeHealth(hit, (-getAttack(projectiles[i])))
			end
		end
	end

	checkProjectileStatus(deadPro)
end

function checkProjectileStatus(deadPro)
	if #projectiles > 0 then
		for i=1, #projectiles do
			local x, y = getX(projectiles[i]), getY(projectiles[i])
			
			if x > (lg.getWidth()+math.abs(mapX)) or y > (lg.getHeight()+math.abs(mapY)) or x < math.abs(mapX) or y < math.abs(mapY) then
				table.insert(deadPro, i)
			end

			if not checkTile(x, y, true) then
        		table.insert(deadPro, i)
        	end
		end

		for j=#deadPro, 1, -1 do
			table.remove(projectiles, deadPro[j])
		end
	end
end

function fireProjectile(item, x, y, direction, attack, speed, width, height, oneHit)
	local modx, mody = 0, 0

	local dx, dy = speed * math.cos(direction - (math.pi / 2)), speed * math.sin(direction - (math.pi / 2))
	table.insert(projectiles, { class = item, 
								location = { x = x, y = y, facing = direction }, 
								stats = { atk = attack, speed = speed },
								size = {width = width, height = height},
								target = item.target,
								dx = dx, dy = dy, oneHit = oneHit
							})
	--print(item.target)
	--print(hero)
end

function updateProjectiles(dt)
	for i, v in ipairs (projectiles) do
		setX(v, getX(v) + (v.dx * dt))
		setY(v, getY(v) + (v.dy * dt))
	end

	projectileCollison()
end

function drawProjectiles()
	for i=1, #projectiles do
		lg.draw( getAnim(getClass(projectiles[i]), "projectile"), 
			getX(projectiles[i]), getY(projectiles[i]), getFacing(projectiles[i]), 1, 1, 
			getWidth(projectiles[i])/2, getHeight(projectiles[i])/2)
	end
end
