local tileW, tileH, tileset, quads, tileTable
local quadType = {}

function newMap(tileWidth, tileHeight, tilesetPath, tileString, quadInfo)
	tileW = tileWidth
	tileH = tileHeight
	tileset = love.graphics.newImage(tilesetPath)

	local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()

	quads = {}
	tileTable = {}

	quadType = quadInfo
	for _, info in ipairs(quadInfo) do
		quads[info[1]] = love.graphics.newQuad(info[2], info[3], tileW,  tileH, tilesetW, tilesetH)
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
	print("Transitioning: " .. direction)
	if direction == "u" then
		transitionCharacter(x, 576 - y)
		loadMap('/maps/map1.lua')
	elseif direction == "d" then
		transitionCharacter(x, 10)
		loadMap('/maps/map2.lua')
	elseif direction == "l" then
		transitionCharacter(800 - x, y)
		loadMap('/maps/coredump.lua')
	else
		transitionCharacter(10, y)
		loadMap('/maps/chez-peter.lua')
	end
	
end

function checkTile(x, y)

	x = x + 32
	y = y + 32
	local fx, fy = math.floor(x / tileW), math.floor(y / tileH)
	local cx, cy = math.ceil(x / tileW), math.ceil(y / tileH)

	print("f:" .. fy)
	print("c:" .. cy)

	if fx == 0 then
		transition("l", x, y)
		return false
	elseif fy == 0 then
		transition("u", x, y)
		return false
	elseif cx == 26 then
		transition("r", x, y)
		return false
	elseif cy == 19 then
		transition("d", x, y)
		return false
	end

	corners = { 
		tileTable[fx][fy],
		tileTable[cx][fy],
		tileTable[cx][cy],
		tileTable[fx][cy]
	}

	local result = true
	for key,value in ipairs(corners) do
		for i=1, #quadType do
			if (quadType[i][1] == value) then
				result = quadType[i][4]

				if (not result) then
					return result
				end
			end
		end
	end

	return result
end

function loadMap(path)
	local f = love.filesystem.load(path) -- attention! extra parenthesis
	f()
end

function drawMap()
for columnIndex, column in ipairs(tileTable) do
		for rowIndex, char in ipairs(column) do 
			local x,y = (columnIndex - 1) * tileW, (rowIndex - 1) * tileH
			love.graphics.draw(tileset, quads[char], x, y)
		end
	end
end
