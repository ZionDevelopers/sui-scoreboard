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
Version 2.7 - 2024-05-19 10:47 AM(UTC -03:00)

]]--

hook.Add("ScoreboardShow","SUISCOREBOARD-Show", Scoreboard.Show)
hook.Add("ScoreboardHide", "SUISCOREBOARD-Hide", Scoreboard.Hide)

-- Kick player
Scoreboard.kick = function (ply)
    if ply:IsValid() then     
        LocalPlayer():ConCommand( "hg kick \"" .. ply:SteamID() .. "\" \"Kicked By Administrator\"" )
    end
end

-- Permanent ban player
Scoreboard.pBan = function(ply) 
    if ply:IsValid() then       
        LocalPlayer():ConCommand( "hg ban \"" .. ply:SteamID() .. "\" 0 \"Quick ban via scoreboard\"" )     
    end
end

-- Ban player
Scoreboard.ban = function(ply) 
    if ply:IsValid() then       
        LocalPlayer():ConCommand( "hg ban \"" .. ply:SteamID() .. "\" 60 \"Quick ban via scoreboard\"" )     
    end
end
   
-- Get player's Team Name
Scoreboard.getGroup = function (ply)
    return team.GetName(ply:Team())   
end

-- Get player's Played time
Scoreboard.getPlayerTime = function (ply)
    return ply:GetNWInt("ranktime", 0)   
end
  