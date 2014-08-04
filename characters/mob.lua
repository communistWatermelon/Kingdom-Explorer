function loadMob()
	mob = { class = "pawn", 
			location = { x = 200, y = 300, facing = 0 },
			stats = { health = 100, atk = 5, speed = 50 }, 
			draw = { sprire = nil, walk = nil, attack = nil },
			size = { width = 30, height = 30}, 
			status = { alive = true },
			special = { sx = 200, sy = 300, moving = "left", maxMove = 50 }
		}
end

function checkCollisions(mobs)
	herol = getLocation(hero)
	heros = getSize(hero)
	mobl = getLocation(mob)
	mobs = getSize(mob)

	return mobl.x < herol.x + heros.width and
		herol.x < mobl.x + mobs.width and
		mobl.y < herol.y + heros.height and
		herol.y < mobl.y + mobs.height and mob.status.alive
end

function moveMob(dt)
	local move = mob.special.moving
	if move == "left" then
		if ((getX(mob) - mob.special.sx) < mob.special.maxMove) then
			setX(mob, getX(mob) + (dt * getSpeed(mob)))
		else
			mob.special.moving = "right"
		end
	elseif move == "right" then
		if ((getX(mob) - mob.special.sx) > -mob.special.maxMove) then
			setX(mob, getX(mob) - (dt * getSpeed(mob)))
		else
			mob.special.moving = "left"
		end
	end
end

function drawMobs(mobs)
	if getHealth(mob) > 0 then
		lg.rectangle("fill", getX(mob), getY(mob), getWidth(mob), getHeight(mob))
	end
end
