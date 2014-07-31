
-- each item should have its own lua file in the items folder
function loadLv1Sword()
	sword = { atk = 1, sprite = lg.newImage("items/sword.png"), }
	local img = love.graphics.newImage("items/swordanim.png")
   	anim = newAnimation(img, 128, 128, 0.025, 9)
   	anim:setMode("once")
   	anim:stop()
end

function useLv1Sword(x, y)
	anim:play()
	anim:reset()
end

function animateLv1Sword(x, y)
	anim:draw(x, y, getFacing(), 1, 1, anim:getWidth()/2, anim:getHeight()/2)
end

function updateLv1Sword(dt)
	anim:update(dt)
end

function drawLv1Sword(x, y)
	lg.draw(sword.sprite, x, y)
end


