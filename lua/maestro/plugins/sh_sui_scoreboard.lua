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
Version 2.7 - 2023-06-05 8:00 PM(UTC -03:00)

]]--

if SERVER then
  AddCSLuaFile()
  hook.Add("PlayerInitialSpawn", "SUISCOREBOARD-Spawn", Scoreboard.PlayerSpawn)

  Scoreboard.SendColor = function (ply)   
    tColor = maestro.rankcolor(maestro.userrank(ply)) or team.GetColor(ply:Team())
        
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
      LocalPlayer():ConCommand( "ms kick \"$" .. ply:SteamID() .. "\" \"Kicked By Administrator\"" )   
    end
  end

  -- Permanent ban player
  Scoreboard.pBan = function(ply) 
    if ply:IsValid() then 
      LocalPlayer():ConCommand( "ms ban \"$" .. ply:SteamID() .. "\" 0 \"Banned permanently by Administrator\"" )     
    end
  end

  -- Ban player
  Scoreboard.ban = function(ply) 
    if ply:IsValid() then
      LocalPlayer():ConCommand( "ms ban \"$" .. ply:SteamID() .. "\" 1h \"Banned permanently by Administrator\"" )   
    end
  end
  -- Get player's Team Name
  Scoreboard.getGroup = function (ply)
    return maestro.userrank(ply)   
  end
  -- Get player's Played time
  Scoreboard.getPlayerTime = function (ply)
   if maestro_promote then
      return CurTime() - ply:GetNWInt("maestro-promote", CurTime())
    else
      -- Get Time
      return ply:GetNWInt( "Time_Fixed" ) + (CurTime() - ply:GetNWInt( "Time_Join" ))
    end
  end

end
