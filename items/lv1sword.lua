local path = "items/lv1sword/"
-- each item should have its own lua file in the items folder
function loadLv1Sword()
	sword = { atk = 50, sprite = lg.newImage(path .. "sword.png"), }
	local img = love.graphics.newImage(path .. "swordanim.png")
   	local anim = newAnimation(img, 128, 128, 0.025, 9)
   	anim:setMode("once")
   	anim:stop()


   	sword = { stats = { atk = 50 },
			draw = { sprite = lg.newImage(path .. "sword.png"), attack = anim },
			size = { width = 32, height = 32}
		}
end

function useLv1Sword(x, y)
	Lv1SwordCollision(x, y)
	getAnim(sword, "attack"):play()
	getAnim(sword, "attack"):reset()
end

function Lv1SwordCollision(x, y)
	local facing = getFacing(hero)
	local mobSize = getSize(mob)
	local swordx, swordy
	local swordw, swordh

	for i=1, #mobTable do
		local mobLoc = getLocation(mobTable[i])
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

			if mobLoc.x < swordx + swordw and
			swordx < mobLoc.x + mobSize.width and
			mobLoc.y < swordy + swordh and
			swordy < mobLoc.y + mobSize.height then
				changeHealth(mobTable[i], -getAttack(sword))
		end
	end
end

function animateLv1Sword(x, y)
	getAnim(sword, "attack"):draw(x, y, getFacing(hero), 1, 1, getAnimWidth(sword, "attack")/2, getAnimHeight(sword, "attack")/2)
end

function updateLv1Sword(dt)
	getAnim(sword, "attack"):update(dt)
end

function drawLv1Sword(x, y)
	lg.draw(getAnim(sword, "sprite"), x, y)
end
