--[[

SUI Scoreboard v2.6 by .Ż. Nexus ▪ bzg® is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
----------------------------------------------------------------------------------------------------------------------------
Copyright (c) 2014 .Ż. Nexus ▪ bzg® <http://www.nexusbr.net> <http://steamcommunity.com/profiles/76561197983103320>

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/deed.en_US.
----------------------------------------------------------------------------------------------------------------------------
This Addon is based on the original SUI Scoreboard v2 developed by suicidal.banana.
Copyright only on the code that I wrote, my implementation and fixes and etc, The Initial version (v2) code still is from suicidal.banana.
----------------------------------------------------------------------------------------------------------------------------

$Id$
Version 2.6.1 - 15-05-2014 09:27 PM (UTC -03:00)

]]--

-- Setup Class
Scoreboard = {}

if SERVER then
  -- For Players to Download this addon from Workshop.
  resource.AddWorkshop("160121673")
  -- Send required files to client
  AddCSLuaFile()
  AddCSLuaFile("sui_scoreboard/client/scoreboard.lua")
  AddCSLuaFile("sui_scoreboard/client/admin_buttons.lua")
  AddCSLuaFile("sui_scoreboard/client/tooltips.lua")
  AddCSLuaFile("sui_scoreboard/client/player_frame.lua")
  AddCSLuaFile("sui_scoreboard/client/player_infocard.lua")
  AddCSLuaFile("sui_scoreboard/client/player_row.lua")
  AddCSLuaFile("sui_scoreboard/client/scoreboard.lua")
  AddCSLuaFile("sui_scoreboard/client/vote_button.lua")
  AddCSLuaFile("sui_scoreboard/client/library.lua")

  include( "sui_scoreboard/server/rating.lua" )
  include( "sui_scoreboard/server/library.lua" )
else
  Scoreboard.vgui = nil
  include( "sui_scoreboard/client/library.lua" )
  include( "sui_scoreboard/client/scoreboard.lua" )
end