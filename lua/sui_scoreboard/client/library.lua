--[[

SUI Scoreboard v2.6 by Dathus [BR] is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
----------------------------------------------------------------------------------------------------------------------------
Copyright (c) 2014 - 2024 Dathus [BR] <http://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit <http://creativecommons.org/licenses/by-nc-sa/4.0/deed.en_US> .
----------------------------------------------------------------------------------------------------------------------------
This Addon is based on the original SUI Scoreboard v2 developed by suicidal.banana.
Copyright only on the code that I wrote, my implementation and fixes and etc, The Initial version (v2) code still is from suicidal.banana.
----------------------------------------------------------------------------------------------------------------------------

$Id$
Version 2.7 - 2023-06-06 8:00 PM(UTC -03:00)

]]--

-- Create Scoreboard VGUI
Scoreboard.CreateVGUI = function()
  if Scoreboard.vgui then      
      Scoreboard.vgui:Remove()
      Scoreboard.vgui = nil  
  end

  Scoreboard.vgui = vgui.Create( "suiscoreboard" )
  return true
end

-- Show Scoreboard
Scoreboard.Show = function ()
  if not Scoreboard.vgui then
    Scoreboard.CreateVGUI()
  end

  GAMEMODE.ShowScoreboard = true
  gui.EnableScreenClicker( true )

  Scoreboard.vgui:SetVisible( true )
  Scoreboard.vgui:UpdateScoreboard( true )

  return true
end

-- Hide Scoreboard
Scoreboard.Hide = function ()
  GAMEMODE.ShowScoreboard = false
  gui.EnableScreenClicker( false )

  if Scoreboard.vgui ~= nil then
    Scoreboard.vgui:SetVisible( false )
  end

  return true
end

--- Format time
Scoreboard.formatTime = function (time)
  local ttime = time or 0
  local s = ttime % 60
  ttime = math.floor(ttime / 60)
  local m = ttime % 60
  ttime = math.floor(ttime / 60)
  local h = ttime % 24
  ttime = math.floor( ttime / 24 )
  local d = ttime % 7
  local w = math.floor(ttime / 7)
  local str = ""
  str = (w>0 and w.."w " or "")..(d>0 and d.."d " or "")
  
  return string.format( str.."%02ih %02im %02is", h, m, s )
end 

-- Get Local Player Color
Scoreboard.netGetPlayerColor = function(ply)
  Scoreboard.playerColor = net.ReadTable()
end
