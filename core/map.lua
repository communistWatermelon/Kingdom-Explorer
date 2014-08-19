local tileW, tileH, tileset, quads, tileTable, mapWidth, mapHeight
local quadType = {}
local scrollSpeed = 100

function removeMobs()
	for k in pairs (mobTable) do
		mobTable[k] = nil
	end
end

function addMobs(mobs)
	local tempMobX, tempMobY = 100, 100
	for i=1, #mobs do
		for j=1, mobs[i][2] do
			loadMob(mobs[i][1], tempMobX, tempMobY)
			tempMobX = tempMobX + 100
			tempMobY = tempMobY + 100
		end
	end
end

function addEnvironment(quadType)
	local destructs = {}
	for columnIndex, column in ipairs(tileTable) do
		for rowIndex, char in ipairs(column) do 
			--print(quadType[rowIndex][5])
			local temp = tileTable[columnIndex][rowIndex]
			if temp[1] == 'c' or temp[1] == 'l' then -- if it's destructable
				-- create destructable object
				print(temp[1] .. " " .. temp[2] .. " " .. temp[3])
			end
		end
	end
end

function newMap(tileWidth, tileHeight, tilesetPath, tileString, quadInfo)
	removeMobs()
	
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

			tileTable[x][y] = { tile, x, y }
			x = x + 1
		end
		y= y + 1
	end
	mapWidth = (x - 1) * tileW
	mapHeight = (y - 1) * tileH

	addEnvironment(quadInfo)
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
					mapX = math.floor(tempx)
				end
			end
		elseif mX == "left" then
			if x > 0 then 
				tempx = mapX - (scrollSpeed * dt * modx)
				if 0 < (mapWidth + mapX - lg.getWidth()) then
					mapX = math.ceil(tempx)
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
					mapY = math.floor(tempy)
				end
			end
		elseif mY == "up" then
			if y > 0 then 
				tempy = mapY - (scrollSpeed * dt * mody)
				if 0 < (mapHeight + mapY - lg.getHeight()) then
					mapY = math.ceil(tempy)
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
	scrollSpeed = getSpeed(hero) - 30
	local loc = getLocation(hero)

	if loc.x < (mapHeight / 2) - (mapHeight / 8)  or loc.y > (mapHeight - (mapHeight / 2) + (mapHeight / 8)) then
		scrollSpeed = scrollSpeed - 30
	elseif loc.x < (mapWidth / 2) - (mapWidth / 8)  or loc.y > (mapWidth - (mapWidth / 2) + (mapWidth / 8)) then
		scrollSpeed = scrollSpeed - 30
	end

	if mY == "up" then
		if mapY < 0 then
			mapY = mapY + math.ceil(dt * (scrollSpeed - 0))
		end
	elseif mY == "down" then
		if 0 < (mapHeight + mapY - lg.getHeight()) then
			mapY = mapY - math.ceil(dt * (scrollSpeed - 0))
		end
	end

	if mX == "right" then
		if 0 < (mapWidth + mapX - lg.getWidth()) then
			mapX = mapX - math.ceil(dt * (scrollSpeed - 0))
		end
	elseif mX == "left" then
		if mapX < 0 then
			mapX = mapX + math.ceil(dt * (scrollSpeed - 0))
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

	if direction == "U" or direction == "D" then
		x = x - 48
		y = (mapHeight - y) - 48
	elseif direction == "L" or direction == "R" then
		x = (mapWidth - x) - 48
		y =  y - 48
	end

	local fx, fy = math.floor(x / tileW), math.floor(y / tileH)
	local cx, cy = math.ceil(x / tileW), math.ceil(y / tileH)

	local tempC = changeZero(cx, cy, fx, fy)

	return (tempC[1]*tileW)+16, (tempC[2]*tileH)+16
end

function checkTile(x, y, projectile)
	x = x + 16
	y = y + 16

	local fx, fy = math.floor(x / tileW), math.floor(y / tileH)
	local cx, cy = math.ceil(x / tileW), math.ceil(y / tileH)

	local tempC = changeZero(cx, cy, fx, fy)

	corners = { 
		tileTable[tempC[3]][tempC[4]][1],
		tileTable[tempC[1]][tempC[4]][1],
		tileTable[tempC[1]][tempC[2]][1],
		tileTable[tempC[3]][tempC[2]][1]
	}

	local result = true
	local teleport = 0

	for key,value in ipairs(corners) do
		for i=1, #quadType do
			if (quadType[i][1] == value) then
				local tps = { 'U', 'D', 'L', 'R' }
				result = quadType[i][4]
				teleport = quadType[i][1]
				
				if not projectile then
					for j=1, #tps do 
						if string.match(teleport, tps[j]) then
							transition(teleport, x, y, quadType[i][4])
							return
						end
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
			lg.draw(tileset, quads[char[1]], mapW, mapH )
		end
	end
end
