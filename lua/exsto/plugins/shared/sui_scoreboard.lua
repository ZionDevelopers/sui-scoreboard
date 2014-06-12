--[[

SUI Scoreboard v2.6 by .Z. Nexus is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
----------------------------------------------------------------------------------------------------------------------------
Copyright (c) 2014 .Z. Nexus <http://www.nexusbr.net> <http://steamcommunity.com/profiles/76561197983103320>

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/deed.en_US.
----------------------------------------------------------------------------------------------------------------------------
This Addon is based on the original SUI Scoreboard v2 developed by suicidal.banana.
Copyright only on the code that I wrote, my implementation and fixes and etc, The Initial version (v2) code still is from suicidal.banana.
----------------------------------------------------------------------------------------------------------------------------

$Id$
Version 2.6.2 - 12-06-2014 05:33 PM(UTC -03:00)

]]--

local PLUGIN = exsto.CreatePlugin()

PLUGIN:SetInfo({
	Name = "SUI Scoreboard v2.6 for Exsto",
	ID = "sui-scoreboard-v2-6",
	Desc = "SUI Scoreboard v2.6 ported for Exsto!",
	Owner = ".Z. Nexus"
})

function PLUGIN:Init()	
  function PLUGIN:ScoreboardShow()	
    return Scoreboard.Show()
  end
  
  function PLUGIN:ScoreboardHide()
    return Scoreboard.Hide()
  end
end

--- When the player joins the server we need to restore the NetworkedInt's
function PLUGIN:PlayerInitialSpawn( ply )
  Scoreboard.PlayerSpawn( ply )
end

PLUGIN:Register()