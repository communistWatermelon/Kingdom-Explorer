local tileString = [[
#########################
#                #      #
#  L[]R   L[]R   # L[]R #
#  L()R   L()R   # L()R #
#                #      #
#                ###  ###
#  L[]R   L[]R          #
   L()R   L()R    L[]R  #
                  L()R  #
                        #
   L[]R   L[]R          #
   L()R   L()R   ###  ###
#                #LL  RR#
#                #LL  RR#
#  L[]R   L[]R   #LL  RR#
#  L()R   L()R   #LL  RR#
#                #LL  RR#
#########################
]]

local quadInfo = { 
  { ' ',  0,  0, true}, -- floor 
  { '[', 32,  0, false}, -- table top left
  { ']', 64,  0, false}, -- table top right
  { '(', 32, 32, false}, -- table bottom left
  { ')', 64, 32, false}, -- table bottom right
  { 'L',  0, 32, false }, -- chair on the left
  { 'R', 96, 32, false }, -- chair on the right
  { '#', 96,  0, false }  -- bricks
}

newMap(32, 32,'/assets/resto.png', tileString, quadInfo)