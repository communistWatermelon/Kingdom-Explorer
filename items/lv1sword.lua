
-- each item should have its own lua file in the items folder
function loadLv1Sword()
	sword = { atk = 50, sprite = lg.newImage("items/sword.png"), }
	local img = love.graphics.newImage("items/swordAnim.png")
   	swordAnim = newAnimation(img, 128, 128, 0.025, 9)
   	swordAnim:setMode("once")
   	swordAnim:stop()
end

function useLv1Sword(x, y)
	Lv1SwordCollision(x, y)
	swordAnim:play()
	swordAnim:reset()
end

function Lv1SwordCollision(x, y)
	local facing = getFacing()
	local mobx, moby = getMobLocation()
	local swordx, swordy
	local swordw, swordh

	if facing == 0 then
		swordx = x
		swordy = y - 48
		swordw = 48
		swordh = 32 
	elseif facing < 0 then
		swordx = x - 48
		swordy = y
		swordw = 32
		swordh = 48 
	elseif facing > 0 and facing < 3 then
		swordx = x + 48
		swordy = y
		swordw = 32
		swordh = 48 
	elseif facing > 3 then
		swordx = x
		swordy = y + 48
		swordw = 48
		swordh = 32 
	end

		if mobx < swordx + swordw and
		swordx < mobx + mobw and
		moby < swordy + swordh and
		swordy < moby + mobh then
			changeMobHealth(-sword.atk)
	end
end

function animateLv1Sword(x, y)
	swordAnim:draw(x, y, getFacing(), 1, 1, swordAnim:getWidth()/2, swordAnim:getHeight()/2)
end

function updateLv1Sword(dt)
	swordAnim:update(dt)
end

function drawLv1Sword(x, y)
	lg.draw(sword.sprite, x, y)
end


