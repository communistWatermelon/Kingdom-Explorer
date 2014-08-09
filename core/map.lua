

local tileW, tileH, tileset, quads, tileTable, mapWidth, mapHeight
local quadType = {}
local scrollSpeed = 100

function newMap(tileWidth, tileHeight, tilesetPath, tileString, quadInfo, mobs)
	mapX = 0
	mapY = 0
	tileW = tileWidth
	tileH = tileHeight
	tileset = lg.newImage(tilesetPath)

	local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()

	quads = {}
	tileTable = {}

	quadType = quadInfo
	for _, info in ipairs(quadInfo) do
		quads[info[1]] = lg.newQuad(info[2], info[3], tileW,  tileH, tilesetW, tilesetH)
	end

	local width = #(tileString:match("[^\n]+"))

	for x = 1, width, 1 do tileTable[x] = {} end

	local x, y = 1, 1
	for row in tileString:gmatch("[^\n]+") do
		assert(#row == width, 'Map is not aligned: width of row ' .. tostring(y) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
		x = 1
		for tile in row:gmatch(".") do
			tileTable[x][y] = tile
			x = x + 1
		end
		y= y + 1
	end
	mapWidth = (x - 1) * tileW
	mapHeight = (y - 1) * tileH

	local tempMobX, tempMobY = 100, 100
	for i=1, #mobs do
		for j=1, mobs[i][2] do
			loadMob(mobs[i][1], tempMobX, tempMobY)
			tempMobX = tempMobX + 100
			tempMobY = tempMobY + 100
		end
	end
end

function mouseMoveMap(dt, x, y, mX, mY)
	scrollSpeed = getSpeed(hero)
	local tempLoc = getLocation(hero)
	local tempX, tempY = tempLoc.x, tempLoc.y
	local tempx = mapX
	local tempy = mapY

	if tempY < (mapHeight / 2) - (mapHeight / 8)  or tempY > (mapHeight - (mapHeight / 2) + (mapHeight / 8)) then
		scrollSpeed = scrollSpeed - 30
	elseif tempX < (mapWidth / 2) - (mapWidth / 8)  or tempX > (mapWidth - (mapWidth / 2) + (mapWidth / 8)) then
		scrollSpeed = scrollSpeed - 30
	end

	if (math.abs(x) > 5) then
		if math.abs(x) < 30 then
			modx = 0.3
		else
			modx = 1
		end

		if mX == "right" then
			if x < 0 then
				tempx = mapX + (scrollSpeed * dt * modx)
				if mapX < 0 then
					mapX = tempx
				end
			end
		elseif mX == "left" then
			if x > 0 then 
				tempx = mapX - (scrollSpeed * dt * modx)
				if 0 < (mapWidth + mapX - lg.getWidth()) then
					mapX = tempx
				end			
			end
		end
	end

	if(math.abs(y) > 5) then
		if math.abs(y) < 30 then
			mody = 0.3
		else
			mody = 1
		end

		if mY == "down" then
			if y < 0 then 
				tempy = mapY + (scrollSpeed * dt * mody)
				if mapY < 0 then
					mapY = tempy
				end
			end
		elseif mY == "up" then
			if y > 0 then 
				tempy = mapY - (scrollSpeed * dt * mody)
				if 0 < (mapHeight + mapY - lg.getHeight()) then
					mapY = tempy
				end
			end 
		end
	end
end

function transitionMap(x, y)
	mapX = -(x - (lg.getWidth() / 2))
	mapY = -(y - (lg.getHeight() / 2))
end

function shiftMap(x, y)
	local tempx, tempy

	tempx = mapX + x
	tempy = mapY + y

	if tempx > 0 then
		mapX = tempx
	else
		mapX = 0
	end

	if tempy > 0 then
		mapY = tempy
	else
		mapY = 0
	end
end

function moveMap(dt, mX, mY)
	scrollSpeed = getSpeed(hero)
	local loc = getLocation(hero)

	if loc.x < (mapHeight / 2) - (mapHeight / 8)  or loc.y > (mapHeight - (mapHeight / 2) + (mapHeight / 8)) then
		scrollSpeed = scrollSpeed - 30
	elseif loc.x < (mapWidth / 2) - (mapWidth / 8)  or loc.y > (mapWidth - (mapWidth / 2) + (mapWidth / 8)) then
		scrollSpeed = scrollSpeed - 30
	end

	if mY == "up" then
		if mapY < 0 then
			mapY = mapY + math.floor(dt * scrollSpeed)
		end
	elseif mY == "down" then
		if 0 < (mapHeight + mapY - lg.getHeight()) then
			mapY = mapY - math.floor(dt * scrollSpeed)
		end
	end

	if mX == "right" then
		if 0 < (mapWidth + mapX - lg.getWidth()) then
			mapX = mapX - math.floor(dt * scrollSpeed)
		end
	elseif mX == "left" then
		if mapX < 0 then
			mapX = mapX + math.floor(dt * scrollSpeed)
		end
	end
end

function transition(direction, x, y, map)
	tx, ty = findSpawn(x, y, direction)
	setLocation(hero, tx, ty)
	loadMap('/maps/' .. map)
	transitionMap(tx, ty)
end

function findSpawn(x, y, direction)

	if direction == "u" then
		x = x - 48
		y = (mapHeight - y) - 48
	elseif direction == "d" then
		x = x - 48
		y = (mapHeight - y) - 48		
	elseif direction == "l" then
		x = (mapWidth - x) - 48
		y =  y - 48
	elseif direction == "r" then
		x = (mapWidth - x) -- 32
		y =  y - 48
	end

	local fx, fy = math.floor(x / tileW), math.floor(y / tileH)
	local cx, cy = math.ceil(x / tileW), math.ceil(y / tileH)

	if cx <= 0 then
		cx = cx + 1
	end

	if fx <= 0 then
		fx = fx + 1
	end

	if cy <= 0 then
		cy = cy + 1
	end	

	if fy <= 0 then
		fy = fy + 1
	end	


	corners = { 
		tileTable[fx][fy],
		tileTable[cx][fy],
		tileTable[cx][cy],
		tileTable[fx][cy]
	}

	local spawn = ""

	for key,value in ipairs(corners) do
		for i=1, #quadType do
			if (quadType[i][1] == value) then
				spawn = quadType[i][1]
			end
		end
	end

	return (cx*tileW)+16, (cy*tileH)+16
end

function checkTile(x, y, projectile)
	x = x + 16
	y = y + 16

	local fx, fy = math.floor(x / tileW), math.floor(y / tileH)
	local cx, cy = math.ceil(x / tileW), math.ceil(y / tileH)

	corners = { 
		tileTable[fx][fy],
		tileTable[cx][fy],
		tileTable[cx][cy],
		tileTable[fx][cy]
	}

	local result = true
	local teleport = 0

	for key,value in ipairs(corners) do
		for i=1, #quadType do
			if (quadType[i][1] == value) then
				result = quadType[i][4]
				teleport = quadType[i][1]

				if not projectile then
					if teleport == "U" then
						transition('u', x, y, quadType[i][4])
						return
					elseif teleport == "D" then
						transition('d', x, y, quadType[i][4])
						return
					elseif teleport == "R" then	
						transition('r', x, y, quadType[i][4])
						return
					elseif teleport == "L" then
						transition('l', x, y, quadType[i][4])
						return
					end

				end
				if (not result) then
					return result
				end

			end
		end
	end

	return result
end

function loadMap(path)
	local f = lf.load(path)
	f()
end

function drawMap()
	for columnIndex, column in ipairs(tileTable) do
		for rowIndex, char in ipairs(column) do 
			local mapW, mapH = (columnIndex - 1) * tileW, (rowIndex - 1) * tileH
			lg.draw(tileset, quads[char], mapW, mapH )
		end
	end
end
