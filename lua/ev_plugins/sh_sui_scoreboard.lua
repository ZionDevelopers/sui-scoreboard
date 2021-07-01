--[[

SUI Scoreboard v2.6 by .Z. Dathus [BR] is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
----------------------------------------------------------------------------------------------------------------------------
Copyright (c) 2014 - 2021 .Z. Dathus [BR] <http://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/deed.en_US.
----------------------------------------------------------------------------------------------------------------------------
This Addon is based on the original SUI Scoreboard v2 developed by suicidal.banana.
Copyright only on the code that I wrote, my implementation and fixes and etc, The Initial version (v2) code still is from suicidal.banana.
----------------------------------------------------------------------------------------------------------------------------

$Id$
Version 2.6.3 - 2021-07-01 06:14 PM(UTC -03:00)

]]--

local PLUGIN = {}
PLUGIN.Title = "SUI Scoreboard v2.6 for Evolve"
PLUGIN.Description = "SUI Scoreboard v2.6 ported for Evolve!"
PLUGIN.Author = ".Z. Nexus"

function PLUGIN:ScoreboardShow()  
  return Scoreboard.Show()
end

function PLUGIN:ScoreboardHide()
  return Scoreboard.Hide()
end

--- When the player joins the server we need to restore the NetworkedInt's
function PLUGIN:PlayerInitialSpawn( ply )
  Scoreboard.PlayerSpawn( ply )
end

evolve:RegisterPlugin( PLUGIN )