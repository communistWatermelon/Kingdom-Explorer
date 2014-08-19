function loadMob(class, x, y)
	if class == "pawn" then
		mob = { class = class, 
				location = { x = x, y = y, facing = 0 },
				stats = { health = 100, atk = 5, speed = 50 }, 
				draw = { sprite = nil, walk = nil, attack = nil },
				size = { width = 30, height = 30}, 
				status = { alive = true },
				special = { sx = x, sy = y, moving = "left", maxMove = 50 }
			}
	elseif class == "nerd" then
		mob = { class = class, 
				location = { x = x, y = y, facing = 0 },
				stats = { health = 300, atk = 50, speed = 350 }, 
				draw = { sprite = nil, walk = nil, attack = nil },
				size = { width = 30, height = 30}, 
				status = { alive = true },
				special = { sx = x, sy = y, moving = "left", maxMove = 10 }
			}
	elseif class == "fire" then
		mob = { class = class, 
				location = { x = x, y = y, facing = 0 },
				stats = { health = 30, atk = 15, speed = 80 }, 
				draw = { sprite = nil, walk = nil, attack = nil, projectile = lg.newImage("items/bow/arrow.png") },
				size = { width = 30, height = 30}, 
				status = { alive = true },
				special = { sx = x, sy = y, moving = "right", maxMove = 80 },
				timer = 0,
				target = { heroTable }
			}
	end

	table.insert(mobTable, mob)
end

function mobAttack(mb)
	if getClass(mb) == "fire" then
		local mobLoc = getLocation(mb)
		local herLoc = getLocation(hero)
		local dist = math.dist(mobLoc.x, mobLoc.y, herLoc.x, herLoc.y)
		if dist < 150 and mb.timer == 0 then
			local facing = math.angle(mobLoc.x, mobLoc.y, herLoc.x, herLoc.y)
			fireProjectile(mb, mobLoc.x, mobLoc.y, facing+(math.pi/2), getAttack(mb), 150, getAnimWidth(mb, "projectile"), getAnimHeight(mb, "projectile"), true)
		end

		mb.timer = mb.timer + 1

		if mb.timer == 120 then
			mb.timer = 0
		end
	end
end


function moveMobs(dt)
	for i=1, #mobTable do
		local move = mobTable[i].special.moving
		if move == "left" then
			if ((getX(mobTable[i]) - mobTable[i].special.sx) < mobTable[i].special.maxMove) then
				setX(mobTable[i], getX(mobTable[i]) + (dt * getSpeed(mobTable[i])))
			else
				mobTable[i].special.moving = "right"
			end
		elseif move == "right" then
			if ((getX(mobTable[i]) - mobTable[i].special.sx) > -mobTable[i].special.maxMove) then
				setX(mobTable[i], getX(mobTable[i]) - (dt * getSpeed(mobTable[i])))
			else
				mobTable[i].special.moving = "left"
			end
		end
		mobAttack(mobTable[i])
	end
end

function drawMobs()
	for i=1, #mobTable do
			lg.rectangle("fill", getX(mobTable[i]), getY(mobTable[i]), getWidth(mobTable[i]), getHeight(mobTable[i]))
	end
end
