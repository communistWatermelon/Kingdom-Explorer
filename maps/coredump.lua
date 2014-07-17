local tileString = [[
############     ########
# AAA^AAAAAA      # ^^^ #
# |||@||||||      # @@@ #
#                 #     #
# AAAAAAA^AA      ### ###
# |||||||@||        # # #
#                   * * #
# *                 l l #
# l                      
L$       ^               
L       @                
# *                      
# l                     #
#                       #
# AAAAA^AAA^AAA^    ^^  #
# |||||@            @@  #
#                       #
#######           #######
]]

local quadInfo = { 
  { ' ',  0,  0, true}, -- gray floor
  { '#',  0, 32, true }, -- brick wall
  { '^', 32,  0, true }, -- mainframe 1 top
  { '@', 32, 32, true }, -- mainframe 1 bottom
  { 'A', 64,  0, true }, -- mainframe 2 top
  { '|', 64, 32, true }, -- maingrame 2 bottom
  { '*', 96,  0, true }, -- plant top
  { 'l', 96, 32, true },  -- plant bottom
  { 'L', 0, 0, "map1.lua" },  -- left teleport
  { '$', 0, 0, true }
}

newMap(32,32,'/assets/lab.png', tileString, quadInfo)