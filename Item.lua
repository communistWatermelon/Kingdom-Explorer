require("items/lv1Sword")
require("items/bow")
-- these are generic versions of the item functions
-- pass the item name to the function, and that items function will be called
-- ex. loadItem(sword, x, y) -> loadSword(x, y)

function loadItem(item, x, y)
	local fun = "load" .. item
	_G[fun](x, y)
end

function useItem(item, x, y)
	local fun="use" .. item
	_G[fun](x, y)
end

function updateItem(dt)
	tempEquipped = getEquipped()
	if tempEquipped ~= nil then
		local fun = "update" ..  getEquipped() 
		_G[fun](dt)
	end
end

function animateEquipped(x, y)
	local fun = "animate" ..  getEquipped() 
	_G[fun](x, y)
end

function drawItems(items, x, y)
	for item in items do
		drawItem(item, x, y)
	end
end

function drawItem(item, x, y)
	local fun="draw" .. item
	_G[fun](x, y)
end
