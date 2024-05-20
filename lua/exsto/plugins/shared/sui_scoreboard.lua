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

local PLUGIN = exsto.CreatePlugin()

PLUGIN:SetInfo({
	Name = "SUI Scoreboard v2.6 for Exsto",
	ID = "sui-scoreboard-v2-6",
	Desc = "SUI Scoreboard v2.6 ported for Exsto!",
	Owner = "Dathus [BR]"
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

if CLIENT then
  -- Kick player
  Scoreboard.kick = function (ply)
    if ply:IsValid() then 
      LocalPlayer():ConCommand( "exsto kick \"".. ply:Nick().. "\" \"Kicked By Administrator\"" )     
    end
  end

  -- Permanent ban player
  Scoreboard.pBan = function(ply) 
    if ply:IsValid() then 
      LocalPlayer():ConCommand( "exsto ban \"".. ply:Nick().. "\" 0 \" Banned permanently by Administrator\"" )   
    end
  end

  -- Ban player
  Scoreboard.ban = function(ply) 
    if ply:IsValid() then
      LocalPlayer():ConCommand( "exsto ban \"".. ply:Nick().. "\" 60 \" Banned for 1 hour by Administrator\"" )    
    end
  end

  -- Get player's Team Name
  Scoreboard.getGroup = function (ply)
    return exsto.Ranks[ply:GetRank()].Name  
  end

  -- Get player's Played time
  Scoreboard.getPlayerTime = function (ply)
    -- Get Time
    return ply:GetNWInt( "Time_Fixed" ) + (CurTime() - ply:GetNWInt( "Time_Join" ))
  end
elseif SERVER then
  Scoreboard.SendColor = function (ply)   
    tColor = team.GetColor( ply:Team())     
    
    net.Start("SUIScoreboardPlayerColor")
    net.WriteTable(tColor)
    net.Send(ply)
  end
end

PLUGIN:Register()