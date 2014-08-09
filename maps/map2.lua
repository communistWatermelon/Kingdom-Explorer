local tileString = [[
^#########UUUUU#######################^
^           $$       *                ^
^  *                                  ^
^              *                      ^
^                                     ^
^                                     ^
^      *                              ^
^                *                    ^
^                                     ^
^                                     ^
^          *                          ^
^                                     ^
^                                     ^
^   *                                 ^
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
	{ "$", 0, 0, true }		-- spawn point	
}

local mobs = { {"pawn", 3}, {"nerd", 1} } --define mobs by their name, and a number
newMap(32, 32,'/assets/countryside.png', tileString, quadInfo, mobs)