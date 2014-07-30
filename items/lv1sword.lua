
-- each item should have its own lua file in the items folder
local img = love.graphics.newImage("items/swordanim.png")
function loadLv1Sword()
	sword = { atk = 1, sprite = lg.newImage("items/sword.png"), }
   	anim = newAnimation(img, 128, 128, 0.025, 9)
   	--anim:addFrame(1024, 0, 128, 128, 0)
   	anim:setMode("once")
   	anim:stop()
end

function useLv1Sword(x, y)
	-- uses the items on the target
	-- target example: useItem("sword", "mob1") -> attack mob1 with sword
	-- example two useItem("sword","cuttable_tree") -> cut down the tree
	--anim:draw(x, y)
	anim:play()
	anim:reset()
end

function animateLv1Sword(x, y, facing)
	anim:draw(x, y, facing, 1, 1, anim:getWidth()/2, anim:getHeight()/2)
end

function updateLv1Sword(dt)
	anim:update(dt)
end

function drawLv1Sword(x, y, facing)
	-- change this to the actual item
	lg.draw(sword.sprite, x, y)--, facing, 1, 1, sword.sprite:getWidth()/2, sword.sprite:getWidth()/2)
end
