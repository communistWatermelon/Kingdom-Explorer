-- temp function
function loadSword()
	sword = { atk = 1 }
end

function loadItem(item, x, y)
	-- loads item 
end

function consumeItem()
	--check if consumable
		-- if consumable, add effects
		-- if only 1 of item
			--remove
		-- else remove 1 from stack
end

function useItem()

end

function drawItems(items)
	-- loop through all items on screen, draw them
end

function drawItem(item, x, y)
	-- change this to the actual item
	love.graphics.rectangle("fill", x, y, 5, 60)
end
