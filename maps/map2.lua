local tileString = [[
^######           ######^
^                    *  ^
^  *                    ^
^              *        ^
^                       ^
^                       ^
^      *                ^
^                *      ^
^                       ^
^                       ^
^          *            ^
^                       ^
^                       ^
^   *                   ^
^                       ^
^        *              ^
^                       ^
#########################
]]

local quadInfo = {
	{ ' ', 0, 0, true }, 	-- grass
	{ '#', 32, 0, false }, 	-- box
	{ '*', 0, 32, true }, 	-- flowers
	{ '^', 32, 32, false } 	-- boxTop
}

newMap(32, 32,'/assets/countryside.png', tileString, quadInfo)