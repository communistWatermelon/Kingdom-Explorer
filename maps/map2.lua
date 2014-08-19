local tileString = [[
^#########UUUUU#######################^
^                    *                ^
^  *                                  ^
^              *                      ^
^                                     ^
^                      l              ^
^      *               lll            ^
^    l           *     l              ^
^                                     ^
^                                     ^
^    c     *                          ^
^                                     ^
^                                     ^
^   *         c                       ^
^                                     ^
^        *                            ^
^                                     ^
######################################^
]]

local quadInfo = {
	{ ' ', 0, 0, true }, 	-- grass
	{ '#', 32, 0, false }, 	-- box
	{ '*', 0, 32, true }, 	-- flowers
	{ '^', 32, 32, false }, -- boxTop
	{ "U", 0, 0, "map1.lua" },	-- teleport
	{ "$", 0, 0, true },	-- spawn point
	{ "c", 0, 0, false, true }, 	-- rock
	{ "l", 0, 0, true, true } 	-- long grass
}

local mobs = { {"pawn", 3}, {"nerd", 1} } --define mobs by their name, and a number
newMap(32, 32,'/assets/countryside.png', tileString, quadInfo)
addMobs(mobs)