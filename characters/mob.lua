function loadMob(class, x, y)
	if class == "pawn" then
		mob = { class = "pawn", 
				location = { x = x, y = y, facing = 0 },
				stats = { health = 100, atk = 5, speed = 50 }, 
				draw = { sprite = nil, walk = nil, attack = nil },
				size = { width = 30, height = 30}, 
				status = { alive = true },
				special = { sx = x, sy = y, moving = "left", maxMove = 50 }
			}

		table.insert(mobTable, mob)
	elseif class == "nerd" then
		mob = { class = "pawn", 
				location = { x = x, y = y, facing = 0 },
				stats = { health = 300, atk = 50, speed = 350 }, 
				draw = { sprite = nil, walk = nil, attack = nil },
				size = { width = 30, height = 30}, 
				status = { alive = true },
				special = { sx = x, sy = y, moving = "left", maxMove = 10 }
			}

		table.insert(mobTable, mob)
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
	end
end

function drawMobs()
	for i=1, #mobTable do
			lg.rectangle("fill", getX(mobTable[i]), getY(mobTable[i]), getWidth(mobTable[i]), getHeight(mobTable[i]))
	end
end
