local path = "items/bow/"

local arrow = {}

function loadBow()
	local img = love.graphics.newImage(path .. "bowanim.png")
   	local anim = newAnimation(img, 128, 128, 0.04, 9)
   	anim:setMode("once")
   	anim:stop()
	
	bow = { stats = { atk = 70, speed = 300 },
			draw = { sprite = lg.newImage(path .. "bow.png"), projectile = lg.newImage(path .. "arrow.png"), attack = anim },
			size = { width = 32, height = 5}
		}
end

function useBow(x, y)
	fireProjectile(bow, hero, x, y, getFacing(hero), getAttack(bow), getSpeed(bow), getAnimWidth(bow, "projectile"), getAnimHeight(bow, "projectile"), true)
	getAnim(bow, "attack"):play()
	getAnim(bow, "attack"):reset()
end

function animateBow(x, y)
	getAnim(bow, "attack"):draw(x, y, getFacing(hero), 1, 1, getAnimWidth(bow, "attack")/2, getAnimHeight(bow, "attack")/2)
end

function updateBow(dt, x, y)
	getAnim(bow,"attack"):update(dt)
end

function drawBow(x, y)
	lg.draw(getAnim(bow, "sprite"), x-8, y)
end
