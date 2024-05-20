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

if SERVER then
  AddCSLuaFile()
  hook.Add("PlayerInitialSpawn", "SUISCOREBOARD-Spawn", Scoreboard.PlayerSpawn)
  Scoreboard.SendColor = function (ply)   
    tColor = team.GetColor( ply:Team())   

    net.Start("SUIScoreboardPlayerColor")
    net.WriteTable(tColor)
    net.Send(ply)
  end
elseif CLIENT then
  hook.Add("ScoreboardShow","SUISCOREBOARD-Show", Scoreboard.Show)
  hook.Add("ScoreboardHide", "SUISCOREBOARD-Hide", Scoreboard.Hide)
  -- Kick player
  Scoreboard.kick = function (ply)
    if ply:IsValid() then      
      LocalPlayer():ConCommand( "ulx kick \"".. ply:Nick().. "\" \"Kicked By Administrator\"" )    
    end
  end

  -- Permanent ban player
  Scoreboard.pBan = function(ply) 
    if ply:IsValid() then 
      LocalPlayer():ConCommand( "ulx ban \"".. ply:Nick().. "\" 0 \" Banned permanently by Administrator\"" ) 
    end
  end

  -- Ban player
  Scoreboard.ban = function(ply) 
    if ply:IsValid() then
      LocalPlayer():ConCommand( "ulx ban \"".. ply:Nick().. "\" 60 \" Banned for 1 hour by Administrator\"" )    
    end
  end

  -- Get XGUI Team Name by group
  Scoreboard.getXGUITeamName = function (check_group)
    for _, team in ipairs( ulx.teams ) do
      for _, group in ipairs( team.groups ) do
        if group == check_group then
          return team.name
        end
      end
    end
    return check_group
  end

  -- Get player's Team Name
  Scoreboard.getGroup = function (ply)
    return Scoreboard.getXGUITeamName(ply:GetUserGroup())    
  end

  -- Get player's Played time
  Scoreboard.getPlayerTime = function (ply)
    -- Check if ULX and uTime is Installed
    if ply:GetNWInt( "TotalUTime", -1 ) ~= -1 then
      -- Get player's played time
      return math.floor((ply:GetUTime() + CurTime() - ply:GetUTimeStart()))
    else
      -- Get Time
      return ply:GetNWInt( "Time_Fixed" ) + (CurTime() - ply:GetNWInt( "Time_Join" ))
    end
  end

end