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
Version 2.7 - 2024-05-19 10:24 PM (UTC -03:00)

]]--

util.AddNetworkString( "SUIScoreboardPlayerConnecting" )

--- When the player joins the server we need to restore the NetworkedInt's
Scoreboard.PlayerSpawn = function ( ply )
  timer.Simple( 5, function() Scoreboard.UpdatePlayerRatings( ply ) end) -- Wait a few seconds so we avoid timeouts.
  timer.Simple( 5, function() Scoreboard.SendColor(ply) end)
end

gameevent.Listen( "player_connect" )
hook.Add( "player_connect", "suiscoreboardPlayerConnected", function( data )
	local name = data.name			-- Same as Player:Nick()
	local steamid = data.networkid	-- Same as Player:SteamID()
	local ip = data.address			-- Same as Player:IPAddress()
	local id = data.userid			-- Same as Player:UserID()
	local bot = data.bot			-- Same as Player:IsBot()
	local index = data.index		-- Same as Player:EntIndex()

	net.Start("SUIScoreboardPlayerConnecting")
	net.WriteInt(id, 32)
	net.WriteString(name)
	net.WriteString(steamid)
	net.WriteString(util.SteamIDTo64(steamid))
	net.Broadcast()
end )