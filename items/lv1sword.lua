
-- each item should have its own lua file in the items folder
function loadLv1Sword()
	sword = { atk = 1, sprite = lg.newImage("items/sword.png"), }
	local img  = love.graphics.newImage("assets/explode.png")
   	anim = newAnimation(img, 96, 96, 0.1, 0)
   	anim:setMode("once")
   	anim:stop()
end

function useLv1Sword(target)
	-- uses the items on the target
	-- target example: useItem("sword", "mob1") -> attack mob1 with sword
	-- example two useItem("sword","cuttable_tree") -> cut down the tree
	anim:draw(100, 100)
	anim:play()
	anim:reset()
end

function updateLv1Sword(dt)
	anim:update(dt)
end

function drawLv1Sword(x, y, facing)
	-- change this to the actual item
	--lg.rectangle("fill", x, y, 5, 60)
	--lg.push()
	--lg.translate(0, 16)
	lg.draw(sword.sprite, x, y, facing, 1, 1, sword.sprite:getWidth()/2, sword.sprite:getWidth()/2)
	anim:draw(100, 100)
	--lg.pop()
end
