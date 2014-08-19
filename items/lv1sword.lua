local path = "items/lv1sword/"
-- each item should have its own lua file in the items folder
function loadLv1Sword()
	local img = love.graphics.newImage(path .. "swordanim.png")
   	local anim = newAnimation(img, 128, 128, 0.025, 9)
   	anim:setMode("once")
   	anim:stop()

   	sword = { 	stats = { atk = 50 },
				draw = { sprite = lg.newImage(path .. "sword.png"), attack = anim },
				size = { width = 32, height = 32},
				target = { mobTable },
				destroys = { "grass" }
			}
end

function useLv1Sword(x, y)
	local width, height, facing = getWidth(sword), getHeight(sword), getFacing(hero)
	attackCollision(sword, x, y, width, height, facing)
	getAnim(sword, "attack"):play()
	getAnim(sword, "attack"):reset()
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
