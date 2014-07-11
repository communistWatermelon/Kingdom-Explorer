local tileW, tileH, tileset, quads, tileTable
local quadType = {}

function newMap(tileWidth, tileHeight, tilesetPath, tileString, quadInfo)
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
end

function transition(direction, x, y)
	if direction == "u" then
		loadMap('/maps/' .. transitionCharacter(findSpawn(x, y)))
	elseif direction == "d" then
		loadMap('/maps/' .. transitionCharacter(findSpawn(x, y)))
	elseif direction == "l" then
		loadMap('/maps/' .. transitionCharacter(findSpawn(x, y)))
	elseif direction == "r" then
		loadMap('/maps/' .. transitionCharacter(findSpawn(x, y)))
	end
end

function findSpawn(x, y)
	x = (lg.getWidth() - x) - 32 
	y =  (lg.getHeight() - y) - 32
	local fx, fy = math.floor(x / tileW), math.floor(y / tileH)
	local cx, cy = math.ceil(x / tileW), math.ceil(y / tileH)

	corners = { 
		tileTable[fx][fy],
		tileTable[cx][fy],
		tileTable[cx][cy],
		tileTable[fx][cy]
	}

	local spawn = ""
	local sX = 0
	local sY = 0

	for key,value in ipairs(corners) do
		for i=1, #quadType do
			if (quadType[i][1] == value) then
				spawn = quadType[i][1]

				if spawn == "$" then
					sX = cx
					sY = cy
				end
			end
		end
	end
	return cx*tileW, cy*tileH

	-- find the spawn point opposite to the points you came in on

end

function checkTile(x, y)
	x = x + 32
	y = y + 32
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

				if teleport == "U" then
					transition('u', x, y, quadType[i][4])
					return
				--[[elseif teleport == "D" then
				--	transition('d', x, y, quadType[i][4])
			--		return
				elseif teleport == "R" then	
					transition('r', x, y, quadType[i][4])
					return
				elseif teleport == "L" then
					transition('l', x, y, quadType[i][4])
					return]]
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
			local x,y = (columnIndex - 1) * tileW, (rowIndex - 1) * tileH
			lg.draw(tileset, quads[char], x, y)
		end
	end
end
