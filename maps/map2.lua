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
	{ "$", 32, 32, true }		-- spawn point
}

newMap(32, 32,'/assets/countryside.png', tileString, quadInfo)