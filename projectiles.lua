function projectileCollison()
	
end

function fireProjectile(type, x, y, direction, speed, width, height)
	local modx, mody = 0, 0

	local dx, dy = speed * math.cos(facing - (math.pi / 2)), speed * math.sin(facing - (math.pi / 2))
	table.insert(projectiles, {x = x, y = y, dx = dx, dy = dy, facing = facing})
end

function animateProjectile(item, x, y, facing, )
	for i, v in ipairs (arrow) do
		v.x = v.x + v.dx * dt
		v.y = v.y + v.dy * dt
	end
end