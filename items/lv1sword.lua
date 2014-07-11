-- each item should have its own lua file in the items folder
function loadLvl1Sword()
	sword = { atk = 1 }
end

function useLvl1Sword(item, target)
	-- uses the items on the target
	-- target example: useItem("sword", "mob1") -> attack mob1 with sword
	-- example two useItem("sword","cuttable_tree") -> cut down the tree
end

function drawLvl1Sword(item, x, y)
	-- change this to the actual item
	lg.rectangle("fill", x, y, 5, 60)
end
