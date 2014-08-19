local tileString = [[
^########UU#############^
^                    *  ^
^  *                    ^
^              *        ^
^                       ^
^    ##  ^##  ^## ^ ^   ^
^   ^  ^ ^  ^ ^   ^ ^   ^
^   ^  ^ ^ *# ^   ^ ^   ^
^   ^  ^ ^##  ^## # #   ^
^   ^  ^ ^  ^ ^    ^  * R
^ * ^  ^ ^  ^ ^    ^    R
^   #  # ^* # ^  * ^    ^
^    ##  ###  ###  #    ^
^                       ^
^   *****************   ^
^                       ^
^  *                  * ^
##########DD#############
]]

local quadInfo = {
	{ ' ', 0, 0, true }, 	-- grass
	{ '#', 32, 0, false }, 	-- box
	{ '*', 0, 32, true }, 	-- flowers
	{ '^', 32, 32, false },	-- boxTop
	{ "D", 0, 0, "map2.lua" },-- teleport
	{ "U", 0, 0, "map1.lua" },-- teleport
	{ "R", 0, 0, "coredump.lua" },-- teleport
	{ "$", 0, 0, true }	-- spawn point
}

newMap(32, 32,'/assets/countryside.png', tileString, quadInfo)