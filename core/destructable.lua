local path = "assets/"
destructables =  { c = "rock", l = "grass" }

function placeDestructable(env, column, row)
	table.insert(destructsTable, { 
					class = destructables[env],
					location = { x = math.floor((column*32)-16) , y = math.floor((row*32)-16)},
					draw = { sprite = lg.newImage(path .. destructables[env] .. ".png") },
					size = { width = 32, height = 32},
					alive = true,
				})
end

function updateDestructables()
	local destroyed = {}

	for i=1, #destructsTable do
		if not (destructsTable[i].alive) then
			table.insert(destroyed, i)
		end
	end

	for j=#destroyed, 1, -1 do
		local dead = destructsTable[destroyed[j]]
		drop(getX(dead), getY(dead), nil, 30, 5, 5) 
		table.remove(destructsTable, destroyed[j])
	end
end

function drawDestructables()
	for i=1, #destructsTable do
		lg.draw( getAnim(destructsTable[i], "sprite"), 
			getX(destructsTable[i]), getY(destructsTable[i]), 0, 1, 1, 
			getWidth(destructsTable[i])/2, getHeight(destructsTable[i])/2)
	end
end